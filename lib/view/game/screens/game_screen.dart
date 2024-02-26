import 'package:flutter_application_2/core/constants/app_packages.dart';

Animation? playerHighlightAnimation;
Animation<double>? highlightAnimation;
AnimationController? playerHighlightAnimationCont;
AnimationController? diceHighlightAnimationCont;

bool? provideFreeTurn = false;
CollideDetails? collisionDetails = CollideDetails();

int stepCounter = 0;
int diceOutput = 0;
int currentTurn = 0;
int selectedPawnIndex = 0;
int maxTrackIndex = 57;
int straightSixesCounter = 0;
int forwardStepAnimTimeInMillis = 250;
int reverseStepAnimTimeInMillis = 0;

final List<List<MapEntry<int, Rect>>> pawnCurrentStepInfoList = [];
final List<List<AnimationController>> playerAnimationContList = [];
final List<List<Animation<Offset>>> playerAnimationList = [];
final List<List<int>> winnerPawnList = [];
List<List<List<Rect>>>? playerTracksList;
List<Rect>? safeSpotsList;

PlayersNotifier? playerPaintNotifier;
ResultNotifier? resultNotifier;
DiceNotifier? diceNotifier;

class FludoGame extends StatefulWidget {
  const FludoGame({super.key});

  @override
  _FludoGameState createState() => _FludoGameState();
}

class _FludoGameState extends State<FludoGame> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    playerPaintNotifier = PlayersNotifier();
    resultNotifier = ResultNotifier();
    diceNotifier = DiceNotifier();

    playerHighlightAnimationCont = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    diceHighlightAnimationCont =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    playerHighlightAnimation =
        ColorTween(begin: AppColors.blackColor12, end: AppColors.blackColor45)
            .animate(playerHighlightAnimationCont!);
    highlightAnimation =
        Tween(begin: 0.0, end: 2 * pi).animate(diceHighlightAnimationCont!);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initData();

      playerPaintNotifier!.rebuildPaint();

      accentuateCurrentPlayer();
      accentuateDice();
    });
  }

  @override
  void dispose() {
    for (var controllerList in playerAnimationContList) {
      for (var controller in controllerList) {
        controller.dispose();
      }
    }
    playerHighlightAnimationCont!.dispose();
    diceHighlightAnimationCont!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<PlayersNotifier>(
                create: (_) => playerPaintNotifier!),
            ChangeNotifierProvider<ResultNotifier>(
                create: (_) => resultNotifier!),
            ChangeNotifierProvider<DiceNotifier>(create: (_) => diceNotifier!),
          ],
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                  child: Container(
                color: const Color.fromARGB(204, 235, 229, 229),
              )),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const GameMainBoardWidgets(),
                    const CustomVerticalSizedBox(50),
                    GestureDetector(
                      onTap: () {
                        if (diceHighlightAnimationCont!.isAnimating) {
                          playerHighlightAnimationCont!.reset();
                          diceHighlightAnimationCont!.reset();
                          diceNotifier!.rollDice();
                        }
                      },
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Stack(children: [
                            SizedBox.expand(
                              child: AnimatedBuilder(
                                animation: highlightAnimation!,
                                builder: (_, __) => CustomPaint(
                                  painter:
                                      DicePainter(highlightAnimation!.value),
                                ),
                              ),
                            ),
                            Consumer<DiceNotifier>(builder: (_, notifier, __) {
                              if (notifier.isRolled) {
                                accentuateCurrentPlayer();
                                diceOutput = notifier.output;
                                if (diceOutput == 6) straightSixesCounter++;
                                validityOfDiceResult();
                              }
                              return SizedBox.expand(
                                child: CustomPaint(
                                  painter: DicePaint(notifier.output),
                                ),
                              );
                            })
                          ])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  initData() {
    for (int i = 0; i < playerTracksList!.length; i++) {
      List<Animation<Offset>> currentPlayerAnimList = [];
      List<AnimationController> currentPlayerAnimContList = [];
      List<MapEntry<int, Rect>> currentStepInfoList = [];

      for (int pawnIndex = 0;
          pawnIndex < playerTracksList![i].length;
          pawnIndex++) {
        AnimationController currentAnimCont = AnimationController(
            duration: Duration(milliseconds: forwardStepAnimTimeInMillis),
            vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (!collisionDetails!.isReverse) stepCounter++;
              movePawn();
            }
          });

        currentPlayerAnimContList.add(currentAnimCont);
        currentPlayerAnimList.add(Tween(
                begin: playerTracksList![i][pawnIndex][0].center,
                end: playerTracksList![i][pawnIndex][1].center)
            .animate(currentAnimCont));
        currentStepInfoList
            .add(MapEntry(0, playerTracksList![i][pawnIndex][0]));
      }
      playerAnimationContList.add(currentPlayerAnimContList);
      playerAnimationList.add(currentPlayerAnimList);
      pawnCurrentStepInfoList.add(currentStepInfoList);
      winnerPawnList.add([]);
    }

    var playerPath = playerTracksList![0][0];

    safeSpotsList = [
      playerPath[1],
      playerPath[9],
      playerPath[14],
      playerPath[22],
      playerPath[27],
      playerPath[35],
      playerPath[40],
      playerPath[48]
    ];
  }
}
