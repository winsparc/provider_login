import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Users List")),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())

          : provider.error != null
              ? Center(child: Text(provider.error!))

              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    final user = provider.users[index];

                    // Build image URL
                    final imageUrl = user.image.isNotEmpty
                        ? "http://10.229.74.113:3000/uploads/${user.image}"
                        : null;
print(imageUrl);
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey[300],
                          backgroundImage:
                              imageUrl != null ? NetworkImage(imageUrl) : null,
                          child: imageUrl == null
                              ? const Icon(Icons.person, color: Colors.grey)
                              : null,
                        ),
                        title: Text(
                          user.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          user.email,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
