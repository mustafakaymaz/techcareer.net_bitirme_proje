import 'package:flutter/material.dart';
import 'package:yiyo/cubit/sepet_yemekler_detay_cubit.dart';
import 'package:yiyo/entity/sepet_yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SiparisOdeme extends StatefulWidget {
  const SiparisOdeme({Key? key}) : super(key: key);

  @override
  _SiparisOdemeState createState() => _SiparisOdemeState();
}

class _SiparisOdemeState extends State<SiparisOdeme> {

  int toplam =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60, width: 60,child: Image.asset("resimler/logo.jpg"),),
              Text("Siparis ve Ödeme",style: TextStyle(color: Colors.black),),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<SepetYemeklerDetayCubit, List<SepetYemekler>>(
        builder: (context, yemekListesi) {
          for(var i=0; i<yemekListesi.length; i++){
            toplam += int.parse(yemekListesi[i].yemek_fiyat);
          }
          if (yemekListesi.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 200, width: 200,child: Image.asset("resimler/logo.jpg"),),
                  Text(
                    "${yemekListesi.length.toString()} Adet Siparişiniz",
                    style: TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Toplam Ödeme: ${toplam} ₺",
                    style: TextStyle(
                        fontSize: 26, fontWeight: FontWeight.bold, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: Text("Siparis Onay",style: TextStyle(color: Colors.red),),
                          content: Text("Sipariş verilsin mi?"),
                          actions: [
                            TextButton(
                              child: Text("İptal"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: Text("Tamam"),
                              onPressed: () {
                                Navigator.pop(context);
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=> Anasayfa()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Sipariş verildi"),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      },
                    );
                  }, child: Text("Onayla ve Bitir"),style: ElevatedButton.styleFrom(primary: Colors.red),)
                ],
              ),
            );
          } else {
            return Center();
          }
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}
