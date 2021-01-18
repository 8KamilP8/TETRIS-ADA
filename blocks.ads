package blocks is
   type RotateDirection is
   type Point is record
      x : Integer;
      y : Integer;
   end record;
   type BlockPoints is array(Integer range 1..4) of Point;
   type RotateDirection is (Left, Right, None);
   procedure RotateBlock(origin : Point, rotateDirection : RotateDirection, block : BlockPoints);
   procedure MoveBlock(origin : in out Point, rotateDirection : in RotateDirection, block : in out BlockPoints);


end blocks;
