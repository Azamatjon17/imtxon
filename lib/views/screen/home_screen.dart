import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtxon/bloc/daromadlar_bloc/daromad_bloc.dart';
import 'package:imtxon/bloc/harajatlar_bloc/harajatlar_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? umumiyDaromad;
  double? umumiyHarajat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: context.read<HarajatlarBloc>(),
            listener: (context, state) {
              // if (state is LodingState) {
              //   context.read<HarajatlarBloc>().add(GetHarajatlarEvent());
              // }

              if (state is LoadedState) {
                umumiyDaromad = 0;
                for (var harajat in state.harajatlar) {
                  umumiyHarajat = umumiyHarajat! + harajat.summa;
                }
                setState(() {});
              }
            },
          ),
          BlocListener(
            bloc: context.read<DaromadBloc>()..add(GetDaromadlarEvent()),
            listener: (context, state) {
              // if (state is LodingDarmoadState) {
              //   context.read<DaromadBloc>().add(GetDaromadlarEvent());
              // }
              if (state is LoadedDaromadState) {
                umumiyDaromad = 0;
                for (var daromad in state.daromadlar) {
                  umumiyDaromad = umumiyDaromad! + daromad.summa;
                }
                setState(() {});
              }
            },
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Umumiy daromad : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  umumiyDaromad == null
                      ? const CircularProgressIndicator()
                      : Text(umumiyDaromad!.toStringAsFixed(2))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Umumiy harajat : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  umumiyHarajat == null
                      ? const CircularProgressIndicator()
                      : Text(umumiyHarajat!.toStringAsFixed(2))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
