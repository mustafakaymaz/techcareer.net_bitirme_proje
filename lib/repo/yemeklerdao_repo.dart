import 'dart:convert';

import 'package:yiyo/entity/yemekler.dart';
import 'package:yiyo/entity/yemekler_cevap.dart';
import 'package:http/http.dart' as http;

class YemeklerDaoRepo {


   List<Yemekler> parseYemeklerCevap(String cevap){
     return YemeklerCevap.fromJson(json.decode(cevap)).yemekListesi;
   }
   
   Future<List<Yemekler>> tumYemekleriGetir() async {
     var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
     var cevap = await http.get(url);
     return parseYemeklerCevap(cevap.body);
   }



}