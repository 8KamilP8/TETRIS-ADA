with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with board; use board;
with blocks; use blocks;
package body Screen is
   protected body ScreenDisplay is
      entry DisplayBoard(bp : in BlockPoints;origin : in Point) when Free is 
      begin
         Free := False;
         
         Goto_XY (3, 1);
         for y in Integer range 0..(board.YBoardSize+1) loop
            for x in Integer range 0..(board.XBoardSize+1) loop
               Goto_XY(x+3,y+1);
               if y = 0 or y = YBoardSize+1 or x = 0 or x = XBoardSize+1 then
                  Set_Foreground (White);
                  Put ("#");
               elsif  IsOnActiveBlock((x,y),bp,origin) then
                  Set_Foreground (Yellow);
                  Put("@");
               elsif Board.CheckCollision((x,y)) = 1 then
                  Set_Foreground (White);
                  Put("@");
               elsif Board.CheckCollision((x,y)) > 1 then
                  Set_Foreground (White);
                  Put("X");
               else
                  Set_Foreground (White);
                  Put(".");
               end if;
               Goto_XY(x+4,y);
            end loop;
            Goto_XY (3,y+2);
         end loop;
         Goto_XY(0,0);
         Put("[ TETRIS IN ADA ]");
         
         Free := True;
      end DisplayBoard;
      entry DisplayBoardWithoutActiveBlock when Free is 
      begin
         Free := False;
         
         Goto_XY (3, 1);
         for y in Integer range 0..(board.YBoardSize+1) loop
            for x in Integer range 0..(board.XBoardSize+1) loop
               Goto_XY(x+3,y+1);
               if y = 0 or y = YBoardSize+1 or x = 0 or x = XBoardSize+1 then
                  Set_Foreground (White);
                  Put ("#");
               elsif Board.CheckCollision((x,y)) = 1 then
                  Set_Foreground (White);
                  Put("@");
               elsif Board.CheckCollision((x,y)) > 1 then
                  Set_Foreground (White);
                  Put("X");
               else
                  Set_Foreground (White);
                  Put(".");
               end if;
               Goto_XY(x+4,y);
            end loop;
            Goto_XY (3,y+2);
         end loop;
         Goto_XY(0,0);
         Put("[ TETRIS IN ADA ]");
         
         Free := True;
      end DisplayBoardWithoutActiveBlock;
      entry DisplayNext(bt : in BlockTypes) when FreeNext is 
      begin
         FreeNext := False;
         Set_Foreground (White);
         Set_Background (Black);
         Goto_XY (16, 8);
         Put ("NEXT:");
         Goto_XY (16, 9);
         Put ("######");
         Goto_XY (16, 10);
         for y in Integer range 1..5 loop
            for x in Integer range 0..5 loop
               if x = 0 or x = 5 then
                  Put("#");
               elsif IsOnActiveBlock((16+x,9+y),blockArr(bt),(18,12)) then
                  Put("@");
               else   
                  Put(".");
               end if;
            end loop;
            Goto_XY(16,y+9);
         end loop;
         Goto_XY(16,14);
         Put ("######");
         -- NEXT:
         -- ######
         -- #    #
         -- # @@ #
         -- # @@ #
         -- #    #
         -- ######                
         FreeNext := True;
      end DisplayNext;
      entry DisplayScore(score : in Integer) when FreeScore is 
      begin
         FreeScore := False;
         Goto_XY (16, 5);
         Put("SCORE:");
         Goto_XY (16, 6);
         Put(" " & score'img);
         
         FreeScore := True;
      end DisplayScore;
   end ScreenDisplay;
   function IsOnActiveBlock(p : in Point;bp : in BlockPoints;origin : in Point) return Boolean is
   begin
      for i in Integer range 1..4 loop
         if((origin.x + bp(i).x = p.x) and (origin.y + bp(i).y = p.y)) then
            return True;
         end if;
      end loop;
      return False;
   end IsOnActiveBlock;

end Screen;
