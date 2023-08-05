import 'package:flutter/material.dart';

class CustomTextt extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textController;
  final bool isPass;

  const CustomTextt({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textController,
    required this.isPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Container(
      width: 300,
      padding: const EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey,
          )
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 11, 12, 10),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}

class dateContainer extends StatelessWidget {
  final String datetxt;
  final String datelabel;
  final Color txtColor;
  final FontWeight weight;
  final double size;
  final FontStyle style;

  const dateContainer(
      {super.key,
      required this.datetxt,
      required this.datelabel,
      required this.txtColor,
      required this.weight,
      required this.size,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 90,
      padding: const EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Color.fromARGB(255, 15, 124, 214),
          )
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 117, 143, 216),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          Text(
            datelabel,
            style: const TextStyle(
              color: Colors.pinkAccent,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            datetxt,
            style: TextStyle(
                fontSize: size ?? 16,
                color: txtColor ?? Colors.black,
                fontWeight: weight ?? FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textController;
  final bool isPass;

  const CustomText({
    Key? key,
    required this.hintText,
    required this.textInputType,
    required this.textController,
    required this.isPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return Container(
      width: 300,
      padding: const EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            offset: Offset(1, 1),
            color: Colors.grey,
          )
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 11, 12, 10),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(11),
      ),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
