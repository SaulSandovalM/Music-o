import 'package:flutter/material.dart';
import 'profile_card_draggable.dart';

class CardsSectionDraggable extends StatefulWidget {
  @override
  _CardsSectionState createState() => _CardsSectionState();
}

class _CardsSectionState extends State<CardsSectionDraggable> {
  bool dragOverTarget = false;
  List<ProfileCardDraggable> cards = List();
  int cardsCounter = 0;

  @override
  void initState() {
    super.initState();

    for (cardsCounter = 0; cardsCounter < 3; cardsCounter++) {
      cards.add(ProfileCardDraggable(cardsCounter));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
          children: <Widget>[
            // Drag target row
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                dragTarget(),
                Flexible(flex: 2, child: Container()),
                dragTarget()
              ],
            ),
            // Back card
            Align(
              alignment: Alignment(-1.6, 0.0),
              child: IgnorePointer(
                  child: SizedBox.fromSize(
                    size: Size(MediaQuery.of(context).size.width * 0.4,
                        MediaQuery.of(context).size.height * 0.20),
                    child: cards[2],
                  )),
            ),
            // Middle card
            Align(
              alignment: Alignment(-2.0, 0.0),
              child: IgnorePointer(
                  child: SizedBox.fromSize(
                    size: Size(MediaQuery.of(context).size.width * 0.5,
                        MediaQuery.of(context).size.height * 0.25),
                    child: cards[1],
                  )),
            ),
            // Front card
            Align(
              alignment: Alignment(0.0, 0.0),
              child: Draggable(
                feedback: SizedBox.fromSize(
                  size: Size(MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.3),
                  child: cards[0],
                ),
                child: SizedBox.fromSize(
                  size: Size(MediaQuery.of(context).size.width * 0.6,
                      MediaQuery.of(context).size.height * 0.3),
                  child: cards[0],
                ),
                childWhenDragging: Container(),
              ),
            ),
          ],
        ));
  }

  void changeCardsOrder() {
    setState(() {
      // Swap cards
      var temp = cards[0];
      cards[0] = cards[1];
      cards[1] = cards[2];
      cards[2] = temp;

      cards[2] = ProfileCardDraggable(cardsCounter);
      cardsCounter++;
    });
  }

  Widget dragTarget() {
    return Flexible(
      flex: 1,
      child: DragTarget(
          builder: (_, __, ___) {
            return Container();
          },
          onWillAccept: (_) {
            setState(() => dragOverTarget = true);
            return true;
          },
          onAccept: (_) {
            changeCardsOrder();
            setState(() => dragOverTarget = false);
          },
          onLeave: (_) => setState(() => dragOverTarget = false)),
    );
  }
}