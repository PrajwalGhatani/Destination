import 'package:destination/utils/colors.dart';
import 'package:flutter/material.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
      ),
    );
  }
}
