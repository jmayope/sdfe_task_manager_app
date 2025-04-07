import 'package:flutter/services.dart';

String URI = 'http://192.168.18.3:3000/api';
String URI_JPH = 'https://jsonplaceholder.typicode.com';
String APP_NAME = 'tmApp';
Color PRIMARY_COLOR = fromHex('#7a8f79');
Color SECONDARY_COLOR = fromHex('#b3b5b0');
Color SECONDARY_LIGHT_COLOR = fromHex('#fafafa');

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

String stringDate(DateTime date) {
  return '${date.year}-${date.month < 10 ? 0 : ''}${date.month}-${date.day < 10 ? 0 : ''}${date.day}';
}

String stringDateTime(DateTime date) {
  date = date.toLocal();
  return '${date.year}-${date.month < 10 ? 0 : ''}${date.month}-${date.day < 10 ? 0 : ''}${date.day} ${date.hour}:${date.minute}';
}

