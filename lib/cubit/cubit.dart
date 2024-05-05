import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todosql/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class todocubit extends Cubit<CubitStates> {
  todocubit() : super(initialState());
}

late Database db;
void createDB() async {
  await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (db, version) {
      db.execute('create table tasks(id integer,number integer,note text)');
    },
  ).then((value) {
    print('Create DB');
    db = value;
  }).catchError((error) {
    print(error.toString());
  });
}

void insert({required String note, required int num}) async {
  await db
      .rawInsert("insert into tasks(number,note) values($num,$note) ")
      .then((value) {
    print('Success Insert $value');
  }).catchError((error) {
    print(error.toString());
  });
}

void update({required String note, required int num, required int id}) async {
  await db.rawUpdate(
      "update tasks set note=? , number=? where id=?", [note, num, id]);
}

void delete({required int id}) async {
  await db.rawDelete('''
  delete  from tasks where id=?
''', [id]).then((value) {
    print('Deleted Successfully');
    emit(deletestate());
  });
}

void read() async {
  List<Map> dbread =await db.rawQuery(''' select * from tasks
''');

}
