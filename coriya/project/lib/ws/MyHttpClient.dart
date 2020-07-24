import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'HttpResponse.dart';
import 'UrlUtils.dart';

class MyHttpClient {
  BuildContext context;
  ProgressDialog pr;

  MyHttpClient(this.context);

  Future<HttpResponse> get(String url, dynamic queryParameter,
      {bool showProgress = true, bool useBaseUrl = true}) async {
    if (showProgress) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: 'Please wait...');
      pr.show();
    }
    try {
      Response res = await getDio(useBaseUrl: useBaseUrl)
          .get(url, queryParameters: queryParameter);
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(true, res.data, "");
    } on DioError catch (e) {
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(false, "", e.message);
    }
  }

  Future<HttpResponse> post(String url, dynamic data,
      {bool showProgress = true, bool useBaseUrl = true}) async {
    if (showProgress) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: 'Please wait...');
      pr.show();
    }
    try {
      Response res = await getDio(useBaseUrl: useBaseUrl).post(url, data: data);
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(true, res.data, "");
    } on DioError catch (e) {
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(false, "", e.message);
    }
  }

  Future<HttpResponse> postFormData(String url, FormData data,
      {bool showProgress = true, bool useBaseUrl = true}) async {
    if (showProgress) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: 'Please wait...');
      pr.show();
    }
    try {
      Response res = await getDio(useBaseUrl: useBaseUrl).post(url, data: data);
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(true, res.data, "");
    } on DioError catch (e) {
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(false, "", e.message);
    }
  }

  Future<HttpResponse> delete(String url, dynamic data,
      {bool showProgress = true, bool useBaseUrl = true}) async {
    if (showProgress) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: 'Please wait...');
      pr.show();
    }
    try {
      Response res =
          await getDio(useBaseUrl: useBaseUrl).delete(url, data: data);
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(true, res.data, "");
    } on DioError catch (e) {
      if (showProgress && pr != null) {
        pr.hide();
      }
      return HttpResponse(false, "", e.message);
    }
  }

  Dio getDio({bool useBaseUrl = true}) {
    Dio dio = new Dio();
    if (useBaseUrl) {
      dio.options.baseUrl = UrlUtils.BASE_URL;
    }
    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    return dio;
  }
}
