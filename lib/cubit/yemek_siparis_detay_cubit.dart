
import 'package:yiyo/repo/sepet_yemek_repodao.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YemekSiparisDetayCubit extends Cubit<void> {
  YemekSiparisDetayCubit(): super(0);

  var siparisRepo = SepetYemekDaoRepo();

  Future<void> sepetKayit(String yemek_adi,
      String yemek_resim_adi,
      String yemek_fiyat,
      String yemek_siparis_adet,
      String kullanici_adi) async {
    await siparisRepo.sepetYemekKayit(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}