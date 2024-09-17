import 'package:flutter/material.dart';
import 'package:imtxon/bloc/daromadlar_bloc/daromad_bloc.dart';
import 'package:imtxon/bloc/harajatlar_bloc/harajatlar_bloc.dart';
import 'package:imtxon/services/database_sql.dart';
import 'package:imtxon/views/screen/maneg_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseSql databaseSql = DatabaseSql();
  await databaseSql.init();
  runApp(MainApp(
    databaseSql: databaseSql,
  ));
}

class MainApp extends StatelessWidget {
  DatabaseSql databaseSql;
  MainApp({super.key, required this.databaseSql});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HarajatlarBloc(databaseSql: databaseSql)
            ..add(GetHarajatlarEvent()),
        ),
        BlocProvider(
          create: (context) =>
              DaromadBloc(databaseSql: databaseSql)..add(GetDaromadlarEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ManegScreen(),
      ),
    );
  }
}
