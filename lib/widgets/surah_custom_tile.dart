import 'package:flutter/material.dart';
import '../models/surah.dart';

Widget SurahCustomListTile({
  required Surah surah,
  required BuildContext context,
  required VoidCallback ontap,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60, // Increased height
                width: 50, // Increased width
                padding: EdgeInsets.all(10), // Adjusted padding
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Text(
                  (surah.number).toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Increased font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded( // Ensures the text doesn't overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surah.englishName!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(surah.englishNameTranslation!),
                  ],
                ),
              ),
              Text(
                surah.name!,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
