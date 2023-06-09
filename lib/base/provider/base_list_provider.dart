import 'package:flutter/material.dart';

class BaseListProvider<T> extends ChangeNotifier {
  final List<T> _list = [];

  List<T> get list => _list;


  bool _hasMore = true;


  bool get hasMore => _hasMore;

  String _nextPageUrl = "";

  String get nextPageUrl => _nextPageUrl;

  int _totalCount = 0;

  int get totalCount => _totalCount;

  void setNextPageUrl(String nextPageUrl) {
    this._nextPageUrl = nextPageUrl;
  }

  void setTotalCount(int count) {
    _totalCount = count;
  }

  void setHasMore(bool hasMore) {
    _hasMore = hasMore;
  }

  void add(T data) {
    _list.add(data);
    notifyListeners();
  }

  void addAll(List<T> listData) {
    _list.addAll(listData);
    notifyListeners();
  }

  void insert(int index, T data) {
    _list.insert(index, data);
    notifyListeners();
  }

  void insertAll(int index, List<T> listData) {
    _list.insertAll(index, listData);
    notifyListeners();
  }

  void remove(T data) {
    _list.remove(data);
    notifyListeners();
  }

  void removeAt(int position) {
    _list.removeAt(position);
    notifyListeners();
  }

  void clear() {
    _list.clear();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
