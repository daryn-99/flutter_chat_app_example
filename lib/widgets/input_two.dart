import 'package:flutter/material.dart';

class InputTwo extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType keyboardType;
  final String placeholder;

  const InputTwo({
    Key key,
    @required this.placeholder,
    @required this.textController,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 2, left: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20),
        child: TextField(
          controller: this.textController,
          autocorrect: false,
          keyboardType: this.keyboardType,
          decoration: InputDecoration(hintText: this.placeholder),
        ),
      ),
    );
  }
}
