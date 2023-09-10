import 'package:dio/dio.dart';
import 'package:nationyme/service/dio_service.dart';

class NationalizeService {
  final Dio _dio = DioService.dio;
  static const baseUrl = 'https://api.nationalize.io/';

  Future<Map<String, dynamic>> getNationalizeByName(String name) async {
    Response resDio = await _dio.get('$baseUrl?name=$name');
    Map<String, dynamic> resData = resDio.statusCode == 200
        ? resDio.data as Map<String, dynamic>
        : <String, dynamic>{};

    return resData;
  }
}
