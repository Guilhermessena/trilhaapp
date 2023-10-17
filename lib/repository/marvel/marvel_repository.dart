import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:trilhaapp/model/characters_marvel.dart';

class MarvelRepository {
  Future<CharactersMarvel> getCharacters(int offset) async {
    var dio = Dio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = dotenv.get('MARVELPUBLICKEY');
    var privateKey = dotenv.get('MARVELPRIVATEKEY');
    var hash = _generateMd5(ts + privateKey + publicKey);
    var query = 'offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash';
    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    var characters = CharactersMarvel.fromJson(result.data);
    return characters;
  }

  _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
