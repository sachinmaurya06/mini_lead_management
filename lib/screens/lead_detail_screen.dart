import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/lead.dart';
import '../providers/lead_provider.dart';

class LeadDetailScreen extends StatefulWidget {
  final Lead lead;

  const LeadDetailScreen({super.key, required this.lead});

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController contactController;
  late TextEditingController notesController;

  final List<String> statusList = [
    "New",
    "Contacted",
    "Converted",
    "Lost"
  ];

  late String selectedStatus;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.lead.name);
    contactController = TextEditingController(text: widget.lead.contact);
    notesController = TextEditingController(text: widget.lead.notes);
    selectedStatus = widget.lead.status;
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "New":
        return Colors.blue;
      case "Contacted":
        return Colors.orange;
      case "Converted":
        return Colors.green;
      case "Lost":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final leadProvider = Provider.of<LeadProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lead Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await leadProvider.deleteLead(widget.lead.id!);

              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Lead Deleted")),
              );
            },
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Lead Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: contactController,
                decoration: const InputDecoration(
                  labelText: "Contact",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Contact is required";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Lead Status",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusList.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: getStatusColor(selectedStatus).withOpacity(0.1),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Update Lead"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {

                    Lead updatedLead = Lead(
                      id: widget.lead.id,
                      name: nameController.text,
                      contact: contactController.text,
                      notes: notesController.text,
                      status: selectedStatus,
                    );

                    await leadProvider.updateLead(updatedLead);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lead Updated Successfully"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),

              const SizedBox(height: 20),

              OutlinedButton.icon(
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  "Delete Lead",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () async {
                  await leadProvider.deleteLead(widget.lead.id!);
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lead Deleted Successfully")),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
