import 'package:flutter/material.dart';
import 'task_model.dart';
import 'new_task_screen.dart'; 
import 'edit_task_screen.dart'; 
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final String userName;
  const TaskListScreen({super.key, required this.userName});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  static const Color primaryColor = Color(0xFF3B426B);
  static const Color lightBlueIcon = Color(0xFF4267B2);

  final List<Task> _tasks = [
    Task(
      name: "Estudar Flutter", 
      date: "25/05/2026", 
      description: "Anotação de exemplo do figma", 
      priority: "Média", 
      priorityColor: Colors.yellow[600]!
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings_suggest_outlined, color: lightBlueIcon, size: 35),
                    SizedBox(width: 8),
                    Text('MindSpace', style: TextStyle(color: primaryColor, fontSize: 22)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(Icons.reply, color: lightBlueIcon, size: 28),
                          Text('Voltar', style: TextStyle(color: primaryColor, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Olá, ${widget.userName}!',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Minhas Tarefas', style: TextStyle(fontSize: 16, color: primaryColor)),
                const SizedBox(height: 20),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      ...List.generate(_tasks.length, (index) {
                        return _buildTaskItem(_tasks[index], index);
                      }),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final Task? novaTarefa = await Navigator.push<Task>(
                              context,
                              MaterialPageRoute(builder: (context) => const NewTaskScreen()),
                            );
                            if (novaTarefa != null) {
                              setState(() {
                                _tasks.add(novaTarefa);
                              });
                            }
                          },
                          child: Container(
                            width: 140,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                            child: const Icon(Icons.add, color: primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: double.infinity, height: 60, color: primaryColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task tarefa, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: tarefa.priorityColor, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskDetailScreen(tarefa: tarefa)),
                );
                setState(() {});
              },
              child: Container(
                height: 35,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text(tarefa.name)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              final Task? tarefaEditada = await Navigator.push<Task>(
                context,
                MaterialPageRoute(builder: (context) => EditTaskScreen(tarefaAntiga: tarefa)),
              );
              if (tarefaEditada != null) {
                setState(() {
                  _tasks[index] = tarefaEditada;
                });
              }
            },
            child: const Icon(Icons.edit_document),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                _tasks.removeAt(index);
              });
            },
            child: const Icon(Icons.delete, color: lightBlueIcon),
          ),
        ],
      ),
    );
  }
}