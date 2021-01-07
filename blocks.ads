package blocks is
   type RotateDirection is
   type Point is record
      x : Integer;
      y : Integer;
   end record;
   type BlockPoints is array(Integer range 1..4) of Point;
   procedure RotateBlock(origin : Point, rotateDirection : RotateDirection, block : BlockPoints);


end blocks;
