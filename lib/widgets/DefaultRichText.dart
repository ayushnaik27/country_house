import 'package:flutter/material.dart';

class DefaultRichText extends StatelessWidget {
  final String boldText;
  final String valueText;

  const DefaultRichText(
      {super.key, required this.boldText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: valueText),
        ],
      ),
    );
  }
}

class RichRow extends StatelessWidget {
  final String boldText;
  final String valueText;

  const RichRow({super.key, required this.boldText, required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          boldText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(valueText),
      ],
    );
  }
}
