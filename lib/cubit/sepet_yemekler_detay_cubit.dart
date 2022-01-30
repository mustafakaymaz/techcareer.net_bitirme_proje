import 'package:yiyo/entity/sepet_yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiyo/repo/sepet_yemek_repodao.dart';

class SepetYemeklerDetayCubit extends Cubit<List<SepetYemekler>> {
  SepetYemeklerDetayCubit() : super(<SepetYemekler>[]);

  var sepetYemekRepo = SepetYemekDaoRepo();



  Future<void> sepetYemekGetir(String kullanici_adi) async {
    var liste = await sepetYemekRepo.sepetYemek(kullanici_adi);
    emit(liste);
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await sepetYemekRepo.sepettenYemekSil(sepet_yemek_id, kullanici_adi);
    await sepetYemekGetir(kullanici_adi);
  }

}