import 'dart:io';

import 'package:avalinks/models/service/DeleteServiceMediaModel.dart';
import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServiceMedia.dart';
import 'package:avalinks/models/service/ServicesListModel.dart';
import 'package:avalinks/models/service/category/ServiceCategory.dart';
import 'package:avalinks/screen/vendor/ServiceCategoryListScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as Path;
import 'package:regexed_validator/regexed_validator.dart';

class ServiceAddUpdateScreen extends StatefulWidget {
  ServiceData serviceData;

  ServiceAddUpdateScreen({this.serviceData});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ServiceAddUpdateState();
  }
}

class ServiceAddUpdateState extends State<ServiceAddUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  String userId;

  TextEditingController businessNameController = new TextEditingController();
  ServiceCategory _serviceCategory;
  TextEditingController serviceCategoryController = new TextEditingController();
  TextEditingController servicePriceController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController websiteController = new TextEditingController();
  TextEditingController workingHourController = new TextEditingController();
  TextEditingController adderssController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  Map<String, String> selectedImages, selectedVideos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.serviceData == null ? 'Add Service' : 'Update Service'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: TextFormField(
                controller: businessNameController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Business Name'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Business Name';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: InkWell(
                child: IgnorePointer(
                  child: TextFormField(
                    controller: serviceCategoryController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(labelText: 'Service Category'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Service Category';
                      }
                      return null;
                    },
                  ),
                ),
                onTap: () async {
                  ServiceCategory serviceCategory = await Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ServiceCategoryListScreen()));
                  if (serviceCategory != null) {
                    setState(() {
                      _serviceCategory = serviceCategory;
                      serviceCategoryController.text =
                          _serviceCategory.serviceCategoryName;
                    });
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: servicePriceController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Service Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Service Price';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: emailController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Email';
                  } else if (!validator.email(value)) {
                    return 'Invalid Email Id';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: phoneController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Phone No'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Phone No';
                  } else if (!validator.phone(value)) {
                    return 'Invalid Phone No';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: websiteController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Website'),
                keyboardType: TextInputType.url,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: workingHourController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Working Hour'),
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Working Hour';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: adderssController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Address'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: TextFormField(
                controller: descriptionController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: null,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Description';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    selectedImages == null
                        ? 'Add Images'
                        : '${selectedImages.length} Image(s) Selected',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () async {
                    selectedImages =
                        await FilePicker.getMultiFilePath(type: FileType.image);
                    if (selectedImages != null && selectedImages.length > 0) {
                      setState(() {});
                    }
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    selectedVideos == null
                        ? 'Add Videos'
                        : '${selectedVideos.length} Video(s) Selected',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () async {
                    selectedVideos =
                        await FilePicker.getMultiFilePath(type: FileType.video);
                    if (selectedVideos != null && selectedVideos.length > 0) {
                      setState(() {});
                    }
                  }),
            ),
            widget.serviceData == null
                ? Padding(padding: EdgeInsets.all(0))
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Media',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        (widget.serviceData.media == null ||
                                widget.serviceData.media.length == 0)
                            ? Text('No Media')
                            : GridView.count(
                                crossAxisCount: 2,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: widget.serviceData.media
                                    .map((ServiceMedia media) {
                                  return GridTile(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1.0, color: Colors.black)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Utils().showImageWithImageLoader(
                                              media.media_path),
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                              title: Text(
                                                                  'Delete Service'),
                                                              content: Text(
                                                                  'Are you sure you want to delete this media?'),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Yes, Delete'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    deleteServiceMedia(
                                                                        widget
                                                                            .serviceData
                                                                            .service_id,
                                                                        media);
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                      'Cancel'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                )
                                                              ],
                                                            ));
                                                  }))
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                      ],
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: RaisedButton(
                  color: Colors.red,
                  child: Text(
                    widget.serviceData == null
                        ? 'Add Service'
                        : 'Update Service',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_serviceCategory == null) {
                        Utils().showMessageDialog(context, 'Service',
                            "Please select Service Category");
                      } else {
                        if (widget.serviceData == null) {
                          addService(
                              businessNameController.text,
                              serviceCategoryController.text,
                              servicePriceController.text,
                              emailController.text,
                              phoneController.text,
                              websiteController.text,
                              workingHourController.text,
                              adderssController.text,
                              descriptionController.text,
                              selectedImages,
                              selectedVideos);
                        } else {
                          updateService(
                              businessNameController.text,
                              serviceCategoryController.text,
                              servicePriceController.text,
                              emailController.text,
                              phoneController.text,
                              websiteController.text,
                              workingHourController.text,
                              adderssController.text,
                              descriptionController.text,
                              selectedImages,
                              selectedVideos);
                        }
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    if (widget.serviceData != null) {
      businessNameController.text = widget.serviceData.business_name;
      _serviceCategory = widget.serviceData.selected_category;
      serviceCategoryController.text =
          _serviceCategory == null ? '' : _serviceCategory.serviceCategoryName;
      servicePriceController.text = widget.serviceData.service_price;
      emailController.text = widget.serviceData.service_email;
      phoneController.text = widget.serviceData.service_phone;
      websiteController.text = widget.serviceData.service_website;
      workingHourController.text = widget.serviceData.service_working_hour;
      adderssController.text = widget.serviceData.service_address;
      descriptionController.text = widget.serviceData.service_description;
    }
  }

  addService(
      String businessName,
      String serviceName,
      String servicePrice,
      String email,
      String phoneNo,
      String website,
      String workingHour,
      String address,
      String desc,
      Map<String, String> images,
      Map<String, String> videos) async {
    List<UploadFileInfo> media = new List();
    if (images != null && images.values != null) {
      print(images.values.length);
      List<String> imagePathList = images.values.toList();
      for (int i = 0; i < imagePathList.length; i++) {
        File imageFile = File(imagePathList[i]);
        if (imageFile != null && imageFile.existsSync()) {
          media.add(UploadFileInfo(imageFile, Path.basename(imageFile.path)));
        }
      }
    }
    if (videos != null && videos.values != null) {
      List<String> videoPathList = videos.values.toList();
      for (int i = 0; i < videoPathList.length; i++) {
        File videoFile = File(videoPathList[i]);
        if (videoFile != null && videoFile.existsSync()) {
          media.add(UploadFileInfo(videoFile, Path.basename(videoFile.path)));
        }
      }
    }
    FormData formData;
    if (media != null && media.length > 0) {
      formData = new FormData.from({
        'user_id': userId,
        'business_name': businessName,
        'selected_category_id': _serviceCategory.serviceCategoryId,
        'service_price': servicePrice,
        'service_description': desc,
        'service_address': address,
        'service_email': email,
        'service_phone': phoneNo,
        'service_website': website,
        'service_working_hour': workingHour,
        'media[]': media
      });
    } else {
      formData = new FormData.from({
        'user_id': userId,
        'business_name': businessName,
        'selected_category_id': _serviceCategory.serviceCategoryId,
        'service_price': servicePrice,
        'service_description': desc,
        'service_address': address,
        'service_email': email,
        'service_phone': phoneNo,
        'service_website': website,
        'service_working_hour': workingHour
      });
    }
    HttpResponse httpResponse = await MyHttpClient(context)
        .postFormData(UrlUtils.ADD_SERVICE, formData);
    print(httpResponse);
    if (httpResponse.success) {
      ServicesListModel servicesListModel =
          ServicesListModel.fromJsonMap(httpResponse.response);
      if (servicesListModel.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Service'),
                  content: Text(servicesListModel.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ));
      } else {
        Utils()
            .showMessageDialog(context, 'Service', servicesListModel.message);
      }
    } else {
      Utils().showMessageDialog(context, 'Service', httpResponse.error);
    }
  }

  deleteServiceMedia(String serviceId, ServiceMedia media) async {
    var data = {'service_id': serviceId, 'media_id': media.media_id};
    print(data);
    HttpResponse httpResponse =
        await MyHttpClient(context).post(UrlUtils.DELETE_SERVICE_MEDIA, data);
    if (httpResponse.success) {
      DeleteServiceMediaModel model =
          DeleteServiceMediaModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Delete Service Media'),
                  content: Text(model.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          widget.serviceData.media.remove(media);
                        });
                      },
                    )
                  ],
                ));
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }

  updateService(
      String businessName,
      String serviceName,
      String servicePrice,
      String email,
      String phoneNo,
      String website,
      String workingHour,
      String address,
      String desc,
      Map<String, String> images,
      Map<String, String> videos) async {
    List<UploadFileInfo> media = new List();
    if (images != null && images.values != null) {
      print(images.values.length);
      List<String> imagePathList = images.values.toList();
      for (int i = 0; i < imagePathList.length; i++) {
        File imageFile = File(imagePathList[i]);
        if (imageFile != null && imageFile.existsSync()) {
          media.add(UploadFileInfo(imageFile, Path.basename(imageFile.path)));
        }
      }
    }
    if (videos != null && videos.values != null) {
      List<String> videoPathList = videos.values.toList();
      for (int i = 0; i < videoPathList.length; i++) {
        File videoFile = File(videoPathList[i]);
        if (videoFile != null && videoFile.existsSync()) {
          media.add(UploadFileInfo(videoFile, Path.basename(videoFile.path)));
        }
      }
    }
    FormData formData;
    if (media != null && media.length > 0) {
      formData = new FormData.from({
        'user_id': userId,
        'service_id': widget.serviceData.service_id,
        'business_name': businessName,
        'selected_category_id': _serviceCategory.serviceCategoryId,
        'service_price': servicePrice,
        'service_description': desc,
        'service_address': address,
        'service_email': email,
        'service_phone': phoneNo,
        'service_website': website,
        'service_working_hour': workingHour,
        'media[]': media
      });
    } else {
      formData = new FormData.from({
        'user_id': userId,
        'service_id': widget.serviceData.service_id,
        'business_name': businessName,
        'selected_category_id': _serviceCategory.serviceCategoryId,
        'service_price': servicePrice,
        'service_description': desc,
        'service_address': address,
        'service_email': email,
        'service_phone': phoneNo,
        'service_website': website,
        'service_working_hour': workingHour
      });
    }
    HttpResponse httpResponse = await MyHttpClient(context)
        .postFormData(UrlUtils.EDIT_SERVICE, formData);
    print(httpResponse);
    if (httpResponse.success) {
      print(httpResponse.response.toString());
      ServicesListModel servicesListModel =
          ServicesListModel.fromJsonMap(httpResponse.response);
      if (servicesListModel.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Service'),
                  content: Text(servicesListModel.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(
                            context,
                            (servicesListModel.data != null &&
                                    servicesListModel.data.length > 0)
                                ? servicesListModel.data[0]
                                : null);
                      },
                    )
                  ],
                ));
      } else {
        Utils()
            .showMessageDialog(context, 'Service', servicesListModel.message);
      }
    } else {
      Utils().showMessageDialog(context, 'Service', httpResponse.error);
    }
  }
}
