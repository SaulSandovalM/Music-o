import 'package:flutter/material.dart';

class ProfileCardDraggable extends StatelessWidget {
  final int cardNum;
  ProfileCardDraggable(this.cardNum);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.asset('assets/perfil.jpg', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
