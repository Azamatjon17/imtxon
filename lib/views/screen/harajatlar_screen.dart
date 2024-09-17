import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtxon/bloc/harajatlar_bloc/harajatlar_bloc.dart';
import 'package:imtxon/models/expans.dart';

class HarajatlarScreen extends StatefulWidget {
  const HarajatlarScreen({super.key});

  @override
  State<HarajatlarScreen> createState() => _HarajatlarScreenState();
}

class _HarajatlarScreenState extends State<HarajatlarScreen> {
  final fomrKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Harajatlar sahifasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder(
          bloc: context.read<HarajatlarBloc>(),
          builder: (context, state) {
            if (state is InitionState) {
              context.read<HarajatlarBloc>().add(GetHarajatlarEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LodingState) {
              return Column(
                children: [
                  for (int i = 0; i < 3; i++)
                    const SizedBox(
                      height: 50,
                      child: CircularProgressIndicator(),
                    )
                ],
              );
            }
            if (state is ErorState) {
              Center(
                child: Text(state.massage),
              );
            }
            state as LoadedState;
            if (state.harajatlar.isEmpty) {
              return const Center(
                child: Text("Hech qanday ma'lumot yo'q"),
              );
            }
            return ListView.builder(
              itemCount: state.harajatlar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.harajatlar[index].summa.toStringAsFixed(2)),
                  subtitle: Text(state.harajatlar[index].discription),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<HarajatlarBloc>().add(
                                DeleteHArajatEvent(
                                    expans: state.harajatlar[index]),
                              );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          editHarajat(state.harajatlar[index]);
                        },
                        icon: const Icon(Icons.edit),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addHarajat,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.add), Text("Harajat")],
        ),
      ),
    );
  }

  addHarajat() {
    double? summa;
    String? discription;
    String? kategory;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: fomrKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Summa',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Summani kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  summa = double.parse(newValue!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Katigori',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Katigory kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  kategory = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Izoh',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Izoh kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  discription = newValue!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Bekor qilish"),
          ),
          FilledButton(
            onPressed: () {
              if (fomrKey.currentState!.validate()) {
                fomrKey.currentState!.save();
                context.read<HarajatlarBloc>().add(
                      AddHarajatlarEvent(
                        expans: Expans(
                          id: 0,
                          summa: summa!,
                          discription: discription!,
                          kategory: kategory!,
                          createdDate: DateTime.now(),
                        ),
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Saqlash"),
          )
        ],
      ),
    );
  }

  editHarajat(Expans expans) {
    double summa = expans.summa;
    String discription = expans.discription;
    String kategory = expans.kategory;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: fomrKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Summa',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Summani kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  summa = double.parse(newValue!);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Katigori',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Katigory kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  kategory = newValue!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Izoh',
                ),
                validator: (value) {
                  if (value == null) {
                    return "Izoh kriting";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  discription = newValue!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Bekor qilish"),
          ),
          FilledButton(
            onPressed: () {
              if (fomrKey.currentState!.validate()) {
                fomrKey.currentState!.save();
                context.read<HarajatlarBloc>().add(
                      EditHArajatEvent(
                        expans: Expans(
                          id: expans.id,
                          summa: summa,
                          discription: discription,
                          kategory: kategory,
                          createdDate: expans.createdDate,
                        ),
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text("Saqlash"),
          )
        ],
      ),
    );
  }
}
