import 'package:avalinks/list_items/ServiceItemView.dart';
import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServicesListModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/screen/vendor/ServiceAddUpdateScreen.dart';
import 'package:avalinks/screen/vendor/ServiceDetailsScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ServiceListState();
  }
}

class ServiceListState extends State<ServiceListScreen> {
  String userId;
  int pageNo = 1;

  List<ServiceData> serviceDataList = new List();

  ScrollController scrollController = new ScrollController();
  bool hasNext = false;
  bool isLoading = false;

  bool nodata = false;

  @override
  void initState() {
    // TODO: implement initState
    initData();
    scrollController.addListener(_scrollListener);
    super.initState();
    new Future.delayed(Duration.zero, () {
      getServiceList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              bool needToUpdate = await Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ServiceAddUpdateScreen()));
              if (needToUpdate) {
                pageNo = 1;
                hasNext = false;
                isLoading = false;
                serviceDataList.clear();
                getServiceList();
              }
            },
          ),
        ],
      ),
      body: nodata
          ? NoDataScreen()
          : ListView.builder(
              controller: scrollController,
              itemCount: serviceDataList.length,
              itemBuilder: (context, index) {
                return serviceItemBuilder(context, index);
              },
            ),
    );
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 100 && hasNext && !isLoading) {
      pageNo++;
      getServiceList();
    }
  }

  Widget serviceItemBuilder(context, index) {
    ServiceData data = serviceDataList[index];
    return GestureDetector(
      child: ServiceItemView(data),
      onTap: () async {
        bool needToUpdate = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ServiceDetailsScreen(serviceDataList[index])));
        if (needToUpdate) {
          pageNo = 1;
          hasNext = false;
          isLoading = false;
          serviceDataList.clear();
          getServiceList();
        }
      },
    );
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
  }

  getServiceList() async {
    isLoading = true;
    var data = {'user_id': userId, 'page': pageNo};
    HttpResponse httpResponse = await MyHttpClient(context).get(
        UrlUtils.SERVICE_LIST, data,
        showProgress: pageNo == 1 ? true : false);
    if (httpResponse.success) {
      ServicesListModel servicesListModel =
          ServicesListModel.fromJsonMap(httpResponse.response);
      if (servicesListModel != null &&
          servicesListModel.status == 1 &&
          servicesListModel.data != null &&
          servicesListModel.data.length > 0) {
        if (serviceDataList != null &&
            serviceDataList.length > 0 &&
            serviceDataList[serviceDataList.length - 1] == null) {
          serviceDataList.removeLast();
        }
        hasNext = servicesListModel.is_last == 1 ? false : true;
        serviceDataList.addAll(servicesListModel.data);
        if (hasNext) {
          serviceDataList.add(null);
        }
        setState(() {
          nodata = false;
        });
      } else {
        setState(() {
          nodata = true;
        });
      }
    } else {
      Utils().showMessageDialog(context, 'Service', httpResponse.error);
    }
    isLoading = false;
  }
}
