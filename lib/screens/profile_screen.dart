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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        // 1. حالة التحميل
        if (state is GetUserLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. حالة نجاح جلب البيانات
        if (state is GetUserSuccess) {
          final user = state.user;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                //! صورة الملف الشخصي - تم تنظيف فحص الـ null لأن الحقل غير قابل للعدم
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: user.profilePic.isNotEmpty
                        ? NetworkImage(user.profilePic)
                        : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(height: 24),

                //! الاسم
                _buildInfoTile(
                  title: user.name,
                  subtitle: 'Name',
                  icon: Icons.person,
                ),

                //! البريد الإلكتروني
                _buildInfoTile(
                  title: user.email,
                  subtitle: 'Email',
                  icon: Icons.email,
                ),

                //! رقم الهاتف
                _buildInfoTile(
                  title: user.phone,
                  subtitle: 'Phone',
                  icon: Icons.phone,
                ),

                //! العنوان - الفحص هنا ضروري لأنه nullable في الموديل
                if (user.location != null)
                  _buildInfoTile(
                    title: user.location!['name'] ?? 'No specific address',
                    subtitle: 'Location Type: ${user.location!['type'] ?? 'Unknown'}',
                    icon: Icons.location_on,
                  ),
              ],
            ),
          );
        }

        // 3. الحالة الافتراضية (في حال عدم وجود بيانات)
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: const Center(child: Text('No user data available.')),
        );
      },
    );
  }

  /// ويدجت مساعدة لبناء الأسطر بشكل منظم ونظيف
  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0.5,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        leading: Icon(icon, color: Colors.blue),
      ),
    );
  }
}