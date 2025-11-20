import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lead_provider.dart';
import '../models/lead.dart';

class AddLeadScreen extends StatefulWidget {
  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Lead"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Lead Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lead name is required";
                  }

                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return "Only letters allowed in name";
                  }

                  return null;
                },
              ),


              const SizedBox(height: 15),

              TextFormField(
                controller: _contactController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Contact (Phone)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Contact number is required";
                  }

                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return "Only numeric values allowed";
                  }

                  if (value.length < 10) {
                    return "Enter a valid 10-digit number";
                  }

                  return null;
                },
              ),


              const SizedBox(height: 15),

              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes (Optional)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    final newLead = Lead(
                      name: _nameController.text,
                      contact: _contactController.text,
                      notes: _notesController.text,
                      status: "New",
                    );

                    await Provider.of<LeadProvider>(context, listen: false)
                        .addLead(newLead);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lead Added Successfully"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Save Lead",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
