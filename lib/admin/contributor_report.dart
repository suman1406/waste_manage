import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class ContributorData {
  final String name;
  final String email;
  final double solidWaste;
  final double liquidWaste;

  ContributorData({
    required this.name,
    required this.email,
    required this.solidWaste,
    required this.liquidWaste,
  });

  factory ContributorData.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ContributorData(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      solidWaste: double.tryParse(data['solidWaste'] ?? '0.0') ?? 0.0,
      liquidWaste: double.tryParse(data['liquidWaste'] ?? '0.0') ?? 0.0,
    );
  }
}

class ContributorReportPage extends StatelessWidget {
  final ContributorData contributor;

  const ContributorReportPage({required this.contributor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contributor Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${contributor.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Email: ${contributor.email}'),
            SizedBox(height: 10),
            Text('Solid Waste: ${contributor.solidWaste.toStringAsFixed(2)} kg'),
            Text('Liquid Waste: ${contributor.liquidWaste.toStringAsFixed(2)} liters'),
          ],
        ),
      ),
    );
  }
}
