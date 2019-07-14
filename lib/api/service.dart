import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:pizza_app/models/food.dart';

class Service {
  static String _url =
      "https://my-json-server.typicode.com/payam-zahedi/Flutter-Pizza-sample";

  static Dio _dio;

  static Dio getInstance() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: _url,
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      _dio = Dio(options);
    }
    return _dio;
  }

  static Future<FoodList> fetchData() async {
    try {
      Response response = await getInstance().get("/db");

      checkResponse(response);

      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.

        var jsonString = json.encode(response.data);
        Map userMap = jsonDecode(jsonString);

        return FoodList.fromJson(userMap);


      } else {
        // If that response was not OK, throw an error.
        throw DioError(message :'exception throwed in Try');
      }
    } on DioError catch(e) {

      checkError(e);
      throw Exception('exception throwed in Catch');

    }

  }
}


void checkResponse(Response response){

  print("checkResponse:");
  print("statusCode: ${response.statusCode}");
  print("statusMessage: ${response.statusMessage}");
  print("headers: ${response.headers}");
  print("request: ${response.request}");
  print("checkResponse Completed.....................");

}

void checkError(DioError error){

  print("checkError:");

  if(error.response!=null){
    print("statusCode: ${error.response.statusCode}");
    print("statusMessage: ${error.response.statusMessage}");
    print("headers: ${error.response.headers}");
    print("request: ${error.response.request}");
  }

  print("errorType: ${error.type}");
  print("errorMessage: ${error.message}");
  print("errorData: ${error.error}");
  print("checkError Completed.....................");

}