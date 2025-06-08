
import 'package:flutter/material.dart';

getImage({imageUrl = "https://dummyimage.com/100x100.png/09f/fff"}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(16.0), // Change to desired corner radius
    child: Image.network(
      imageUrl,
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    ),
  );
}

getAlbumTitle({albumTitle = "Not Found"}){
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text(
      albumTitle,
      style: TextStyle(fontSize: 14), // You can adjust font size as needed
    ),
  );
}