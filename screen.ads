with board; use board;
with blocks; use blocks;
package Screen is

   protected ScreenDisplay is
      
      entry DisplayBoard(bp : in BlockPoints;origin : in Point);
      entry DisplayBoardWithoutActiveBlock;
      entry DisplayNext(bt : in BlockTypes) ;
      entry DisplayScore(score : in Integer);
   private 
      Free : Boolean := True;
      FreeNext : Boolean := True;
      FreeScore : Boolean :=True;
   end ScreenDisplay;
   function IsOnActiveBlock(p : in Point;bp : in BlockPoints;origin : in Point) return Boolean;
end Screen;
