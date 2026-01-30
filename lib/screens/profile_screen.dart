import 'package:api_flutter/cubit/user_cubit.dart';
import 'package:api_flutter/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      builder: (context, state) {
        if (state is GetUserLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is GetUserSuccess) {
          final user = state.user;

          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                //! Profile Picture
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      user.profilePic != null && user.profilePic!.isNotEmpty
                      ? NetworkImage(user.profilePic!)
                      : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                ),
                const SizedBox(height: 16),

                //! Name
                ListTile(
                  title: Text(user.name),
                  leading: const Icon(Icons.person),
                ),

                //! Email
                ListTile(
                  title: Text(user.email),
                  leading: const Icon(Icons.email),
                ),

                //! Phone number
                ListTile(
                  title: Text(user.phone),
                  leading: const Icon(Icons.phone),
                ),

                //! Address (if exists)
                if (user.location != null)
                  ListTile(
                    title: Text(user.location!['type'] ?? 'Unknown'),
                    leading: const Icon(Icons.location_city),
                  ),
              ],
            ),
          );
        }

        // حالة افتراضية
        return const Scaffold(body: Center(child: Text('No data available')));
      },
    );
  }
}
