import 'package:flutter/material.dart';
import 'package:task_manager/data/model/auth_utility.dart';
import 'package:task_manager/ui/screens/auth/login_screen.dart';
import 'package:task_manager/ui/screens/update_profile.dart';


class UserProfileBanner extends StatefulWidget {
  const UserProfileBanner({
    super.key,
  });

  @override
  State<UserProfileBanner> createState() => _UserProfileBannerState();
}

class _UserProfileBannerState extends State<UserProfileBanner> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      tileColor: Colors.green,
      leading: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfile()) );
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            AuthUtility.userInfo.data?.photo ?? '',
          ),
          onBackgroundImageError: (_, __) {
            const Icon(Icons.image);
          },
          radius: 15,
        ),
      ),
      title: Text(
        '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      subtitle: Text(
        AuthUtility.userInfo.data?.email ?? 'Unknown',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
      trailing: IconButton(
        onPressed: () async {
          await AuthUtility.clearUserInfo();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()), (
                route) => false);
          }
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }
}