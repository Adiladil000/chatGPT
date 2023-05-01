import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../constants/api_consts.dart';
import '../models/chat_model.dart';
import '../models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        //  print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      // print("jsonResponse burda $jsonResponse");
      List temp = [];
      for (var value in jsonResponse["data"]) {
        temp.add(value);
        //   log("temp ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("error oldu $error");
      rethrow;
    }
  }

  // Send Message fct

  static Future<List<ChatModel>> sendMessage({required String message, required String modelId}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {'Authorization': 'Bearer $API_KEY', "Content-Type": "application/json"},
          body: jsonEncode({"model": modelId, "prompt": message, "max_tokens": 3000}));

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        //  print("jsonResponse['error'] ${jsonResponse['error']["message"]}");
        throw HttpException(jsonResponse['error']["message"]);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        //log("jsonRespone[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                  msg: jsonResponse["choices"][0]["text"],
                  chatIndex: 1,
                ));
      }
      return chatList;
    } catch (error) {
      print("error oldu $error");
      rethrow;
    }
  }

  // Generate Image
  static final aiImageUrl = Uri.parse("$BASE_URL/images/generations");
  static final headers = {'Authorization': 'Bearer $API_KEY', "Content-Type": "application/json"};

  static generateImage(String text, String size) async {
    var response = await http.post(aiImageUrl, headers: ApiService.headers, body: jsonEncode({"prompt": text, "n": 1, "size": size}));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'][0]['url'].toString();
    } else {
      print("xeta oldu");
    }
  }
}
