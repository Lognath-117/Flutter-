import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Confirmation App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Step 3 & 4: Function to show the AlertDialog
  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this item? This action cannot be undone.'),
          actions: <Widget>[
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _showSnackBar(context, 'Action Cancelled', Colors.grey);
              },
              child: const Text('CANCEL'),
            ),
            // Confirm Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _showSnackBar(context, 'Item Deleted Successfully', Colors.green);
              },
              child: const Text('DELETE', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Step 5: Function to show the SnackBar
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Action Confirmation')),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _showConfirmationDialog(context),
          icon: const Icon(Icons.delete),
          label: const Text('Delete Sensitive Data'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
      ),
    );
  }
}
