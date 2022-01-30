import 'package:flutter/material.dart';
import 'package:yiyo/cubit/yemek_siparis_detay_cubit.dart';
import 'package:yiyo/entity/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yiyo/repo/sepet_yemek_repodao.dart';

class YemekSiparisDetay extends StatefulWidget {
  Yemekler yemek;
  YemekSiparisDetay({required this.yemek});
  @override
  _YemekSiparisDetayState createState() => _YemekSiparisDetayState();
}
class _YemekSiparisDetayState extends State<YemekSiparisDetay> {
SepetYemekDaoRepo sepetYemekDaoRepo = SepetYemekDaoRepo();
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    itemCount;
  sepetYemekDaoRepo;
  }

  @override
  Widget build(BuildContext context) {
    var siparisToplam = ((int.parse(widget.yemek.yemek_fiyat)) * itemCount).toString();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text("${widget.yemek.yemek_adi}",style: TextStyle(color: Colors.black),)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 150,
                height: 150,
                child:
                Image.network("${sepetYemekDaoRepo.baseUrl}${widget.yemek.yemek_resim_adi}")),
            Text("${widget.yemek.yemek_adi} : ${widget.yemek.yemek_fiyat} ₺"),
            Container(
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.red),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  itemCount!=0 ? IconButton(onPressed: (){setState(() {
                    itemCount--;
                  });}, icon: Icon(Icons.remove_circle_outline, color: Colors.red,))  : IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.red,)) ,
                  Text(itemCount.toString(), style: TextStyle(fontSize: 12, color: Colors.black)),
                  IconButton(onPressed: (){setState(() {
                    itemCount++;
                  });}, icon: Icon(Icons.add_circle_outline, color: Colors.red,)),
                ],
              ),
            ),
            ElevatedButton(onPressed: (){
              if(itemCount==0){
                 showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: Text("Uyarı!!",style: TextStyle(color: Colors.red),),
                      content: Text("Ürünü sepete eklemeden önce lütfen adedini seçiniz?"),
                      actions: [
                        TextButton(
                          child: Text("Tamam"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              }else {
                context.read<YemekSiparisDetayCubit>().sepetKayit(widget.yemek.yemek_adi, widget.yemek.yemek_resim_adi, siparisToplam, itemCount.toString(), "mustafa_kaymaz");
              }
              },
                child: Text("Sepete Ekle"),style: ElevatedButton.styleFrom(primary: Colors.red),),
          ],
        ),
      )
    );
  }
}
