import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_app/child_model.dart';
import 'package:santa_app/cubit/child_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ChildCubit>().loadListChild();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Santa App'),
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<ChildCubit, ChildState>(
        builder: (context, state) {
          if (state is ChildInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ChildLoaded) {
            return state.children.isEmpty
                ? const Center(
                    child: Text("Data is Empty"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    itemCount: state.children.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<ChildCubit>().toggleChildStatus(index);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Name: ${state.children[index].name}'),
                                    const SizedBox(height: 4),
                                    Text(
                                        'Country: ${state.children[index].country}'),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Text('Status: '),
                                        Text(
                                          state.children[index].isNice
                                              ? 'Nice'
                                              : 'Naughty',
                                          style: TextStyle(
                                              color:
                                                  state.children[index].isNice
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
          }

          return const Center(
            child: Text('Add child please'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          _showAddChildDialog(context);
        },
        tooltip: 'Add Child',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddChildDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController countryController = TextEditingController();
    String? selectedStatus = 'Nice';

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Add Child'),
            content: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: countryController,
                      decoration: const InputDecoration(labelText: 'Country'),
                    ),
                    const SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedStatus,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setStateDialog(() {
                            selectedStatus = newValue;
                            print(newValue);
                          });
                        }
                      },
                      items: ['Nice', 'Naughty'].map((String status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  final ChildModel newChild = ChildModel(
                    name: nameController.text,
                    country: countryController.text,
                    isNice: selectedStatus == 'Nice',
                  );
                  context.read<ChildCubit>().addChild(childModel: newChild);
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
        });
      },
    );
  }
}
