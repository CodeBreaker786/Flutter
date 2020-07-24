import 'package:avalinks/models/product/Product.dart';
import 'package:avalinks/models/product/ProductListData.dart';
import 'package:avalinks/screen/NoDataScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductListState();
  }
}

class ProductListState extends State<ProductListScreen> {
  String userId;
  int pageNo = 1;

  List<Product> productList = [];

  ScrollController scrollController = new ScrollController();
  bool hasNext = false;
  bool isLoading = false;

  bool nodata = false;

  @override
  void initState() {
    // TODO: implement initState
    scrollController.addListener(_scrollListener);
    super.initState();
    new Future.delayed(Duration.zero, () async {
      userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
      getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return nodata
        ? NoDataScreen()
        : ListView.builder(
            controller: scrollController,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              Product product = productList[index];
              return product == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("Loading"),
                        ),
                      ],
                    )
                  : Card(
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        child: Row(
                          children: <Widget>[
                            Utils().showImageWithImageLoader(
                              product.productImages[0].mediaPath,
                              height: 100,
                              width: 100,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      product.productName,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      '\$${product.productPrice}',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      product.productDetails,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(top: 5.0),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.green)),
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.green,
                                      onPressed: () async {
                                        if (await canLaunch(
                                            product.productAfflilatedLink)) {
                                          await launch(
                                              product.productAfflilatedLink);
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          );
  }

  _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter < 100 && hasNext && !isLoading) {
      pageNo++;
      getProductList();
    }
  }

  Future getProductList() async {
    isLoading = true;
    var data = {'user_id': userId, 'page': pageNo};
    HttpResponse httpResponse = await MyHttpClient(context).get(
        UrlUtils.AFFILIATE_PRODUCT_LIST, data,
        showProgress: pageNo == 1 ? true : false);
    if (httpResponse.success) {
      ProductListData productListData =
          ProductListData.fromJson(httpResponse.response);
      if (productListData != null &&
          productListData.status == 1 &&
          productListData.data != null &&
          productListData.data.length > 0) {
        if (productList != null &&
            productList.length > 0 &&
            productList[productList.length - 1] == null) {
          productList.removeLast();
        }
        hasNext = productListData.isLast == 1 ? false : true;
        productList.addAll(productListData.data);
        if (hasNext) {
          productList.add(null);
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
