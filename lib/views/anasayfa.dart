import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yiyo/cubit/anasayfa_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiyo/cubit/sepet_yemekler_detay_cubit.dart';
import 'package:yiyo/entity/yemekler.dart';
import 'package:yiyo/repo/sepet_yemek_repodao.dart';
import 'package:yiyo/repo/yemeklerdao_repo.dart';
import 'package:yiyo/views/sepet_yemekler_detay.dart';
import 'package:yiyo/views/yemek_siparis_detay.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  SepetYemekDaoRepo sepetYemekDaoRepo = SepetYemekDaoRepo();

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
    sepetYemekDaoRepo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60, width: 60,child: Image.asset("resimler/logo.jpg"),),
            Text("Yiyo",style: TextStyle(color: Colors.black),),
          ],
        ),
       backgroundColor: Colors.white,
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemekListesi) {
          if (yemekListesi.isNotEmpty) {
            return GridView.builder(
              itemCount: yemekListesi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2,
              ),
              itemBuilder: (context, index) {
                var yemek = yemekListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => YemekSiparisDetay(
                                  yemek: yemek,
                                )));
                  },
                  child: Card(
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            width: 80,
                            height: 80,
                            child: Image.network(
                                "${sepetYemekDaoRepo.baseUrl}${yemek.yemek_resim_adi}")),
                        Text(
                          yemek.yemek_adi,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "${yemek.yemek_fiyat} ₺",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center();
          }
        },
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => KisiKayitSayfa()))
              .then((_){
            context.read<AnasayfaCubit>().kisileriYukle();
          });
        },
        child: Icon(Icons.add),
      ),*/
    );
  }
}
/*
ListView.builder(
              itemCount: yemekListesi.length,
              itemBuilder: (context,indeks){
                var yemek = yemekListesi[indeks];
                return GestureDetector(
                /*  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetaySayfa(kisi: kisi,))).then((_){
                      context.read<AnasayfaCubit>().kisileriYukle();
                    });
                  },*/
                  child: Card(
                    child: SizedBox(height: 50,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("${yemek.yemek_adi} - ${yemek.yemek_fiyat} -"),
                          ),

                          Spacer(),
                          SizedBox(
                              width: 40,
                              height: 80,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                              ),
                          /*IconButton(onPressed: (){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${kisi.kisi_ad} silinsin mi?"),
                                action: SnackBarAction(
                                  label: "Evet",
                                  onPressed: (){
                                    context.read<AnasayfaCubit>().sil(int.parse(kisi.kisi_id));
                                  },
                                ),
                              ),
                            );
                          }, icon: Icon(Icons.delete_outline,color: Colors.black54,))*/

                        ],
                      ),
                    ),
                  ),
                );
              },
            ); */
