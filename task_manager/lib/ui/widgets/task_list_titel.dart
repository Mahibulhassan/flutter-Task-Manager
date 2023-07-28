import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final Color chipColor;
   const TaskListTile(
    this.chipColor, {super.key}
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Title will be here'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Title will be here'),
          const Text('Date'),
          Row(
            children: [
               Chip(
                label: const Text(
                  'New',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: chipColor,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_forever_outlined,
                    color: Colors.red.shade300,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
            ],
          )
        ],
      ),
    );
  }
}