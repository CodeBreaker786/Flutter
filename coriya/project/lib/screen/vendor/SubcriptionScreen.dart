import 'package:avalinks/models/subscription/MembershipPlanData.dart';
import 'package:avalinks/models/subscription/MembershipPlanListModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/screen/vendor/PaymentScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubscriptionState();
  }
}

class SubscriptionState extends State<SubscriptionScreen> {
  String userId;
  String userRoleId;

  List<MembershipPlanData> membershipPlanDataList = new List();

  bool nodata = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Future.delayed(Duration.zero, () {
      getSubscriptionPlans();
    });
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
      ),
      body: nodata
          ? NoDataScreen()
          : ListView.builder(
              itemCount: membershipPlanDataList.length,
              itemBuilder: (context, index) {
                return subscriptionPlanBuilder(context, index);
              },
            ),
    );
  }

  Widget subscriptionPlanBuilder(context, index) {
    MembershipPlanData data = membershipPlanDataList[index];
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.price_table_title,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Duration : ',
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                    ),
                    Flexible(
                      child: Text(
                        '${data.offer_duration} ${data.offer_type}',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Cost : ',
                      style: TextStyle(fontSize: 14.0, color: Colors.black87),
                    ),
                    Flexible(
                      child: Text(
                        data.price_table_cost,
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () async {
        bool needToUpdate = await Navigator.push(context,
            MaterialPageRoute(builder: (context) => PaymentScreen(data)));
      },
    );
  }

  initData() async {
    userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    userRoleId = await PrefsUtils.getStringPreference(AppConstant.USER_ROLE_ID);
  }

  getSubscriptionPlans() async {
    var data = {'user_id': userId, 'user_role_id': userRoleId};
    HttpResponse httpResponse =
        await MyHttpClient(context).get(UrlUtils.MEMBERSHIP_PLANS, data);
    if (httpResponse.success) {
      MembershipPlanListModel membershipPlanListModel =
          MembershipPlanListModel.fromJsonMap(httpResponse.response);
      if (membershipPlanListModel != null &&
          membershipPlanListModel.status == 1 &&
          membershipPlanListModel.data != null &&
          membershipPlanListModel.data.length > 0) {
        membershipPlanDataList.addAll(membershipPlanListModel.data);
        setState(() {
          nodata = false;
        });
      } else {
        setState(() {
          nodata = true;
        });
      }
    } else {
      Utils().showMessageDialog(context, 'Blogs', httpResponse.error);
    }
  }
}
