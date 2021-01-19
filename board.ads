package Board is
      type BoardContent is array(Integer range <>,Integer range <>) of Integer;
   XBoardSize : constant Integer := 10;
   YBoardSize : constant Integer := 20;

   boardElements : BoardContent(1..XBoardSize,1..YBoardSize);
   type Point is record
      x : Integer;
      y : Integer;
   end record;
   type IntArray is array (Positive range <>) of Integer;
   function CheckCollision(P : Point) return Boolean;
   procedure ClearLine(line : in Integer);
   procedure ClearLines(lines : in out IntArray);
   function CheckClear(line : in Integer) return Boolean;

end Board;
