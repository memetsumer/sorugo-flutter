import '../../../models/adapters/deneme_stat/deneme_stat_adapter.dart';

Map<String, dynamic> denemeStatToJson(DenemeStat value) {
  return {
    "ayt": value.ayt,
    "createdAt": value.createdAt,
    "dersCode": value.dersCode,
    "dersName": value.dersName,
    "dogru": value.dogru,
    "yanlis": value.yanlis,
    "sure": value.sure,
  };
}
