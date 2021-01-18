package score is
	procedure SaveScore (value: in Integer);
	entry Get (value: in out Integer);
	score_value: Integer := 0;
	is_different: boolean := false;
end score;