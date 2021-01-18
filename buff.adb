package body buff is
	entry add(block: in BlockTypes) when currentSize < limit is
	begin
		currentSize:= currentSize + 1;
		Buff_Array(currentSize):= block;
	end add;
	entry get(block: out BlockTypes) when currentSize > 0 is
	begin
		block:= Buff_Array(1);
		currentSize:= currentSize - 1;
		for i in range 1..currentSize loop
			Buff_Array(i):= Buff_Array(i+1);
		end loop;
	end get;
	entry preview(block: out BlockTypes) when currentSize > 0 is
	begin
		block:= Buff_Array(1);
	end preview;
end buff;