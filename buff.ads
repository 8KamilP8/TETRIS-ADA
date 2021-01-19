with blocks; use blocks;

package buff is
	limit:constant Integer:= 5;
	type Buff_Array is array (1..limit) of BlockTypes;
   protected Buffer is
		entry add(block: in BlockTypes);
		entry get(block: out BlockTypes);
		entry preview(block: out BlockTypes);
   private 
      localTab: Buff_Array := (O,O,O,O,O);
      currentSize: Integer:= 0;
    end Buffer;
end buff;
