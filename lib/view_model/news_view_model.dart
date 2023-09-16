import 'package:news_app/Repository/newsRepository.dart';
import 'package:news_app/model/catagoriesModel.dart';

import '../model/newsChannelHeadlineModel.dart';

class NewsViewModel{
final _rep = NewReop();
Future<MyModel01> newsChannelApi(String channelName) async{
  final response = await _rep.newsChannelApi(channelName);
  return response ;
}
Future<MyModel02> categoriesChannelApi(String category) async{
  final response = await _rep.categoriesChannelApi(category);
  return response ;
}
// Future<MyModel01> newsChannelApi()async{
//   final response = await _rep.newsChannelApi();
//   return response;
// }
}