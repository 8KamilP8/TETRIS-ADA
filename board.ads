package Board is
   type BoardContent is array(Integer range <>,Integer range <>) of Integer;
   function CheckCollision(P : Point) return Boolean;
   procedure ClearLine(line : in Integer);
end Board;
