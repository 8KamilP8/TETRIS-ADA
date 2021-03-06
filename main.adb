with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Real_Time; use Ada.Real_Time;
with board; use board;
with blocks; use blocks;
with Screen; use Screen;
with buff; use buff;
with Ada.Synchronous_Task_Control; use Ada.Synchronous_Task_Control;
procedure Main is
   task GameOverTask is
      entry Over;
   end GameOverTask;
   type ActiveBlock is record
      origin : Point;
      shape : BlockPoints;
   end record;
   Period : Ada.Real_Time.Time_Span := Ada.Real_Time.Milliseconds(50);
   Next_Time : Ada.Real_Time.Time;
   currentBlock : ActiveBlock := ((0,0),((0, 0), (0, 0), (0, 0), (0, 0)));
   score : Integer := 0;

   linesToSpeedUp : Integer := 10;
   gameOver : Boolean := False;
   StopInput : Boolean := True;
   ReadingInput : Boolean := False;
   procedure Sort(Tab : in out IntArray) is
      k : Integer;
      KEY : Integer;
   begin
      for i in 2..Tab'Last loop
         KEY := Tab(i);
         k := i-1;
         while (k >= 1 and Tab(k) < KEY) loop
            Tab(k+1) := Tab(k);
            k := k -1;
            exit when k < 1;
         end loop;
         Tab(k+1) := KEY;
      end loop;
   end Sort;
   task Gravity is
      entry Start;
   end Gravity;
   task body Gravity is
      newBlock : BlockTypes;
      newNext : BlockTypes;
      linesToClear : IntArray(1..4) := (others => -1);
      lineCounter : Integer := 1;
      clear : Boolean := False;

   begin
      loop
         accept Start;
         Next_Time := Ada.Real_Time.Clock;

         loop
            delay until Next_Time;
            if MoveBlock(currentBlock.origin,(0,1),currentBlock.shape) then
               ScreenDisplay.DisplayBoard(currentBlock.shape,currentBlock.origin);
            else
               -- exit when one or more blockpoints of currentBlock is less than 1
               clear := False;
               linesToClear := (others => -1);
               lineCounter := 1;
               for i in Integer range 1..4 loop
                  if currentBlock.origin.y + currentBlock.shape(i).y < 1 then
                     gameOver := True;

                  else
                     board.boardElements(currentBlock.origin.x + currentBlock.shape(i).x ,currentBlock.origin.y + currentBlock.shape(i).y) := 1;
                     if(board.CheckClear(currentBlock.origin.y + currentBlock.shape(i).y)) then
                        clear := True;
                        for k in Integer range linesToClear'First..linesToClear'Last loop
                           if linesToClear(k) = currentBlock.origin.y + currentBlock.shape(i).y then
                              clear := False;
                           end if;
                        end loop;
                        if clear then
                           linesToClear(lineCounter) := currentBlock.origin.y + currentBlock.shape(i).y;
                           lineCounter := lineCounter+1;
                        end if;
                     end if;
                  end if;
               end loop;
               if gameOver then
                  ScreenDisplay.DisplayBoardWithoutActiveBlock;
                  GameOverTask.Over;
                  exit when gameOver;
               else

                  Sort(linesToClear);
                  if lineCounter = 5 then
                     score := score+1000;
                  elsif lineCounter = 4 then
                     score := score+500;
                  else
                     score := score+(lineCounter-1)*100;
                  end if;
                  if lineCounter > 1 then
                     ScreenDisplay.DisplayScore(score);
                  end if;
                  board.ClearLines(linesToClear);
                  Buffer.get(newBlock);
                  linesToSpeedUp := linesToSpeedUp - lineCounter +1;
                  if linesToSpeedUp <= 0 then
                     linesToSpeedUp := 10 + linesToSpeedUp;
                     Period := Period - Ada.Real_Time.Milliseconds(20);
                  end if;
                  Buffer.preview(newNext);
                  ScreenDisplay.DisplayNext(newNext);
                  currentBlock.shape := blockArr(newBlock);
                  currentBlock.origin := (5,0);
               end if;
            end if;
            Next_Time := Next_Time + Period;
            exit when gameOver;
         end loop;
      end loop;
   end Gravity;


   task InputReciever is
      entry Get(key : in Character);
      entry ExitSignal;
   end InputReciever;
   task body InputReciever is
   begin
      loop
         select
            accept Get(key: in Character) do
               if key = 'a' or key = 'A' then
                  if blocks.MoveBlock(currentBlock.origin,(-1,0),currentBlock.shape) then
                     ScreenDisplay.DisplayBoard(currentBlock.shape,currentBlock.origin);
                  end if;
               elsif key = 'd' or key = 'D' then
                  if blocks.MoveBlock(currentBlock.origin,(1,0),currentBlock.shape) then
                     ScreenDisplay.DisplayBoard(currentBlock.shape,currentBlock.origin);
                  end if;
               elsif key = 'e' or key = 'E' then
                  if blocks.RotateBlock(currentBlock.origin,Right,currentBlock.shape) then
                     ScreenDisplay.DisplayBoard(currentBlock.shape,currentBlock.origin);
                  end if;
               elsif key = 'q' or key = 'Q' then
                  if blocks.RotateBlock(currentBlock.origin,Left,currentBlock.shape) then
                     ScreenDisplay.DisplayBoard(currentBlock.shape,currentBlock.origin);
                  end if;
               end if;
            end Get;
         or
            accept ExitSignal;
            exit;
         end select;
      end loop;
   end InputReciever;
   task StartGame is

      entry Start;
   end StartGame;
   task GameInput is
      entry Start;
   end GameInput;
   task body StartGame is
      firstBlocks : BlockTypes;
   begin
      loop
         accept Start;
         Next_Time := Ada.Real_Time.Clock;
         Period := Ada.Real_Time.Milliseconds(200);
         score := 0;
         gameOver := False;
         linesToSpeedUp := 10;
         currentBlock.origin := (5,-1);
         Clear_Screen;
         Buffer.get(firstBlocks);
         currentBlock.shape := blockArr(firstBlocks);


         ScreenDisplay.DisplayScore(score);
         Buffer.preview(firstBlocks);
         ScreenDisplay.DisplayNext(firstBlocks);
         StopInput := False;
         GameInput.start;
         Gravity.Start;
      end loop;
   end StartGame;
   procedure WelcomeScreen is
      Answer : Character;
   begin
      StopInput := True;
      Set_Foreground (White);
      Set_Background (Black);
      Clear_Screen;
      for y in Integer range 0..22 loop
         for x in Integer range 0..35 loop
            if x = 0 or x = 35 or y = 0 or y = 22 then
               Goto_XY(x,y);
               Put("#");
            end if;

         end loop;
      end loop;
      Goto_XY(14,11);
      Put("TETRIS");
      Goto_XY(5,12);
      Put("Press any key to start...");
      if not ReadingInput then
         Ada.Text_IO.Get_Immediate (Answer);
      else
         loop
            exit when not ReadingInput;
         end loop;
      end if;
      StartGame.Start;
   end WelcomeScreen;

   task body GameInput is
      key : Character;
   begin
      loop
         accept start;
         loop
            ReadingInput := True;
            Ada.Text_IO.Get_Immediate(key);
            ReadingInput := False;
            exit when StopInput;
            InputReciever.Get(key);
         end loop;
      end loop;
   end GameInput;


   task GenerateBrciks;
   task body GenerateBrciks is
   begin
      loop
         Buffer.add(GetType);
      end loop;
   end GenerateBrciks;

   task body GameOverTask is

   begin
      loop
         accept Over;
            StopInput := True;
            for y in Integer range 1..YBoardSize loop
               for x in Integer range 1..XBoardSize loop
                  boardElements(x,y) := 3;
                  ScreenDisplay.DisplayBoardWithoutActiveBlock;
                  delay 0.01;
               end loop;

            end loop;
            for y in Integer range 1..YBoardSize loop
               for x in Integer range 1..XBoardSize loop
                  boardElements(x,y) := 0;

               end loop;

            end loop;
            WelcomeScreen;
      end loop;
   end GameOverTask;





begin

   WelcomeScreen;
   --gameOver := False;
   --currentBlock.
   --shape := blockArr(GetType);
   --currentBlock.origin := (5,0);
   --Clear_Screen;
   --ScreenDisplay.
   --DisplayBoard(currentBlock.shape,currentBlock.origin);
   --ScreenDisplay.DisplayScore(score);
   --Buffer.preview(blockType);
   --ScreenDisplay.DisplayNext(blockType);
   --GameInput.Start;
   --Gravity.Start;

end Main;
