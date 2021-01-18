package score is
	procedure SaveScore (value: in Integer);
	entry Get (V: in out Integer; C: in out boolean);
	score_value: Integer := 0;
	is_different: boolean := false;
end score;