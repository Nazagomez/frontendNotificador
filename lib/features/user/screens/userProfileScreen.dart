import 'package:flutter/material.dart';
import 'package:notificador/features/user/services/userServices.dart';
import 'package:notificador/features/user/models/userModel.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().fetchUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6C63FF);
    const backgroundColor = Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar datos'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          }

          final user = snapshot.data!.first;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundColor: primaryColor,
                          child: Icon(Icons.person, size: 45, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(user.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(user.correo, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: const [
                                Text('12', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Eventos')
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: const [
                                Text('30', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('Conexiones')
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 247, 247, 248),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Editar perfil'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Notification Settings
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Configuración de notificaciones', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          value: true,
                          onChanged: (val) {},
                          title: const Text('Notificaciones push'),
                        ),
                        SwitchListTile(
                          value: true,
                          onChanged: (val) {},
                          title: const Text('Notificaciones por correo'),
                        ),
                        SwitchListTile(
                          value: true,
                          onChanged: (val) {},
                          title: const Text('Recordatorios de eventos'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Account Settings
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: const Text('Información personal'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.settings_outlined),
                        title: const Text('Preferencias'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}