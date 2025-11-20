import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/lead.dart';

class LeadProvider extends ChangeNotifier {
  List<Lead> _leads = [];
  String _filter = "All";

  List<Lead> get leads {
    if (_filter == "All") return _leads;
    return _leads.where((lead) => lead.status == _filter).toList();
  }

  String get filter => _filter;

  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }

  Future loadLeads() async {
    _leads = await DBHelper.instance.getLeads();
    notifyListeners();
  }

  Future addLead(Lead lead) async {
    await DBHelper.instance.insertLead(lead);
    await loadLeads();
  }

  Future updateLead(Lead lead) async {
    await DBHelper.instance.updateLead(lead);
    await loadLeads();
  }

  Future deleteLead(int id) async {
    await DBHelper.instance.deleteLead(id);
    await loadLeads();
  }
}
