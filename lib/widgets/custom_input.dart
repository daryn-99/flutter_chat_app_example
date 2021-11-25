import 'package:chat/config/palette.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final IconButton icontwo;
  //final String helperT;
  final String labelT;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.textController,
      @required this.icontwo,
      //@required this.helperT,
      @required this.labelT,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        cursorColor: Theme.of(context).backgroundColor,
        controller: this.textController,
        autocorrect: false,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(
              this.icon,
              color: Colors.grey,
            ),
            labelText: this.labelT,
            labelStyle: TextStyle(color: Colors.grey[700]),
            suffixIcon: this.icontwo,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}
