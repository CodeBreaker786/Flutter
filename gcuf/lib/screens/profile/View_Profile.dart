import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileViewer extends StatelessWidget {
  ProfileViewer(this.imgUrl, this.name, this.email);
  final String imgUrl, email, name;

//CollectionReference ref = Firestore.instance.collection("portal");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ProfileHeader(
              ctx: context,
              avatar: imgUrl != null
                  ? CachedNetworkImageProvider(imgUrl)
                  : AssetImage('images/person.jpg'),
              coverImage: imgUrl != null
                  ? CachedNetworkImageProvider(imgUrl)
                  : AssetImage('images/person.jpg'),
              title: name,
            ),
            const SizedBox(height: 10.0),
            UserInfo(email),
            //UserInfo(),
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  UserInfo(this.email);
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Location"),
                            subtitle: Text("Multan"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text(email),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: Text("Phone"),
                            subtitle: Text("99--99876-56"),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("About Me"),
                            subtitle: Text(
                                "This is a about me link and you can khow about me in this section."),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {Key key,
      @required this.ctx,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;
  final BuildContext ctx;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
              child: IconButton(

                  //color: Theme.of(context).primaryColor,
                  icon: Icon(
                    Icons.arrow_back,
                    size: 40,
                  ),
                  onPressed: () {
                    Navigator.pop(ctx);
                  })),
        ),
        Ink(
          height: 240,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 240,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 240,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 80,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 50,
      this.borderWidth = 5})
      : super(key: key);

  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'A',
      child: CircleAvatar(
          radius: radius + borderWidth,
          backgroundColor: borderColor,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor != null
                ? backgroundColor
                : Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: radius - borderWidth,
              backgroundImage: image,
            ),
          )),
    );
  }
}
