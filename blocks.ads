with Ada.Numerics.Discrete_Random;
with board; use board;

package blocks is
   
   type BlockTypes is (O, L, J, T, S, Z, I);
   type BlockPoints is array(Integer range 1..4) of Point;
   type BlockTypesArray is array(BlockTypes) of BlockPoints;
   type RotateDirection is (Left, Right, None);
   function RotateBlock(origin : in Point; direction : in RotateDirection; block : in out BlockPoints) return Boolean;
   function MoveBlock(origin : in out Point; direction : in Point; block : in out BlockPoints) return Boolean;
	
	package RandomBlock is new Ada.Numerics.Discrete_Random(BlockTypes);
	use RandomBlock;
	Gen: Generator;
	function GetType return BlockTypes;
   O_points: constant BlockPoints := ((0, 1), (0, 0), (1, 0), (1, 1));
   -- @@
   -- @@

   L_points: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (1, 1));
   -- @
   -- #
   -- @@

   J_points: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (-1, 1));
   -- @
   -- #
   --@@

   T_points: constant BlockPoints := ((-1, 0), (0, 0), (1, 0), (0, 1));
   --@#@
   -- @

   S_points: constant BlockPoints := ((1, 0), (0, 0), (-1, 1), (0, 1));
   --  $@
   -- @@
   Z_points: constant BlockPoints := ((-1, 0), (0, 0), (0, 1), (1, 1));
   -- @$
   --  @@

   I_points: constant BlockPoints := ((0, -1), (0, 0), (0, 1), (0, 2));
   --@
   --$
   --@
   --@
   blockArr : BlockTypesArray:= (O_points, L_points, J_points, T_points, S_points, Z_points, I_points);
end blocks;
