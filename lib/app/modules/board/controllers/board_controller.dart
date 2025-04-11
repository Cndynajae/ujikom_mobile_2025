import 'package:get/get.dart';

import 'dart:async';

// File: board_controller.dart
import 'package:flutter/foundation.dart';

class BoardItem {
  final String id;
  final String title;
  final String description;

  BoardItem({
    required this.id,
    required this.title,
    this.description = '',
  });

  BoardItem copyWith({
    String? title,
    String? description,
  }) {
    return BoardItem(
      id: this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

class BoardColumn {
  final String id;
  final String title;
  final List<BoardItem> items;

  BoardColumn({
    required this.id,
    required this.title,
    List<BoardItem>? items,
  }) : items = items ?? [];
}

class BoardController extends ChangeNotifier {
  List<BoardColumn> _columns = [];

  List<BoardColumn> get columns => _columns;

  // Inisialisasi board dengan kolom default
  void initializeBoard(List<BoardColumn> columns) {
    _columns = columns;
    notifyListeners();
  }

  // Menambahkan kolom baru
  void addColumn(BoardColumn column) {
    _columns.add(column);
    notifyListeners();
  }

  // Menghapus kolom
  void removeColumn(int columnIndex) {
    if (columnIndex >= 0 && columnIndex < _columns.length) {
      _columns.removeAt(columnIndex);
      notifyListeners();
    }
  }

  // Menambahkan item ke kolom
  void addItem(int columnIndex, BoardItem item) {
    if (columnIndex >= 0 && columnIndex < _columns.length) {
      _columns[columnIndex].items.add(item);
      notifyListeners();
    }
  }

  // Menghapus item dari kolom
  void removeItem(int columnIndex, int itemIndex) {
    if (columnIndex >= 0 &&
        columnIndex < _columns.length &&
        itemIndex >= 0 &&
        itemIndex < _columns[columnIndex].items.length) {
      _columns[columnIndex].items.removeAt(itemIndex);
      notifyListeners();
    }
  }

  // Memperbarui item
  void updateItem(int columnIndex, int itemIndex, BoardItem updatedItem) {
    if (columnIndex >= 0 &&
        columnIndex < _columns.length &&
        itemIndex >= 0 &&
        itemIndex < _columns[columnIndex].items.length) {
      _columns[columnIndex].items[itemIndex] = updatedItem;
      notifyListeners();
    }
  }

  // Memindahkan item ke kolom lain (untuk drag & drop)
  void moveItem(BoardItem item, int targetColumnIndex) {
    // Cari item di semua kolom
    for (int colIndex = 0; colIndex < _columns.length; colIndex++) {
      final column = _columns[colIndex];
      final itemIndex = column.items.indexWhere((i) => i.id == item.id);

      // Jika item ditemukan
      if (itemIndex != -1) {
        // Jika kolom tujuan bukan kolom sumber
        if (colIndex != targetColumnIndex) {
          // Hapus dari kolom sumber
          final movedItem = column.items.removeAt(itemIndex);
          // Tambahkan ke kolom tujuan
          _columns[targetColumnIndex].items.add(movedItem);
          notifyListeners();
        }
        break;
      }
    }
  }

  // Memindahkan item dalam kolom yang sama (mengubah urutan)
  void reorderItemInColumn(int columnIndex, int oldIndex, int newIndex) {
    if (columnIndex >= 0 &&
        columnIndex < _columns.length &&
        oldIndex >= 0 &&
        oldIndex < _columns[columnIndex].items.length &&
        newIndex >= 0 &&
        newIndex <= _columns[columnIndex].items.length) {
      // Koreksi indeks jika diperlukan
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final item = _columns[columnIndex].items.removeAt(oldIndex);
      _columns[columnIndex].items.insert(newIndex, item);
      notifyListeners();
    }
  }
}
