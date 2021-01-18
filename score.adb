package body score is
    procedure SaveScore(value: in Integer) is
    begin
        score := value;
        is_different := true;
    end SaveScore;

    entry Get(value: in out Integer) when is_different is
    begin
      value := score_value;
      is_different := false;
    end Get;
end score;