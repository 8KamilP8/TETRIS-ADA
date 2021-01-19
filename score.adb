with Screen; use Screen;
package body score is
   protected body ScoreBuffer is
    procedure SaveScore(value: in Integer) is
    begin
      score := value;
      Screen.ScreenDisplay.DisplayScore(value);
        is_different := true;
    end SaveScore;

    entry Get(value: in out Integer) when is_different is
    begin
      value := score_value;
      is_different := false;
      end Get;
      end ScoreBuffer;
end score;
