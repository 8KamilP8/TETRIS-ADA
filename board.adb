
package body Board is

   function CheckCollision(P : in Point) return Integer is 
   begin
      if P.x <= 0 or P.x > XBoardSize or P.y > YBoardSize then
         return 1;
      end if;
      if P.y <= 0 then
         return 0;
      end if;
      return boardElements(P.x,P.y);
   end CheckCollision;
   function CheckClear(line : in Integer) return Boolean is
   begin         
      for x in Integer range 1..(XBoardSize) loop
         if CheckCollision((x,line)) = 0 then
            return False;
         end if;
      end loop; 
      return True;
   end CheckClear;
   procedure ClearLine(line : in Integer) is
   begin
      for y in reverse Integer range 2..line loop
         for x in Integer range 1..XBoardSize loop
            boardElements(x,y) := boardElements(x,y-1);
         end loop;
      end loop;
      
   end ClearLine;
   procedure ClearLines(lines : in out IntArray) is
      lineCounter : Integer := 0;
   begin
      lineCounter := 0;
      for line in Integer range lines'First..lines'Last loop
         lines(line) := lines(line) +lineCounter;
         if lines(line) > 0 then
            for y in reverse Integer range 2..lines(line) loop
               for x in Integer range 1..XBoardSize loop
                  boardElements(x,y) := boardElements(x,y-1);
               end loop;
            end loop;
            lineCounter := lineCounter +1;
         end if;
      end loop;
      
      
   end ClearLines;
end Board;
