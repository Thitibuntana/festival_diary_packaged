import 'dart:io';
import 'package:dio/dio.dart';
import 'package:festival_diary_app/constants/baseurl_constant.dart';
import 'package:festival_diary_app/models/fest.dart';

class FestAPI {
  final dio = Dio();

  Future<bool> AddFest(Fest fest, File? festFile) async {
    try {
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userId': fest.userId,
        'festState': fest.festState,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });

      //เอาข้อมูลใน FormData ส่งไปผ่าน API ตาม Endpoint ที่ได้กำหนดไว้
      final responseData = await dio.post(
        '${baseUrl}/fest/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (responseData.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }

  Future<List<Fest>> getAllFestByUser(int userId) async {
    try {
      final responseData = await dio.get(
        '$baseUrl/fest/$userId',
      );
      if (responseData.statusCode == 200) {
        return (responseData.data['data'] as List)
            .map((fest) => Fest.fromJson(fest))
            .toList();
      } else {
        return <Fest>[];
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return <Fest>[];
    }
  }

  Future<bool> deleteFest(int festId) async {
    try {
      final responseData = await dio.delete(
        '$baseUrl/fest/$festId',
      );
      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('ERROR: ${err.toString()}');
      return false;
    }
  }

  Future<bool> updateFest(Fest fest, File? festFile) async {
    try {
      final formData = FormData.fromMap({
        'festName': fest.festName,
        'festDetail': fest.festDetail,
        'festNumDay': fest.festNumDay,
        'festCost': fest.festCost,
        'userId': fest.userId,
        'festState': fest.festState,
        if (festFile != null)
          'festImage': await MultipartFile.fromFile(
            festFile.path,
            filename: festFile.path.split('/').last,
            contentType: DioMediaType('image', festFile.path.split('.').last),
          ),
      });

      final responseData = await dio.put(
        '${baseUrl}/fest/${fest.festId}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (responseData.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Exception: ${err}');
      return false;
    }
  }
}
