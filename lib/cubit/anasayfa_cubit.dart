import 'package:flutter/rendering.dart';
import 'package:yiyo/entity/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiyo/repo/yemeklerdao_repo.dart';


class AnasayfaCubit extends Cubit<List<Yemekler>>{


  AnasayfaCubit() : super(<Yemekler>[]);

  var yemekRepo = YemeklerDaoRepo();

  Future<void> yemekleriYukle() async {
    var liste = await yemekRepo.tumYemekleriGetir();
    emit(liste);
  }

}