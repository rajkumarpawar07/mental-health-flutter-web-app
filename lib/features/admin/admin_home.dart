import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth/SignUp/data/user_model.dart';
import 'controller/admin_home_controller.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminHomeController controller = Get.put(AdminHomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 71, 233, 133),
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin Home',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.offAllNamed('/');
                },
                child: const Text('Logout')),
          )
        ],
      ),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        }
        return ListView.builder(
          itemCount: controller.users.length,
          itemBuilder: (context, index) {
            UserModel user = controller.users[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blue,
                ),
                onTap: () {
                  Get.to(() => UserDetailsPage(user: user));
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              ),
            );
          },
        );
      }),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final UserModel user;

  UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    DateTime lastActiveDate = user.lastActive.toDate();
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  user.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              Divider(height: 40, thickness: 2),
              DetailRow(
                icon: Icons.person,
                label: 'Age',
                value: '${user.age}',
              ),
              DetailRow(
                icon: Icons.person_outline,
                label: 'Gender',
                value: user.gender,
              ),
              DetailRow(
                icon: Icons.phone,
                label: 'Phone Number',
                value: user.phoneNumber,
              ),
              DetailRow(
                icon: Icons.local_fire_department,
                label: 'Streak',
                value: '${user.streak}',
              ),
              DetailRow(
                icon: Icons.access_time,
                label: 'Last Active',
                value: lastActiveDate.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
