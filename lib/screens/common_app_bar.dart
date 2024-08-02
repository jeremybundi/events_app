import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Legacy Events'),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Sign In') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            } else if (value == 'Sign Out') {
              // Handle sign out action
            } else if (value == 'Sign Up') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            return {'Sign In', 'Sign Out', 'Sign Up'}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
  }
}
