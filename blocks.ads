with Ada.Numerics.Discrete_Random;
with board;

package blocks is
   type Point is record
      x : Integer;
      y : Integer;
   end record;
   type BlockTypes is (O, L, J, T, S, Z, I);
   type BlockPoints is array(Integer range 1..4) of Point;
   type RotateDirection is (Left, Right, None);
   procedure RotateBlock(origin : Point, rotateDirection : RotateDirection, block : BlockPoints);
   procedure MoveBlock(origin : in out Point, rotateDirection : in RotateDirection, block : in out BlockPoints);
	
	package RandomBlock is new Ada.Numerics.Discrete_Random(BlockTypes);
	use RandomBlock;
	Gen: Generator;
	procedure GetType(block: out BlockTypes);

end blocks;
