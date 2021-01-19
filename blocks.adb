with NT_Console;              use NT_Console;
with Ada.Text_IO;             use Ada.Text_IO;
package body blocks is
    
   function RotateBlock(origin : in Point; direction : in RotateDirection; block : in out BlockPoints) return Boolean is
      newPoints : BlockPoints := block;
      collision : Integer := 0;
      new_x : Integer := -1;
      new_y : Integer := -1;
   begin
      if block = O_points then
         return False;
      end if;
      for i in Integer range 1..4 loop
         if direction = Right then
            new_x:=-block(i).y;
            new_y:= block(i).x;
         end if;
         if direction = Left then
            new_x:=block(i).y;
            new_y:=-block(i).x;
         end if;
         collision := CheckCollision((origin.x + new_x, origin.y + new_y));
         if collision > 0 then
            return False;
         end if;
         newPoints(i).x := new_x;
         newPoints(i).y := new_y;
      end loop;
      block := newPoints;
      return True;
   end RotateBlock;
   function MoveBlock(origin : in out Point; direction : in Point; block : in out BlockPoints) return Boolean is
      newOrigin : Point := origin;
      collision : Integer := 0;
   begin
      newOrigin.x := newOrigin.x + direction.x;
      newOrigin.y := newOrigin.y + direction.y;
      for i in Integer range 1..4 loop
         collision := CheckCollision((newOrigin.x + block(i).x, newOrigin.y + block(i).y));
         if collision > 0 then
            return False;
         end if;
      end loop;
      origin.x := newOrigin.x;
      origin.y := newOrigin.y;
      return True;
   end MoveBlock;
   
   function GetType return BlockTypes is
   begin
		Reset(Gen);
		return Random(Gen);
	end GetType;
  
	
end blocks;
