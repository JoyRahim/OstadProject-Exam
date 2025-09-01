// Assignment 3
//Add Products CRUD Operations
import 'package:flutter/material.dart';

void main() {
  runApp(const GreetingApp());
}

class GreetingApp extends StatelessWidget {
  const GreetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Greeting App',
      home: GreetingHomePage(),
    );
  }
}

class GreetingHomePage extends StatelessWidget {
  const GreetingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Greeting App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hello, World! with red and bold text
              const Text(
                'Hello, World!',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),

              // Additional Text
              const SizedBox(height: 10.0),
              const Text(
                'Welcome to Flutter!',
                style: TextStyle(fontSize: 20.0),
              ),

              //Image (Flutter Logo from Internet)
              const SizedBox(height: 20.0),
              Image.network(
                'https://storage.googleapis.com/cms-storage-bucket/icon_flutter.0dbfcc7a59cd1cf16282.png',
                height: 200.0,
              ),

              // Button with green color and Snackbar
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Button Pressed!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('Press Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
