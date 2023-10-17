import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JsonplaceholderCustomDio {
  final  _dio = Dio();

  Dio get dio=> _dio;
  JsonplaceholderCustomDio(){
    var url = dotenv.get('JSONPLACEHOLDERURL', fallback: 'sane-default');
    _dio.options.baseUrl = url;
  }

}