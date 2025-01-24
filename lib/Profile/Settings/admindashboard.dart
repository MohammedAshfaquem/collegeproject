import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to update complaint status and add a reply
  Future<void> _updateComplaint(
      String complaintId, String status, String reply) async {
    await _firestore.collection('feedback').doc(complaintId).update({
      'status': status,
      'adminReply': reply,
    });
  }

  // Show dialog to update complaint details
  void _showUpdateDialog(
      BuildContext context, String complaintId, String currentStatus) {
    final TextEditingController _replyController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Complaint'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dropdown for status selection
            DropdownButtonFormField<String>(
              value: currentStatus,
              items: ['Pending', 'Resolved']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (newStatus) {
                currentStatus = newStatus ?? 'Pending';
              },
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 10),
            // Text field for admin reply
            TextField(
              controller: _replyController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Admin Reply',
                hintText: 'Enter a reply for the complaint',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateComplaint(complaintId, currentStatus,
                  _replyController.text.trim());
              Navigator.pop(context);
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('feedback')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No complaints to review.'));
          }

          final complaints = snapshot.data!.docs;

          return ListView.builder(
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];

              return ListTile(
                title: Text(complaint['complaint']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status: ${complaint['status']}',
                      style: TextStyle(
                        color: complaint['status'] == 'Pending'
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ),
                    if (complaint['adminReply'] != null)
                      Text('Reply: ${complaint['adminReply']}'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _showUpdateDialog(
                    context,
                    complaint.id,
                    complaint['status'],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
