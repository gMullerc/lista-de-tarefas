
import 'package:flutter_project/data/database.dart';
import 'package:sqflite/sqlite_api.dart';

import '../components/task.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT, '
      '$_nivel INTEGER)';

  static const String _tablename = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';
  static const String _nivel = 'nivel';

  save(Task tarefa) async {
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    Map<String,dynamic> taskMap = toMap(tarefa);
    if(itemExists.isEmpty){
      return await bancoDeDados.insert(_tablename, taskMap);

    }else{
      print('tarefa ja existe');
      return await bancoDeDados.update(_tablename, taskMap, where: '$_name = ?', whereArgs: [tarefa.nome],);
    }
  }


  Future<List<Task>> findAll() async {
    print('Acessando findAll');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print(result);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Map<String, dynamic> toMap(Task tarefa){
    final Map<String, dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_difficulty] = tarefa.dificuldade;
    mapaDeTarefas[_image] = tarefa.foto;

    return mapaDeTarefas;

  }
  Future<List<Task>> find(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    final Database bancoDeDados = await getDatabase();
    return bancoDeDados.delete(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
  }
}
