import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

CollectionReference ref = Firestore.instance.collection("portal");

class ImageCapture extends StatefulWidget {
  static final String route = "/cropImage";

  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  bool isOpen = false;
  bool isLoding = false;
  String url;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        cropStyle: CropStyle.rectangle,
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
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
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
    File selected = await ImagePicker.pickImage(source: source);

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
          title: Text("Upload Profile"),
          centerTitle: true,
        ),
        body: _imageFile != null
            ? Column(
                children: <Widget>[
                  LinearProgressIndicator(),
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
              )
            : null,
        floatingActionButton: _imageFile == null
            ? SpeedDial(
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
                      label: 'Add Question',
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
                      label: 'Start Quiz',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 16.0),
                      labelBackgroundColor: Theme.of(context).accentColor)
                ],
              )
            : FloatingActionButton.extended(
                label: Text('Save'),
                icon: Icon(Icons.save),
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                tooltip: 'Save',
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
                    }));
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
