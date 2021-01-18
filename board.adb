package body Board is
   XBoardSize : constant Integer := 10;
   YBoardSize : constant Integer := 20;
   boardContent : BoardContent(1..XBoardSize,1..YBoardSize); 
   function CheckCollision(P : in Point) return Boolean is 
   begin
      if P.x <= 0 or P.y <= 0 or P.x > XBoardSize or P.y > YBoardSize then
         return True;
         return boardContent(P.x,P.y) >= 1;
      end CheckCollision;
      function CheckClear(line : in Integer) return Boolean is
      begin         
         for x in Integer range 1..(XBoardSize+1) loop
            if CheckCollision(x,line) = False then
               return False;
            end if;
         end loop; 
         return True;
      end CheckClear;
end Board;
