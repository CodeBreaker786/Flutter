import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/screen/BlogListScreen.dart';
import 'package:avalinks/screen/ChangePasswordScreen.dart';
import 'package:avalinks/screen/ProfileScreen.dart';
import 'package:avalinks/screen/user/ProductListScreen.dart';
import 'package:avalinks/screen/user/UserHomeScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserMainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainState();
  }
}

class MainState extends State<UserMainScreen> {
  String userId, fName, lName, email, phone, avatar;
  CountryData countryData;
  Widget currentFragment = UserHomeScreen();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUserData();
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: new Text(getTitle()),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: avatar == null
                        ? AssetImage('images/icon_profile.png')
                        : CachedNetworkImageProvider(avatar),
                    radius: 40,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      (fName == null && lName == null) ? '' : '$fName $lName',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      email == null ? '' : email,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: FlatButton(
                onPressed: () async {
                  dynamic cData = await Navigator.of(context).pushNamed('/get_country');
                  if (cData != null && cData is CountryData) {
                    await Utils().setCountry(cData);
                    setState(() {
                      countryData = cData;
                    });
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        countryData == null
                            ? 'Select Country'
                            : countryData.country_name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentFragment = UserHomeScreen();
                });
              },
            ),
            ListTile(
              title: Text(
                'Blogs',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.bubble_chart),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentFragment = BlogListScreen();
                });
              },
            ),
            ListTile(
              title: Text(
                'Products',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.add_shopping_cart),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentFragment = ProductListScreen();
                });
              },
            ),
            ListTile(
              title: Text(
                'Change Password',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.lock),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentFragment = ChangePasswordScreen();
                });
              },
            ),
            ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.edit_attributes),
              onTap: () async {
                Navigator.pop(context);
                bool profileUpdated = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ProfileScreen()));
                if (profileUpdated) {
                  initUserData();
                }
              },
            ),
            ListTile(
              title: Text(
                'Privacy & Policy',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.security),
              onTap: () async {
                Navigator.pop(context);
                const url =
                    'http://avalinks.freshcodes.in/avalinks_privacy_policy.html';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ],
        ),
      ),
      body: currentFragment,
    );
  }

  initUserData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    fName = await PrefsUtils.getStringPreference(AppConstant.F_NAME);
    lName = await PrefsUtils.getStringPreference(AppConstant.L_NAME);
    email = await PrefsUtils.getStringPreference(AppConstant.USER_EMAIL);
    phone = await PrefsUtils.getStringPreference(AppConstant.USER_PHONE);
    avatar = await PrefsUtils.getStringPreference(AppConstant.USER_PROFILE_PIC);
    setState(() {});
  }

  Future getCountry() async {
    countryData = await Utils().getCountry();
    if (countryData == null) {
      dynamic cData = await Navigator.of(context).pushNamed('/get_country');
      if (cData != null && cData is CountryData) {
        await Utils().setCountry(cData);
        setState(() {
          countryData = cData;
        });
      }
    }
  }

  getTitle() {
    if (currentFragment is UserHomeScreen) {
      return 'Home';
    } else if (currentFragment is BlogListScreen) {
      return 'Blogs';
    } else if (currentFragment is ProductListScreen) {
      return 'Products';
    } else if (currentFragment is ChangePasswordScreen) {
      return 'Change Password';
    }
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
