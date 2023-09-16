import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/newsChannelHeadlineModel.dart';
class NewReop{

  Future<MyModel01> newsChannelApi(String channelName)async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=0115684db44e462d946f1ef478c3b74c' ;
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return MyModel01.fromJson(body);
    }
    throw Exception('Error');
  }
  Future<MyModel01> CategoriesChannelApi(String category)async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=0115684db44e462d946f1ef478c3b74c' ;
    print(url);
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      return MyModel01.fromJson(body);
    }
    throw Exception('Error');
  }
  // Future<MyModel01> newsChannelApi()async{
  //   String url="https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=0115684db44e462d946f1ef478c3b74c";
  //   final response = await http.get(Uri.parse(url));
  //
  //   if(response.statusCode==200){
  //     final body = jsonDecode(response.body);
  //     return MyModel01.fromJson(body);
  //   }
  //   throw new Exception('Error');

    // if(response.statusCode==200){
    //   final body = jsonDecode(response.body);
    //   return MyModel01.fromJson(json)
    // }

    
  }
