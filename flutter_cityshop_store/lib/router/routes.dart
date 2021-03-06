import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes{
   
  // 路由管理
  static FluroRouter router;

  static String root='/';
  static String webView = '/webView'; // 网页加载 
  static String search= '/search'; 
  static String cityList= '/cityList'; 
  static String searchCity= '/searchCity'; 
  static String animation= '/animation';
  static String details = '/details';

  static void configureRoutes(FluroRouter router){
    router.notFoundHandler= Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> params){
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
        return;
      }
    );

    
    router.define(root,    handler:rootRouteHandler);
    router.define(webView, handler: webViewHandler);
    router.define(search,  handler: searchPagesHandler);
    router.define(cityList,handler:cityListPagesHandler);
    router.define(searchCity,handler:searchCityHandler);
    router.define(details, handler:detailsHandler);
 
  }


  // cupertino, push效果
  // cupertinoFullScreenDialog, prentViewConter
  /*
   *   native,
  nativeModal,
  inFromLeft,
  inFromRight,
  inFromBottom,
  fadeIn,
  custom, // if using custom then you must also provide a transition
  material,
  materialFullScreenDialog,
  cupertino,
  cupertinoFullScreenDialog,  
   */

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配R
  static Future navigateTo(BuildContext context, String path, 
                          {Map<String, dynamic> params, 
                          TransitionType transition = TransitionType.cupertino}) {

       
                     
    String query =  "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    // print('我是navigateTo传递的参数：$query');
    path = path + query;
    return router.navigateTo(context, path, transition:transition);
  }




}
