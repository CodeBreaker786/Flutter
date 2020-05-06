import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:university/models/PostModel.dart';
import 'package:university/models/UserModel.dart';
import 'package:university/providers/database.dart';
import 'package:uuid/uuid.dart';

CollectionReference portalRef = Firestore.instance.collection("portal");

class UploadScreen extends StatefulWidget {
  UploadScreen(this.cropedImage);
  final File cropedImage;

  @override
  _UploadScreenState createState() => _UploadScreenState(cropedImage);
}

class _UploadScreenState extends State<UploadScreen> {
  _UploadScreenState(this._imageFile);
  TextEditingController captionController = TextEditingController();
  bool isLoding = false;
  File _imageFile;
  User user;

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            cropFrameColor: Theme.of(context).primaryColor,
            toolbarTitle: 'Edit Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Edit Image',
        ));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<DataBase>(context).currentUser;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Upload Post",
          ),
          centerTitle: true,
          actions: <Widget>[
            isLoding != true
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () async {
                      await uploadFile(_imageFile);
                      Navigator.pop(context);
                    })
                : Container()
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            isLoding == true
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(child: LinearProgressIndicator()),
                  )
                : Container(),
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 11,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                              _imageFile,
                            ),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    child: Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          child: IconButton(
                              hoverColor: Theme.of(context).accentColor,
                              icon: Icon(
                                Icons.crop,
                                size: 30,
                              ),
                              onPressed: () {
                                _cropImage();
                              }),
                        ))),
              ],
            ),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  backgroundImage: user.url == true
                      ? CachedNetworkImageProvider(user.url)
                      : AssetImage('images/person.jpg'),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: captionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        filled: true,
                        labelText: 'Caption',
                        // helperText: "kh",
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Caption...",
                        fillColor: Colors.white70),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future uploadFile(image) async {
    setState(() {
      isLoding = true;
    });
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String postUid = Uuid().v4();
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('posts')
        .child('post_$postUid.jpg');
    StorageUploadTask uploadTask = await storageReference.putFile(image);
    await uploadTask.onComplete;
    String fileUrl = await storageReference.getDownloadURL();
    print('File Uploaded');

    DateTime datetime = DateTime.now();

    print(datetime.toString());

    Post post = Post(
        caption: captionController.text,
        postId: postUid,
        ownerId: user.uid,
        photoUrl: fileUrl,
        ownerName: user.name,
        ownerImgUrl: user.url,
        date: DateFormat.yMMMMd("en_US").format(datetime),
        time: DateFormat.jm().format(datetime),
        likes: {user.uid: false}
        // date: DateFormat.(time))
        );
    await portalRef
        .document(user.uid)
        .collection('userPosts')
        .document(postUid)
        .setData(
          post.fromUser(),
        );

    //return storageReference.getDownloadURL();
  }

  // Future uploadURL(imageUrl) async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  // }
}
