with blocks; use blocks;

package buffer is
	limit:constant Integer:= 5;
	type Buff_Array is array (1..limit) of BlockTypes;
	protected buf is
		entry add(block: in BlockTypes);
		entry get(block: out BlockTypes);
		entry preview(block: out BlockTypes);
		private 
			localTab: Buff_Array;
			currentSize: Integer:= 0;
    end buf;
end buffer;