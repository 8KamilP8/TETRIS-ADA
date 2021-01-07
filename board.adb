package body Board is
   XBoardSize := 10;
   YBoardSize := 20;
   boardContent : BoardContent(1..XBoardSize,1..YBoardSize); 
   function CheckCollision(P : Point) return Boolean is 
   begin
      --TO DO poza zakresem bedzie to CO???
      return boardContent(P.x,P.y) >= 1; 
   end CheckCollision;
end Board;
