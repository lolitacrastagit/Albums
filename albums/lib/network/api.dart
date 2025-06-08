import 'package:albums/network/album_detail_model.dart';
import 'package:albums/network/albums_model.dart';
import 'package:dio/dio.dart';

const albumsAPI = "https://jsonplaceholder.typicode.com";
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: albumsAPI,
    ),
  );


  Future<List<AlbumsModel>> fetchAlbums(String path) async {
    print("reached fetch Albums");
    /*try {*/
      final response = await _dio.get(path);
      List<AlbumsModel> albums = (response.data as List)
          .map((json) => AlbumsModel.fromJson(json))
          .toList();
      return albums;
 /*   } catch (e) {
      pr
    }*/
  }

  Future<List<AlbumDetailModel>> fetchDetails(String path, {Map<String, dynamic>? queryParams}) async {
    print("reached fetch details");
   /* try {*/
      final response = await _dio.get(
        path,
        queryParameters: queryParams, // ✅ Add query parameters
      );
      List<AlbumDetailModel> albums = (response.data as List)
          .map((json) => AlbumDetailModel.fromJson(json))
          .toList();
      return albums;
   /* } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }*/
  }
}
