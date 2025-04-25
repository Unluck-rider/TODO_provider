import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/todo_viewmodel.dart';
import '../utils/responsive.dart';
import 'add_todo_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoViewModel>(
      builder: (_, todoVM, __) => Scaffold(
        appBar: AppBar(title: Text("TODO")),
        body: Responsive(
          mobile: _buildTodoLayout(context, todoVM),
          tablet: Center(
            child: Container(
              width: 500,
              child: _buildTodoLayout(context, todoVM),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddTodoView()),
            );
          },
          child: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }

  Widget _buildTodoLayout(BuildContext context, TodoViewModel todoVM) {
    final isTablet = Responsive.isTablet(context);
    final crossAxisCount = isTablet ? 3 : 2;

    if (todoVM.todos.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset("assets/to-do-list.png", fit: BoxFit.contain),
                      Container(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Text(
                  "No TODO found",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )


        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  itemCount: todoVM.todos.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final todo = todoVM.todos[index];
                    final note = todo.note;
                    final isLongNote = note.length > 50;

                    return Container(
                      height: isLongNote ? 230 : 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green.shade100, Colors.green.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            todo.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              decoration: todo.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            isLongNote ? '${note.substring(0, 50)}...' : note,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.visibility, color: Colors.blue),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(todo.title),
                                      content: SingleChildScrollView(
                                        child: Text(
                                          note,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('Close'),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  todo.isDone
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: Colors.green.shade600,
                                ),
                                onPressed: () => todoVM.toggleTodo(todo.id),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete_forever, color: Colors.redAccent),
                                onPressed: () => todoVM.deleteTodo(todo.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
