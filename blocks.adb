with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
package body blocks is
   procedure RotateBlock(origin : Point, rotateDirection : RotateDirection, block : BlockPoints) is
   begin
      --TO DO
      --w prawo
      new_x:=-y;
      new_y:= x;

      -- w lewo
      new_x:=y;
      new_y:=-x;
      CheckCollision(origin + (new_x,new_y));
   end RotateBlock;

   O: constant BlockPoints := ((0, 0), (0, 1), (1, 0), (1, 1));
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

   S: constant BlockPoints := ((0, 0), (1, 0), (-1, 1), (0, 1));
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
