import 'package:avalinks/models/service/category/ServiceCategory.dart';
import 'package:avalinks/models/service/category/ServiceCategoryListData.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/screen/ServiceCategoryItemView.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';

class ServiceCategoryListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceCategoryListState();
  }
}

class ServiceCategoryListState extends State<ServiceCategoryListScreen> {
  List<ServiceCategory> _serviceCategoryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      getServiceCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Category List'),
      ),
      body: _serviceCategoryList == null
          ? Container()
          : _serviceCategoryList.length == 0
              ? NoDataScreen()
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ServiceCategoryItemView(
                      _serviceCategoryList[index],
                      onItemSelected: (categoryItem) {
                        print(categoryItem.serviceCategoryName);
                        Navigator.of(context).pop(categoryItem);
                      },
                    );
                  },
                  itemCount: _serviceCategoryList.length,
                ),
    );
  }

  Future getServiceCategoryList() async {
    String userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    var data = {'user_id': userId};
    HttpResponse httpResponse =
        await MyHttpClient(context).get(UrlUtils.CATEGORY_LIST, data);
    if (httpResponse.success) {
      ServiceCategoryListData data =
          ServiceCategoryListData.fromJson(httpResponse.response);
      if (data != null &&
          data.status == 1 &&
          data.data != null &&
          data.data.length > 0) {
        setState(() {
          _serviceCategoryList = data.data;
        });
      } else {
        setState(() {
          _serviceCategoryList = [];
        });
      }
    } else {
      Utils()
          .showMessageDialog(context, 'Service Category', httpResponse.error);
    }
  }
}
