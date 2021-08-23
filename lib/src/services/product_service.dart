import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:product_recognition_app/src/env/env_variables.dart';

class ProductService {
  Future getProduct(String imagePath) async {
    late String? apiResponse = '';

    var request = new http.MultipartRequest(
        'POST', Uri.parse('$API_URL/product-recognition'));

    print('Image path $imagePath');

    request.files.add(new http.MultipartFile.fromBytes(
        'product_image', await File.fromUri(Uri.parse(imagePath)).readAsBytes(),
        filename: 'product_image',
        contentType: new MediaType('image', 'jpeg')));

    await request.send().then((response) async {
      apiResponse = await response.stream.bytesToString();
    });

    return apiResponse;
  }
}
