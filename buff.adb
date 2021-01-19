with Ada.Text_IO;             use Ada.Text_IO;
package body buff is
   protected body Buffer is
      entry add(block: in BlockTypes) when currentSize < limit is
      begin
         currentSize:= currentSize + 1;
         localTab(currentSize):= block;
      end add;
      entry get(block: out BlockTypes) when currentSize > 0 is
      begin
         block:= localTab(1);
         currentSize:= currentSize - 1;
         for i in Integer range 1..currentSize loop
            localTab(i):= localTab(i+1);
         end loop;
      end get;
      entry preview(block: out BlockTypes) when currentSize > 0 is
      begin
         block:= localTab(1);
      end preview;
   end Buffer;
end buff;
