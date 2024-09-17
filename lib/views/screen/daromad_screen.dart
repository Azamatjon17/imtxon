import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtxon/bloc/daromadlar_bloc/daromad_bloc.dart';
import 'package:imtxon/models/expans.dart';

class DaromadScreen extends StatefulWidget {
  const DaromadScreen({super.key});

  @override
  State<DaromadScreen> createState() => _DaromadScreenState();
}

class _DaromadScreenState extends State<DaromadScreen> {
  final fomrKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Daromadlar sahifasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder(
          bloc: context.read<DaromadBloc>(),
          builder: (context, state) {
            if (state is InitionDaromadState) {
              context.read<DaromadBloc>().add(GetDaromadlarEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is LodingDarmoadState) {
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
            if (state is ErorDaromadState) {
              Center(
                child: Text(state.massage),
              );
            }
            state as LoadedDaromadState;
            if (state.daromadlar.isEmpty) {
              return const Center(
                child: Text("Hech qanday ma'lumot yo'q"),
              );
            }
            return ListView.builder(
              itemCount: state.daromadlar.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.daromadlar[index].summa.toStringAsFixed(2)),
                  subtitle: Text(state.daromadlar[index].discription),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<DaromadBloc>().add(
                                DeleteDaromadEvent(
                                    expans: state.daromadlar[index]),
                              );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          editDaromad(state.daromadlar[index]);
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
        onPressed: addDaromad,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.add), Text("Incom")],
        ),
      ),
    );
  }

  addDaromad() {
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
                context.read<DaromadBloc>().add(
                      AddDaromadlarEvent(
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

  editDaromad(Expans expans) {
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
                context.read<DaromadBloc>().add(
                      EditDaromadEvent(
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
