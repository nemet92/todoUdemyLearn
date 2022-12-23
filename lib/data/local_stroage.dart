import 'package:todoudemy/model/task_model.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<Task> getTask({required String id});
  Future<List> getAllTask();

  Future<bool> delete({required Task task});
  Future<Task> updateTask({required Task task});
}
