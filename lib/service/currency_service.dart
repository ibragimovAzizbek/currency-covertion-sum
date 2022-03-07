import 'package:currency/models/currency_model.dart';
import 'package:dio/dio.dart';

class CurrencyService {
  static Future<List<CurrencyModel>> getCurruncy() async {
    Response res = await Dio().get('https://nbu.uz/uz/exchange-rates/json/');
    return (res.data as List).map((e) => CurrencyModel.fromJson(e)).toList();
  }
}
