package score is
   protected ScoreBuffer is
	procedure SaveScore (value: in Integer);
	entry Get (value: in out Integer);
	score_value: Integer := 0;
      is_different: boolean := True;
      end ScoreBuffer;
end score;
