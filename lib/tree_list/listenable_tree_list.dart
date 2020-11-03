import 'package:flutter/foundation.dart';
import 'package:multi_level_list_view/collections/node_collections.dart';
import 'package:multi_level_list_view/iterable_tree/iterable_tree_update_provider.dart';
import 'package:multi_level_list_view/iterable_tree/listenable_iterable_tree.dart';
import 'package:multi_level_list_view/tree_list/tree_list.dart';

class ListenableTreeList<T extends Node<T>> extends ChangeNotifier
    with IterableTreeUpdateProvider<T>
    implements ListenableIterableTree<T> {
  ListenableTreeList._(TreeList<T> list) : _value = list;

  factory ListenableTreeList() => ListenableTreeList._(TreeList<T>());

  factory ListenableTreeList.from(List<Node<T>> list) =>
      ListenableTreeList._(TreeList.from(list));

  final TreeList<T> _value;

  @protected
  @visibleForTesting
  @override
  TreeList<T> get value => _value;

  @override
  Node<T> get root => _value.root;

  @override
  void add(T item, {String path}) {
    _value.add(item, path: path);
    notifyListeners();
    emitAddItems([item], path: path);
  }

  @override
  void addAll(Iterable<T> iterable, {String path}) {
    _value.addAll(iterable, path: path);
    notifyListeners();
    emitAddItems(iterable, path: path);
  }

  @override
  void insert(T item, int index, {String path}) {
    _value.insert(item, index, path: path);
    notifyListeners();
    emitInsertItems([item], index, path: path);
  }

  @override
  void insertAll(Iterable<T> iterable, int index, {String path}) {
    _value.insertAll(iterable, index, path: path);
    notifyListeners();
    emitInsertItems(iterable, index, path: path);
  }

  @override
  void remove(T value, {String path}) {
    _value.remove(value, path: path);
    notifyListeners();
    emitRemoveItems([value], path: path);
  }

  @override
  T removeAt(int index, {String path}) {
    final item = _value.removeAt(index, path: path);
    notifyListeners();
    emitRemoveItems([item], index: index, path: path);
    return item;
  }

  @override
  void removeItems(Iterable<Node<T>> iterable, {String path}) {
    _value.removeItems(iterable, path: path);
    notifyListeners();
    emitRemoveItems(iterable, path: path);
  }

  @override
  Iterable<Node<T>> clearAll({String path}) {
    final clearedItems = _value.clearAll(path: path);
    notifyListeners();
    emitRemoveItems(clearedItems, path: path);
    return clearedItems;
  }
}
