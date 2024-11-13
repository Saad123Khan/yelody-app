import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GetxController;
import 'package:yelody_app/blocs/charts/getsongs%20_bychartid_bloc.dart';
import 'package:yelody_app/models/charts/chart_list_res.dart';
import 'package:yelody_app/res/app_url/network_strings.dart';
import 'package:yelody_app/services/network.dart';
import 'package:yelody_app/utils/app_dialogs.dart';
import 'package:yelody_app/utils/app_navigation.dart';
import 'package:yelody_app/view/bottom_navigation/YelodyHomeView/home_controller.dart';

import 'getchart _byid_bloc.dart';

class ChartsBloc {
  Response? _response;
  VoidCallback? _onSuccess, _onFailure;
  // OtpUserResponseModel? _loginResponse;
  String? deviceToken;

  void loadCharts({
    required BuildContext context,
    required VoidCallback setProgressBar,
  }) async {
    setProgressBar();

//! ============> If Api fails then stop the loader
    _onFailure = () {
      log("Genre CALL  FAILED");
      AppNavigation.navigatorPop(context);
    };
    //! ============> Call api
    await _getRequest(
      endPoint: NetworkStrings.chartEndpoint,
      context: context,
    );

    //! ============> Get the login response
    _onSuccess = () {
      log("Sucess CALL OF API");
      AppNavigation.navigatorPop(context);
      _chartsSuccess(context: context);
    };

    //! ============> Validate the response
    _validateResponse();
  }

  //! ============> Post Request
  Future<void> _getRequest(
      {required String endPoint, required BuildContext context}) async {
    _response = await Network().getRequest(
        endPoint: endPoint,
        // formData: null,
        context: context,
        onFailure: _onFailure,
        isHeaderRequire: false);
  }

  //! ============> Validate Response
  void _validateResponse() {
    if (_response != null) {
      Network().validateResponse(
        isToast: false,
        response: _response,
        onSuccess: _onSuccess,
        onFailure: _onFailure,
      );
    }
  }

  //! ============> Social Login Response
  void _chartsSuccess({required BuildContext context}) async {
    // try {
    print("Charts Loaded Loaded Successfully${_response!.data}");
    final dataModel = ChartsList.fromJson(_response?.data);

    print("SORTING +++++++");
    if (dataModel.data != null) {
      for (int i = 0; i < dataModel.data!.length; i++) {
        dataModel.data?[i].songs?.sort((a, b) => a.rank!.compareTo(b.rank!));
      }
    }

    GetxController.Get.find<HomeController>().charts.value = dataModel;
    GetxController.Get.find<HomeController>().selectedChartID.value =
        dataModel.data?[0].chartId ?? '';

    GetSongChartById().loadGetSongChartById(
      context: context,
      id: dataModel.data![0].chartId.toString(),
      setProgressBar: () {
        AppDialogs.progressAlertDialog(context: context);
      },
    );

    //
    // } catch (e) {
    // print(e.toString());
    // AppDialogs.showToast(message: NetworkStrings.SOMETHING_WENT_WRONG);
    // }
  }
}
