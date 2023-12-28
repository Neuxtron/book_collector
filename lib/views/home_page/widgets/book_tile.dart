import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final String title;
  final String image;

  const BookTile({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 130,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(image),
            ),
          ),
          SizedBox(height: 10),
          Text(title),
        ],
      ),
    );
  }
}
