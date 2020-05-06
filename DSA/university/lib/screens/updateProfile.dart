import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

CollectionReference ref = Firestore.instance.collection("portal");

class UpdateProfile extends StatefulWidget {
  UpdateProfile({this.title});
  final String title;
  static final String route = "/UpdateProfile";
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File _imageFile;
  bool isOpen = false;
  bool isLoding = false;
  String url;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        cropStyle: CropStyle.circle,
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
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(
        source: source, maxHeight: 675, maxWidth: 960);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text("Update Profile"),
          centerTitle: true,
        ),
        body: _imageFile != null
            ? _buildOnSelectImage()
            : Container(
                child: Center(
                    child: Text("Please Select a Photo",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey))),
              ),
        floatingActionButton: _imageFile == null
            ? _buildFloatingButtonOnNoImage()
            : _buildFloatingButtonOnImage());
  }

  Widget _buildFloatingButtonOnImage() {
    return FloatingActionButton.extended(
        label: Text('upload'),
        icon: Icon(Icons.save),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'set as a profile',
        onPressed: () async => {
              setState(() {
                isLoding = true;
              }),
              url = await uploadFile(_imageFile),
              await uploadURL(url),
              setState(() {
                isLoding = false;
              }),
              Navigator.pop(context, url),
            });
  }

  Widget _buildFloatingButtonOnNoImage() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      visible: true,
      onOpen: () {
        setState(() {
          isOpen = true;
        });
      },
      onClose: () {
        setState(() {
          isOpen = false;
        });
      },
      backgroundColor: Theme.of(context).primaryColor,
      curve: Curves.fastOutSlowIn,
      children: [
        // FAB 1

        SpeedDialChild(
            child: Icon(Icons.camera),
            backgroundColor: Theme.of(context).accentColor,
            onTap: () {
              _pickImage(ImageSource.camera);
            },
            label: 'Take photo',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Theme.of(context).accentColor),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.photo_library),
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
            backgroundColor: Theme.of(context).accentColor,
            label: 'select photo',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Theme.of(context).accentColor)
      ],
    );
  }

  Widget _buildOnSelectImage() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          isLoding == true
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(child: LinearProgressIndicator()),
                )
              : Container(),
          Center(
              child: Container(
            padding: EdgeInsets.all(30),
            child: Image.file(_imageFile),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Icon(Icons.crop),
                onPressed: _cropImage,
              ),
              FlatButton(
                color: Theme.of(context).accentColor,
                child: Icon(Icons.refresh),
                onPressed: _clear,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> uploadFile(image) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('ProfileImages').child(user.uid);
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    print('File Uploaded');
    return await storageReference.getDownloadURL();
  }

  Future uploadURL(imageUrl) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    await ref.document(user.uid).updateData({'url': imageUrl});
  }
}
