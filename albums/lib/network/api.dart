import 'package:albums/network/album_detail_model.dart';
import 'package:albums/network/albums_model.dart';
import 'package:dio/dio.dart';

const albumsAPI = "https://jsonplaceholder.typicode.com";
class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: albumsAPI, // ✅ Base URL
    ),
  );

  // 🧠 Fetch user by ID (parameterized function)
  Future<AlbumsModel> fetchAlbums(String path) async {
    try {
      final response = await _dio.get(path); // 👈 Using parameter
      return AlbumsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<AlbumDetailModel> fetchUserById(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParams, // ✅ Add query parameters
      );
      return AlbumDetailModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }
}
