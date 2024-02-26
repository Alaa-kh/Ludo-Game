import 'package:flutter_application_2/core/constants/app_packages.dart';

class GameMainBoardWidgets extends StatelessWidget {
  const GameMainBoardWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      margin: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: CustomPaint(
                painter: PaintBoard(trackListener: (playerTracks) {
                  playerTracksList = playerTracks;
                }),
              ),
            ),
            SizedBox.expand(
                child: AnimatedBuilder(
              animation: playerHighlightAnimation!,
              builder: (_, __) => CustomPaint(
                painter: CoverArea(
                    highlightColor: playerHighlightAnimation!.value,
                    selectedHomeIndex: currentTurn,
                    clickOffset: (clickOffset) {
                      handleClick(clickOffset);
                    }),
              ),
            )),
            Consumer<PlayersNotifier>(builder: (_, notifier, __) {
              if (notifier.shoulPaintPlayers) {
                return SizedBox.expand(
                  child: Stack(
                    children: buildPawnWidgets(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }),
            Consumer<ResultNotifier>(builder: (_, notifier, __) {
              return SizedBox.expand(
                  child: CustomPaint(
                painter: DrawingResult(notifier.ranks),
              ));
            })
          ],
        ),
      ),
    );
  }
}
