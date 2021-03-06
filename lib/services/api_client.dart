import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:my_game/domain/model/item.dart';
import 'package:my_game/domain/response.dart';

class ApiClient {
  String basicUrl = 'http://0ls.ru/faaapiq';

  static getDio() {
    Dio _dio = Dio();
    _dio.options = _dio.options.copyWith(
      headers: Map.from(_dio.options.headers)
        ..remove(Headers.contentTypeHeader),
    );
    _dio.options = BaseOptions(
      headers: {
        HttpHeaders.acceptHeader:
        "accept: application/json",

      },
    );

    return _dio;
  }

  Future apiGetMainItems() async {
    final String url = '$basicUrl';
    Dio dio = getDio();
    try {
      var resp = await dio.get(url);
      if (resp.statusCode == 200) {
        return ItemResponse.fromJson(resp.data);
      } else {
        return [];
      }
    }  on DioError catch (e) {
      if (e.response != null) {
        developer.log('Dio error!');
        developer.log('STATUS: ${e.response?.statusCode}');
        developer.log('DATA: ${e.response?.data}');
        developer.log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        developer.log('Error sending request!');
        developer.log(e.message);
      }
    }
  }

  Future apiDeleteItem(int id) async {
    final String url = '${basicUrl}/${id}';
    Dio dio = getDio();
    return await dio.delete(url);
  }

  Future apiSetNewItem(Map req_json) async {
    final String url = '$basicUrl';
    Dio dio = getDio();
    try {
      developer.log('Я сюда зашел');
      return await dio.post(url, data: req_json);
    }  on DioError catch (e) {
      if (e.response != null) {
        developer.log('Dio error!');
        developer.log('STATUS: ${e.response?.statusCode}');
        developer.log('DATA: ${e.response?.data}');
        developer.log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        developer.log('Error sending request!');
        developer.log(e.message);
      }
    }
  }


  Future apiEditItem(String title, String text, int kind, bool completed, DateTime dt, int id) async {
    final String url = '${basicUrl}/${id}';
    Dio dio = getDio();
    Map req_json = {
      'title': title,
      'text': text,
      'kind': kind,
      'completed': completed,
      'dt': '$dt'
    };
    return await dio.put(url, data: req_json);
    // return await dio.post(url, data: formData);
  }


  Future apiEditItemJSON(Map req_json, int id) async {
    final String url = '${basicUrl}/${id}';
    Dio dio = getDio();
    return await dio.put(url, data: req_json);
  }

}

//  на гет
//   dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler)  async {
//   options.queryParameters.addAll({
//   'lesson_id': lesson_id,
//   'question_id': question_id,
//   });
//   return handler.next(options);
// }));

//на пост

  // FormData formData = new FormData.fromMap({
  //   "lesson_id": lesson_id,
  //   "lesson_note": lesson_note,
  // });
  // return await dio.post(url, data: formData);


