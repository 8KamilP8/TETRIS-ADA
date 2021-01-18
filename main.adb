with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with blocks; use blocks;
with board use board;
procedure Main is
   type ActiveBlock is record
      origin : Point;
      shape : BlockPoints;
   end record;
   procedure DisplayBoard is
   begin
      Set_Foreground (White);
      Set_Background (Black);
      Goto_XY (0, 1);
      for y in Integer range 0..(YBoardSize+1) loop
         for x in Integer range 0..(XBoardSize+1) loop
            Goto_XY(x,y);
            if y = 0 or y = YBoardSize+1 or x = 0 or x = XBoardSize+1 then
               Put ("#");
            elsif Board.CheckCollision((x,y)) or IsOnActiveBlock((x,y)) then
               Put("@");
            else
               Put(".");
            end if;
            Goto_XY(x+1,y);
         end loop;
         Goto_XY (0,y+1);
      end loop;
      Goto_XY(0,0);
      Put("[ TETRIS IN ADA ]");
   end DisplayBoard;

   function IsOnActiveBlock(point : in Point)return Boolean is
      for i in range(1..4) loop
         if(activeBlock.origin + activeBlock.shape(i) = point) then
            return True;
         end if;
      end loop;
      return False;
   end IsOnActiveBlock;

   task GameInput;
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
                  blocks.MoveBlock(activeBlock.origin,(-1,0),activeBlock.shape);
               elsif key = 'd' or key = 'D' then
                  blocks.MoveBlock(activeBlock.origin,(1,0),activeBlock.shape);
               elsif key = 'e' or key = 'E' then
                  blocks.RotateDirection(RotateDirection.Right);
               elsif key = 'q' or key = 'Q' then
                  blocks.RotateDirection(RotateDirection.Left);
               end if;
            end Get;
         or
            accept ExitSignal;
            exit;
         end select;
      end loop;
   end InputReciever;

   task body GameInput is
      key : Character;
   begin
      loop
         Ada.Text_IO.Get_Immediate(key);
         InputReciever.Get(key);
      end loop;
   end GameInput;

   protected InputBuf is
      entry SendKey(Ch:in Character);
      entry GetKey(Ch: out Character);
   private
      N : Character := '0';
      Empty : Boolean := True;
   end InputBuf;
   protected body InputBuf is
      entry SendKey(Ch : in Character)
        when Empty is
      begin
         N := Ch;
         Empty := False;
      end SendKey;
      entry GetKey(Ch : out Character)
        when not Empty is
      begin
         Ch := N;
         Empty := True;
      end GetKey;
   end InputBuf;

activeBlock : ActiveBlock;
begin
   GetType(activeBlock.shape);
   activeBlock.origin := (5,0);
   Clear_Screen();
   DisplayBoard;
end Main;
