import 'package:avalinks/models/country/CountryData.dart';
import 'package:avalinks/models/country/CountryModel.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';

class CountryListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CountryListState();
  }
}

class CountryListState extends State<CountryListScreen> {
  List<CountryData> countryList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      getCountryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchController.text = '';
                      });
                    }),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
              ),
              maxLines: 1,
              onSubmitted: (value) {
                countryList = null;
                getCountryList(keyword: value);
              },
            ),
          ),
          Expanded(
            child: countryList == null
                ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
                : countryList.isEmpty
                ? NoDataScreen()
                : ListView.builder(
              itemBuilder: (context, index) {
                CountryData country = countryList[index];
                return ListTile(
                  title: Text(
                    country.country_name,
                    style: TextStyle(
                        fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(country);
                  },
                );
              },
              itemCount: countryList.length,
            ),
          ),
        ],
      ),
    );
  }

  Future getCountryList({String keyword}) async {
    var data = {'keyword': keyword};
    print('data : $data');
    HttpResponse httpResponse =
    await MyHttpClient(context).get(UrlUtils.GET_COUNTRY, data);
    if (httpResponse.success) {
      CountryModel model = CountryModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        setState(() {
          countryList = countryList ?? [];
          countryList.clear();
          countryList.addAll(model.data);
        });
      } else {
        Utils().showMessageDialog(context, "Error", model.message);
      }
    } else {
      Utils().showMessageDialog(context, "Error", httpResponse.error);
    }
  }
}
