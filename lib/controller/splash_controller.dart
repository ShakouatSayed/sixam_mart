import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../data/api/api_client.dart';
import '../util/html_type.dart';

class SplashController extends GetxController{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SplashController({required this.apiClient, required this.sharedPreferences});

  // Variables
  ConfigModel _configModel = ConfigModel();
  ModuleModel? _module;
  List<ModuleModel> _moduleList = [];
  bool _isLoading = false;
  bool _firstTimeConnectionCheck = true;
  String _htmlText;

  // Getters
  ConfigModel get configModel => _configModel;
  ModuleModel? get module => _module;
  List<ModuleModel> get moduleList => _moduleList;
  bool get isLoading => _isLoading;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  String? get htmlText => _htmlText;

  // Set loading state
  void setLoading(bool loading){
    _isLoading = loading;
    update();
  }

  // Initialize config data
  Future<bool> getConfigData() async{
    setLoading(true);
    try{
      Response response = await apiClient.getData(AppConstants.CONFIG_URI);
      if(response.statusCode == 200){
        _configModel = ConfigModel.fromJson(response.body);

        // Initialize module data
        await initSharedData();

        setLoading(false);
        return true;
      }else{
        setLoading(false);
        return false;
      }
    }catch(e){
      setLoading(false);
      return false;
    }
  }

  // Initialize shared data
  Future<ModuleModel?> initSharedData() async{
    if(!sharedPreferences.containsKey(AppConstants.THEME)){
      sharedPreferences.setBool(AppConstants.THEME, false);
    }

    if(!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)){
      sharedPreferences.setString(AppConstants.COUNTRY_CODE, AppConstants.languages[0].countryCode);
    }

    if(!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)){
      sharedPreferences.setString(AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode);
    }

    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)){
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }

    if(!sharedPreferences.containsKey(AppConstants.SEARCH_HISTORY)){
      sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
    }

    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION)){
      sharedPreferences.setBool(AppConstants.NOTIFICATION, true);
    }

    if(!sharedPreferences.containsKey(AppConstants.INTRO)){
      sharedPreferences.setBool(AppConstants.INTRO, true);
    }

    if(!sharedPreferences.containsKey(AppConstants.NOTIFICATION_COUNT)){
      sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, 0);
    }

    if(sharedPreferences.containsKey(AppConstants.MODULE_ID)){
      try{
        _module = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.MODULE_ID)!));
      }catch(e){
        if(kDebugMode){
          print("Error parsing module: $e");
        }
      }
    }
    return _module;
  }

  // Get modules
  Future<void> getModules() async{
    try{
      Response response = await apiClient.getData(AppConstants.MODULES_URI);
      if(response.statusCode == 200){
        _moduleList = [];
        response.body.forEach((module) => _moduleList.add(ModuleModel.fromJson(module)));
        update();
      }
    }catch(e){
      if(kDebugMode){
        print("Error getting modules: $e");
      }
    }
  }

  // Set module
  Future<void> setModule(ModuleModel module) async{
    _module = module;
    // Update API header
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN),
        null, // zodeIDs will updated when address is set
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
        module.id);

    // Save to shared preferences
    await sharedPreferences.setString(AppConstants.MODULE_ID, jsonEncode(module.toJson()));
    update();
  }

  // Remove module
  Future<void> removeModule() async {
    _module = null;
    await sharedPreferences.remove(AppConstants.MODULE_ID);
    update();
  }

  // Get module by type
  ModuleModel getModule(String? moduleType){
    if(_module != null) return _module!;
    if(moduleType != null && _moduleList.isNotEmpty){
      return _moduleList.firstWhere((module) =>
      module.moduleType == moduleType,
          orElse: () => ModuleModel.empty()
      );
    }
    return ModuleModel.empty();
  }

  // Email subscription
  Future<bool> subscribeMail(String email) async{
    try{
      Response response = await apiClient.postData(AppConstants.SUBSCRIPTION_URI, {"email" : email});
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  // Get HTML text
  Future<void> getHtmlText(HtmlType htmlType) async{
    try{
      //await Get.find<SplashController>().getHtmlText(HtmlType.TERMS_AND_CONDITION);
      //String title = Htmltype..
      String uri = htmlType.apiEndpoint;
      Response response = await apiClient.getData(uri);
      if(response.statusCode == 200){
        if(response.body is Map<String, dynamic>){
          _htmlText = response.body["content"] ?? response.body["data"] ?? response.body.toString();
        }else if(response.body is String){
          _htmlText = response.body;
        }else{
          _htmlText = response.body.toString();
        }
      }else{
        _htmlText = "Failed to load content. Please try again.";
      }
      update();
    }catch(e){
      if(kDebugMode){
        print("Error getting HTML text for $htmlType: $e");
      }
      _htmlText = "Error loading content. Place check your connection.";
      update();
    }
  }

  // Check intro should be shown
  bool showntro(){
    return sharedPreferences.getBool(AppConstants.INTRO) ?? true;
  }

  // Disable intro
  void disableIntro(){
    sharedPreferences.setBool(AppConstants.INTRO, false);
  }

  // Set first time connection check
void setFirstTimeConnectionCheck(bool isChecked){
    _firstTimeConnectionCheck = isChecked;
}

// Get user address
String? getUseAddress(){
    return sharedPreferences.getString(AppConstants.USER_ADDRESS);
}

// Check if app need update
bool get isUpdateRequired{
    if(GetPlatform.isAndroid){
      return AppConstants.APP_VERSION < (_configModel.appMinimumVersionAndriod ?? 0);
    }else if(GetPlatform.isIOS){
      return AppConstants.APP_VERSION < (_configModel.appMinimumVersionIos ?? 0);
    }
    return false;
}

// Check if app is in maintenance mode
 bool get isMaintenanceMode{
    return _configModel.maintenanceMode ?? false;
 }

 @override
  void onInit(){
    super.onInit();

    // Initialize config when controller is created
   getGonfigData();
 }

}

