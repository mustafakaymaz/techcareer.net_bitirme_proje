import 'package:flutter/material.dart';
import 'package:yiyo/cubit/sepet_yemekler_detay_cubit.dart';
import 'package:yiyo/cubit/yemek_siparis_detay_cubit.dart';
import 'package:yiyo/views/bottompage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/anasayfa_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => YemekSiparisDetayCubit()),
        BlocProvider(create: (context) => SepetYemeklerDetayCubit()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BottomPage(),
      ),
    );
  }
}

