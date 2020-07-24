import 'package:avalinks/models/home/VendorMenuItem.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:flutter/material.dart';

class VendorHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: new Image.asset(
            'images/icon_app_logo.png',
            fit: BoxFit.cover,
            height: 40,
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Container(
          child: GridView.count(
              crossAxisCount: 2,
              children: <VendorMenuItem>[
                VendorMenuItem('Service', 'images/icon_service.png'),
                VendorMenuItem('Blogs', 'images/icon_blog.png'),
                VendorMenuItem('Subscription', 'images/icon_subscription.png'),
                VendorMenuItem('Profile', 'images/icon_profile.png'),
                VendorMenuItem(
                    'Change Password', 'images/icon_change_password.png'),
                VendorMenuItem('Logout', 'images/icon_logout.png'),
              ].map((VendorMenuItem option) {
                return new GridTile(
                  child: GestureDetector(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Theme.of(context).primaryColor),
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Image.asset(option.imagePath),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5),
                              child: Text(
                                option.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      switch (option.title) {
                        case 'Service':
                          Navigator.of(context).pushNamed('/vendor_service_list');
                          break;
                        case 'Blogs':
                          Navigator.of(context).pushNamed('/blog_list');
                          break;
                        case 'Subscription':
                          Navigator.of(context).pushNamed('/subscription');
                          break;
                        case 'Profile':
                          Navigator.of(context).pushNamed('/profile');
                          break;
                        case 'Change Password':
                          Navigator.of(context).pushNamed('/changePassword');
                          break;
                        case 'Logout':
                          logout();
                          break;
                      }
                    },
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }

  logout() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Logout'),
              content: Text('Are you sure you want to logout?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    PrefsUtils.clearPreference();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
