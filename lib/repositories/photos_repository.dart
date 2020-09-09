import 'package:http/http.dart' as http;

class PhotosRepository {
  final Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization':
        'Client-ID cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0'
  };

  Future<String> getPhotos() async {
    try {
      final http.Response response = await http.get(
        'https://api.unsplash.com/photos',
        headers: headers,
      );
      return response.body;
    } catch (error) {
      return error.toString();
    }
  }
}
