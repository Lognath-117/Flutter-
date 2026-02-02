import 'package:flutter/material.dart';

void main() => runApp(const A());

class A extends StatelessWidget {
  const A({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: B(),
    );
  }
}

class B extends StatefulWidget {
  const B({super.key});

  @override
  State<B> createState() => C();
}

class C extends State<B> {
  final List<Map<String, String>> s = [];

  final Map<String, TextEditingController> c = {
    "Name": TextEditingController(),
    "Date of Birth": TextEditingController(),
    "Blood Group": TextEditingController(),
    "Address": TextEditingController(),
    "Parent Name": TextEditingController(),
  };

  Widget f(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: c[label],
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ).copyWith(labelText: label),
      ),
    );
  }

  void d() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Student Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: c.keys.map(f).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: a,
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  void a() {
    final e = c.entries
        .where((x) => x.value.text.isEmpty)
        .map((x) => x.key)
        .toList();

    if (e.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Missing Fields"),
          content: Text("Fill: ${e.join(', ')}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      s.add({
        "name": c["Name"]!.text,
        "dob": c["Date of Birth"]!.text,
        "blood": c["Blood Group"]!.text,
        "address": c["Address"]!.text,
        "parent": c["Parent Name"]!.text,
      });
    });

    c.values.forEach((x) => x.clear());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STUDENT MANAGEMENT SYSTEM"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: s.isEmpty
          ? const Center(child: Text("No Students Details Added"))
          : ListView(
              children: s.asMap().entries.map((e) {
                final i = e.key;
                final x = e.value;

                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Colors.orange[50],
                  child: ExpansionTile(
                    title: Text(
                      x["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    children: [
                      ListTile(
                        title: Text("Date of Birth: ${x["dob"]}"),
                      ),
                      ListTile(
                        title: Text("Blood Group: ${x["blood"]}"),
                      ),
                      ListTile(
                        title: Text("Address: ${x["address"]}"),
                      ),
                      ListTile(
                        title: Text("Parent Name: ${x["parent"]}"),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              setState(() => s.removeAt(i)),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: d,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
