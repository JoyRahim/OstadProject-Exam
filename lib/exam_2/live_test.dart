//Live Test 2
import 'package:flutter/material.dart';

void main() {
  runApp(const EmployeeApp());
}

class EmployeeApp extends StatelessWidget {
  const EmployeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Employee Form',
      debugShowCheckedModeBanner: false,
      home: EmployeeFormScreen(),
    );
  }
}

class EmployeeFormScreen extends StatefulWidget {
  const EmployeeFormScreen({super.key});

  @override
  _EmployeeFormScreenState createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();

  void _addEmployee() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final age = _ageController.text;
      final salary = _salaryController.text;

      // You can handle the form data here (e.g., save to a database)

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee Added: $name, Age: $age, Salary: $salary')),
      );

      // Clear the fields
      _nameController.clear();
      _ageController.clear();
      _salaryController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Employee')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter name' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter age' : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _salaryController,
                  decoration: const InputDecoration(labelText: 'Salary'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter salary' : null,
                ),
                const SizedBox(height: 25),
                Center(
                  child: ElevatedButton(
                    onPressed: _addEmployee,
                    child: const Text('Add Employee'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
