import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_manage/user_type.dart';
import 'admin_login.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  TextEditingController _searchController = TextEditingController();
  late List<ContributorData> _contributors = [];

  @override
  void initState() {
    super.initState();
    _loadContributors();
  }

  Future<void> _loadContributors() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('contributors').get();
    final contributorsData = snapshot.docs
        .map((doc) => ContributorData.fromSnapshot(doc))
        .toList();
    setState(() {
      _contributors = contributorsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent navigating back using device back button
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin Dashboard'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserTypePage()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
          automaticallyImplyLeading: false, // Remove back icon
        ),
        body: ListView.builder(
          itemCount: _contributors.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if ((_contributors[index].solidWaste != null &&
                    _contributors[index].liquidWaste != null) ||
                    (_contributors[index].solidWaste == 0.0 &&
                        _contributors[index].liquidWaste == 0.0)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContributorReportPage(
                        contributor: _contributors[index],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contributor data is incomplete.'),
                    ),
                  );
                }
              },
              child: ContributorCard(
                contributor: _contributors[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContributorCard extends StatelessWidget {
  final ContributorData contributor;

  const ContributorCard({required this.contributor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(contributor.name),
        subtitle: Text(contributor.email),
      ),
    );
  }
}

class ContributorData {
  final String name;
  final String email;
  final double? solidWaste;
  final double? liquidWaste;

  ContributorData({
    required this.name,
    required this.email,
    this.solidWaste,
    this.liquidWaste,
  });

  factory ContributorData.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ContributorData(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      solidWaste: double.tryParse(data['solidWaste']?.toString() ?? '0.0'),
      liquidWaste: double.tryParse(data['liquidWaste']?.toString() ?? '0.0'),
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
            if (contributor.solidWaste != null && contributor.liquidWaste != null)
              Text(
                'Solid Waste: ${contributor.solidWaste?.toStringAsFixed(2)} kg',
              ),
            if (contributor.solidWaste != null && contributor.liquidWaste != null)
              Text(
                'Liquid Waste: ${contributor.liquidWaste?.toStringAsFixed(2)} liters',
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AdminDashboard(),
  ));
}
