import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _CommonAppBarState createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: Text(
              'Legacy Events',
              textAlign: TextAlign.left,
            ),
          ),
          if (_userName.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                'Welcome, $_userName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
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
