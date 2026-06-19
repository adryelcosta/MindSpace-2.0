import 'package:flutter/material.dart';

class Task {
  String name;
  String date;
  String description;
  String priority;
  Color priorityColor;

  Task({
    required this.name,
    required this.date,
    required this.description,
    required this.priority,
    required this.priorityColor,
  });
}