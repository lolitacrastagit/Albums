import 'package:albums/network/album_detail_model.dart';
import 'package:flutter/material.dart';

class AlbumModel{
  String title = "Not Found";
  List<AlbumDetailModel> imgUrls = const [];
  final ScrollController horizontalController = ScrollController();
}
