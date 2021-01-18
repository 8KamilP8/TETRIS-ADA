with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
package body blocks is
 

   procedure RotateBlock(origin : in Point, rotateDirection : in RotateDirection, block : in out BlockPoints) is
      newPoints : BlockPoints := block;
      collision : Boolean := False;
   begin
      if block = O then
         return;
      end if;
      for i in range(1..4) loop
         if rotateDirection = RotateDirection.Right then
            new_x:=-block(i).y;
            new_y:= block(i).x;
         end if;
         if rotateDirection = RotateDirection.Left then
            new_x:=block(i).y;
            new_y:=-block(i).x;
         end if;
         collision := CheckCollision(origin + (new_x,new_y));
         if collision = True then
            return;
         end if;
         newPoints(i).x := new_x;
         newPoints(i).y := new_y;
      end loop;
      block := newPoints;
   end RotateBlock;
   procedure MoveBlock(origin : in out Point, direction : in Point, block : in out BlockPoints) is
      newOrigin : Point := origin;
      collision : Boolean := False;
   begin
      newOrigin.x := newOrigin.x + direction.x;
      newOrigin.y := newOrigin.y + direction.y;
      for i in range(1..4) loop
         collision := board.CheckCollision((newOrigin.x + block(i).x, newOrigin.y + block(i).y));
         if collision then
            return;
         end if;
      end loop;
      origin := newOrigin;
   end MoveBlock;
   
	procedure GetType(block: out BlockTypes) is
		Reset(Gen);
		block:= Random(Gen);
	end GetType;
   O: constant BlockPoints := ((0, 1), (0, 0), (1, 0), (1, 1));
   -- @@
   -- @@

   L: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (1, 1));
   -- @
   -- #
   -- @@

   J: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (-1, 1));
   -- @
   -- #
   --@@

   T: constant BlockPoints := ((-1, 0), (0, 0), (1, 0), (0, 1));
   --@#@
   -- @

   S: constant BlockPoints := ((1, 0), (0, 0), (-1, 1), (0, 1));
   --  $@
   -- @@
   Z: constant BlockPoints := ((-1, 0), (0, 0), (0, 1), (1, 1));
   -- @$
   --  @@

   I: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (0, 2));
   --@
   --$
   --@
   --@
end blocks;
