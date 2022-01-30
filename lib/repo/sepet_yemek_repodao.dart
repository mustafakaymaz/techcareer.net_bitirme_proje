import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yiyo/entity/sepet_yemekler.dart';
import 'package:yiyo/entity/sepet_yemekler_cevap.dart';

class SepetYemekDaoRepo {

  String baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/";

  Future<void> sepetYemekKayit(
      String yemek_adi,
      String yemek_resim_adi,
      String yemek_fiyat,
      String yemek_siparis_adet,
      String kullanici_adi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await http.post(url, body: veri);
    print("Sepet Yemek Kayıt: ${cevap.body}");
  }

  List<SepetYemekler> parseSepetYemeklerCevap(String cevap) {
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemekListesi;
  }

  Future<List<SepetYemekler>> sepetYemekBosListe() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseSepetYemeklerCevap(cevap.body);
  }

  Future<List<SepetYemekler>> sepetYemek(String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi" : kullanici_adi};
    var cevap = await http.post(url,body: veri);
    return parseSepetYemeklerCevap(cevap.body);
  }

  Future<void> sepettenYemekSil(int sepet_yemek_id,String kullanici_adi) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {"sepet_yemek_id": sepet_yemek_id.toString(), "kullanici_adi": kullanici_adi};
    var cevap =  await http.post(url,body: veri);
    print("Sepetten yemek sil: ${cevap.body}");

  }
}
