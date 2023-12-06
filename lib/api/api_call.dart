// use dio to make api call
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:dio/dio.dart';

class ApiCall {
  Future<Map<String, dynamic>> fetch() async {
    Dio dio = Dio();
    String url =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      return response.data[0];
    }
    // else {
    //   // handle other cases here
    // }

    throw Exception();
  }
}
