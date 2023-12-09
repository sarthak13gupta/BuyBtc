// use dio to make api call
import 'package:buy_bitcoin/api/api_exceptions.dart';
import 'package:buy_bitcoin/bloc/btc_model.dart';
import 'package:buy_bitcoin/widgets/alertDialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiCall {
  Future<Map<String, dynamic>> fetchBtcPrice(BuildContext context) async {
    Dio dio = Dio();
    try {
      String url =
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=true&locale=en";
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data[0];
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: url),
          response: response,
        );
      }
    } on DioException catch (error) {
      ApiException exception = ApiException();
      List<String> message = exception.getExceptionMessage(error);
      // add bloc function here
      await showErrorDialog(context: context, message: message);
      throw Exception(error);
    } catch (e) {
      showErrorDialog(context: context, message: ["Error", e.toString()]);
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchBtcChart(int days) async {
    String url =
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=$days';
    Dio dio = Dio();
    Response response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      return response.data;
    }
    // else {
    //   // handle other cases here
    // }

    throw Exception();
  }
}
