enum GameResult {
  win,
  loss,
  canceled,
  ;

  String get label => switch (this) {
        GameResult.win => '勝ち',
        GameResult.loss => '負け',
        GameResult.canceled => '対戦中止',
      };
}
