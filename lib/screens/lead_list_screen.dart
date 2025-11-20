import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/lead_provider.dart';
import '../models/lead.dart';
import 'add_lead_screen.dart';
import 'lead_detail_screen.dart';

class LeadListScreen extends StatelessWidget {
  final List<String> statusFilters = [
    "All",
    "New",
    "Contacted",
    "Converted",
    "Lost"
  ];

  @override
  Widget build(BuildContext context) {
    final leadProvider = Provider.of<LeadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mini Lead Manager"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddLeadScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: statusFilters.length,
              itemBuilder: (context, index) {
                final status = statusFilters[index];
                final selected = leadProvider.filter == status;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(status),
                    selected: selected,
                    selectedColor: Colors.blue,
                    onSelected: (_) {
                      leadProvider.setFilter(status);
                    },
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔽 Lead List
          Expanded(
            child: leadProvider.leads.isEmpty
                ? const Center(child: Text("No leads available"))
                : ListView.builder(
              itemCount: leadProvider.leads.length,
              itemBuilder: (context, index) {
                final lead = leadProvider.leads[index];
                return LeadCard(lead: lead);
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddLeadScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LeadCard extends StatelessWidget {
  final Lead lead;

  const LeadCard({super.key, required this.lead});

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          lead.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(lead.contact),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: getStatusColor(lead.status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            lead.status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LeadDetailScreen(lead: lead),
            ),
          );
        },
      ),
    );
  }
}
