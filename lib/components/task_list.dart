import 'package:flutter/material.dart';
import 'package:todo_list_app/components/color.dart';
import 'package:todo_list_app/components/empty_list.dart';
import 'package:todo_list_app/helper/task_storage.dart';
import 'package:todo_list_app/tasks/add_task.dart';

class TaskList extends StatefulWidget {
  final List<String> tasks;
  const TaskList({super.key, required this.tasks});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final Set<String> _selectedTasks = {};

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _deleteSelected() async {
    if (_selectedTasks.isEmpty) {
      _toast("Please select at least one task!");
      return;
    }

    if (_selectedTasks.isEmpty) {
      _toast("Please select at least one task!");
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (c) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: AppColors.mainColor,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Are you sure you want to delete ${_selectedTasks.length} task?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontFamily: 'Jaro',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7a7a73),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(c, false),
                    child: Text(
                      "Exit",
                      style: TextStyle(color: Colors.white, fontFamily: 'Jaro'),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(c, true),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.white, fontFamily: 'Jaro'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirm == true) {
      setState(() {
        widget.tasks.removeWhere((task) => _selectedTasks.contains(task));
        _selectedTasks.clear();
      });

      // Ye line add karni hai
      await TaskStorage.saveTasks(widget.tasks);
    }
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = widget.tasks.removeAt(oldIndex);
      widget.tasks.insert(newIndex, item);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSavedTasks();
  }

  void _loadSavedTasks() async {
    final savedTasks = await TaskStorage.loadTasks();
    setState(() {
      widget.tasks
        ..clear()
        ..addAll(savedTasks); // update the widget's tasks list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0, left: 10, right: 0, bottom: 0),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Task",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: AppColors.btnTextColor,
                      fontFamily: 'Jaro',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _deleteSelected,
                        icon: Ink(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(
                                color: AppColors.addTask,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.delete,
                            size: 22,
                            color: AppColors.addTask,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddTask(activities: widget.tasks),
                            ),
                          );
                        },
                        icon: Ink(
                          decoration: ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(
                                color: AppColors.addTask,
                                width: 1.5,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 22,
                            color: AppColors.addTask,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: widget.tasks.isEmpty
                ? EmptyList()
                : ReorderableListView.builder(
                    itemCount: widget.tasks.length,
                    onReorder: _reorder,
                    proxyDecorator: (child, index, anim) => Material(
                      color: Colors.transparent,
                      elevation: 6,
                      borderRadius: BorderRadius.circular(14),
                      child: child,
                    ),
                    itemBuilder: (context, index) {
                      final text = widget.tasks[index];
                      return ListTile(
                        key: ValueKey('item_${index}_$text'),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        visualDensity: VisualDensity(vertical: -1),
                        leading: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedTasks.contains(
                                widget.tasks[index],
                              )) {
                                _selectedTasks.remove(widget.tasks[index]);
                              } else {
                                _selectedTasks.add(widget.tasks[index]);
                              }
                            });
                          },
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.addTask,
                                width: 2,
                              ),
                              borderRadius:
                                  _selectedTasks.contains(widget.tasks[index])
                                  ? BorderRadius.circular(0)
                                  : BorderRadius.circular(4),
                              color:
                                  _selectedTasks.contains(widget.tasks[index])
                                  ? AppColors.addTask
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        title: Text(
                          widget.tasks[index],
                          style: TextStyle(fontSize: 14, fontFamily: 'Jaro'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
