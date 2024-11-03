// lib/user_detail_screen.dart

import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  final ApiService apiService = ApiService();

  UserDetailScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<User>(
        future: apiService.fetchUserById(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfoCard(user),
                  SizedBox(height: 16),
                  _buildAddressCard(user),
                  SizedBox(height: 16),
                  _buildCompanyCard(user),
                ],
              ),
            );
          } else {
            return Center(child: Text("No details found"));
          }
        },
      ),
    );
  }

  // User Information Card
  Widget _buildUserInfoCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1.5),
            SizedBox(height: 8),
            _buildInfoRow(Icons.person, 'Username', user.username),
            _buildInfoRow(Icons.email, 'Email', user.email),
            _buildInfoRow(Icons.phone, 'Phone', user.phone),
            _buildInfoRow(Icons.language, 'Website', user.website),
          ],
        ),
      ),
    );
  }

  // Address Information Card
  Widget _buildAddressCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1.5),
            SizedBox(height: 8),
            Text(
              '${user.address.street}, ${user.address.suite}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '${user.address.city}, ${user.address.zipcode}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Company Information Card
  Widget _buildCompanyCard(User user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(thickness: 1.5),
            SizedBox(height: 8),
            _buildInfoRow(Icons.business, 'Name', user.company.name),
            _buildInfoRow(
                Icons.lightbulb, 'Catch Phrase', user.company.catchPhrase),
            _buildInfoRow(Icons.build, 'Business', user.company.bs),
          ],
        ),
      ),
    );
  }

  // Helper method for building rows with icons and text
  Widget _buildInfoRow(IconData icon, String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Expanded(
            child: Text(
              info,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
