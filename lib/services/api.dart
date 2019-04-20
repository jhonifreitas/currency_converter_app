import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const _request = 'https://api.hgbrasil.com/finance/quotations?format=json&key=b611e299';

Future<Map> getCurrencies() async {
  http.Response response = await http.get(_request);
  return json.decode(response.body);
}
