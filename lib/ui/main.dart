import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todosql/cubit/cubit.dart';

void main() {
  runApp(const todo());
}

class todo extends StatelessWidget {
  const todo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => todocubit()..createDB(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('TODO'),
            centerTitle: true,
          ),
        ),));
  }
}
