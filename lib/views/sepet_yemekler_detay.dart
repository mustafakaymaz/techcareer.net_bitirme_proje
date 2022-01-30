import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yiyo/cubit/sepet_yemekler_detay_cubit.dart';
import 'package:yiyo/entity/sepet_yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiyo/repo/sepet_yemek_repodao.dart';
import 'package:yiyo/views/siparis_ve_odeme.dart';

class SepetYemekDetay extends StatefulWidget {
  const SepetYemekDetay({Key? key}) : super(key: key);

  @override
  _SepetYemekDetayState createState() => _SepetYemekDetayState();
}

class _SepetYemekDetayState extends State<SepetYemekDetay> {

  SepetYemekDaoRepo sepetYemekDaoRepo = SepetYemekDaoRepo();
  int toplam = 0;


  @override
  void initState() {
    super.initState();
    context.read<SepetYemeklerDetayCubit>().sepetYemekGetir("mustafa_kaymaz");
    sepetYemekDaoRepo;
    toplam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60, width: 60,child: Image.asset("resimler/logo.jpg"),),
            Text("Sepetteki Yemekler",style: TextStyle(color: Colors.black),),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<SepetYemeklerDetayCubit, List<SepetYemekler>>(
        builder: (context, sepetYemekListesi) {
          if (sepetYemekListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: sepetYemekListesi.length,
              itemBuilder: (context, indeks) {
                var sepetYemek = sepetYemekListesi[indeks];
                return Card(
                  child: SizedBox(
                      height: 170,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                                "${sepetYemekDaoRepo.baseUrl}${sepetYemek.yemek_resim_adi}"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${sepetYemek.yemek_adi}",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Toplam Adet: ${sepetYemek.yemek_siparis_adet}",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "Toplam Fiyat: ${sepetYemek.yemek_fiyat} ₺",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              )
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Sil"),
                                    content: Text("Sepetten silinsin mi?"),
                                    actions: [
                                      TextButton(
                                        child: Text("Hayır"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Evet"),
                                        onPressed: () {
                                          context
                                              .read<SepetYemeklerDetayCubit>()
                                              .sil(
                                                  int.parse(sepetYemek
                                                      .sepet_yemek_id),
                                              "mustafa_kaymaz").then((_) => SepetYemekDetay());
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text("Sil"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          )
                        ],
                      )),
                );
              },
            );
          } else{
            return Center(
              child: Text("Sepet Boştur"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SiparisOdeme()));
            },
            label: Text("Sepeti Onayla"),
            icon:  Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.red,
          ),

    );
  }
}
