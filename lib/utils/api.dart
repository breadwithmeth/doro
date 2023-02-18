import 'dart:convert';
import 'package:doro/pages/buyService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var URL_API = 'new.doro.kz';

Future<bool> loginClient(String login, String password) async {
  var url = Uri.https(URL_API, '/api/customer/login.php');
  var response = await http.post(
    url,
    body: json.encode({'login': login, 'password': password}),
    headers: {"Content-Type": "application/json"},
  );
  var data = jsonDecode(response.body);
  print(response.statusCode);
  if (response.statusCode != 200) {
    return false;
  } else {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['key']);
    final token = prefs.getString('token') ?? 0;
    print(token);
    return true;
  }
}

Future<bool> loginClientQR(String qr) async {
  var url = Uri.https(URL_API, '/api/customer/login.php');
  var response = await http.post(
    url,
    body: json.encode({"qr_uuid": "$qr"}),
    headers: {"Content-Type": "application/json"},
  );
  print(response.body);
  var data = jsonDecode(response.body);
  if (response.statusCode != 200) {
    return false;
  } else {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data['key']);
    final token = prefs.getString('token') ?? 0;
    print(token);
    return true;
  }
}

Future<Map<String, dynamic>> sendQR(String qr) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/qr/sendQR.php');
  var response = await http.post(
    url,
    body: json.encode({"qr_uuid": "$qr"}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );

  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  print(data);
  return data;
}

Future<List> getNews() async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/news/getNews.php');
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );

  // List<dynamic> list = json.decode(response.body);
  List<dynamic> list = json.decode(utf8.decode(response.bodyBytes));

  return list;
}

Future<int> buyService(String service_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/buyService.php');
  var response = await http.post(
    url,
    body: json.encode({"service_id": service_id}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<int> buyRecipe(String recipe_id, String worker_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/recipe/buyRecipe.php');
  var response = await http.post(
    url,
    body: json.encode({"recipe_id": recipe_id, "worker_id": worker_id}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<Map<String, dynamic>> getCustomer() async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/customer/getCustomer.php');
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );

  // List<dynamic> list = json.decode(response.body);
  print(response.body);
  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return data;
}

Future<List?> getTrainings() async {
  List<dynamic>? list = [];
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/training/getTrainings.php');
  var response = await http.post(
    url,
    body: json.encode({
      'today': true,
    }),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );

  // List<dynamic> list = json.decode(response.body);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }

  return list;
}

Future<List?> getTrainigsScheduleCustomer() async {
  List<dynamic>? list = [];

  final prefs = await SharedPreferences.getInstance();
  var url =
      Uri.https(URL_API, '/api/service/getServiceScheduleForCustomer.php');
  var response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  return list;
}

Future<List?> getTrainigsForDay(String date) async {
  List<dynamic>? list = [];

  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/getServicesForDay.php');
  var response = await http.post(
    url,
    body: json.encode({
      'date': date,
    }),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  return list;
}

Future<List?> getServices() async {
  List<dynamic>? list = [];
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/getServices.php');
  var response = await http.post(
    url,
    body: json.encode({
      'today': true,
    }),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );

  // List<dynamic> list = json.decode(response.body);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  print(response.statusCode);
  return list;
}

Future<int> joinTraining(String training_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/training/joinTraining.php');
  var response = await http.post(
    url,
    body: json.encode({"training_id": training_id}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<int> enrollTraining(
    String schedule_id, String order_id, String type) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/enrollService.php');
  var response = await http.post(
    url,
    body: json.encode(
        {"schedule_id": schedule_id, "order_id": order_id, "type": type}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<int> cancelEnrollTraining(String schedule_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/cancelEnrollService.php');
  var response = await http.post(
    url,
    body: json.encode({"schedule_id": schedule_id}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<List?> getServiceCategories() async {
  List<dynamic>? list = [];

  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/getServiceCategories.php');
  var response = await http.post(
    url,
    body: json.encode({}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  return list;
}

Future<Map<String, dynamic>> getServiceByScheduleId(String schedule_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/service/getServiceByScheduleId.php');
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "AUTH": prefs.getString('token')!
      },
      body: json.encode({"schedule_id": schedule_id}));

  // List<dynamic> list = json.decode(response.body);
  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return data;
}

Future<Map<String, dynamic>> getShoppingCartDetails(String cart_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url =
      Uri.https(URL_API, '/api/shopping_cart/getShoppingCartCustomer.php');
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "AUTH": prefs.getString('token')!
      },
      body: json.encode({"cart_id": cart_id}));
  print(response.statusCode);

  // List<dynamic> list = json.decode(response.body);
  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return data;
}

Future<Map<String, dynamic>> getNewsById(String news_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/news/getNews.php');
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "AUTH": prefs.getString('token')!
      },
      body: json.encode({"news_id": news_id}));
  print(response.statusCode);

  // List<dynamic> list = json.decode(response.body);
  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return data;
}

Future<int> buyShoppingCart(String cart_id) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/shopping_cart/buyShoppingCart.php');
  var response = await http.post(
    url,
    body: json.encode({"cart_id": cart_id}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.statusCode);
  // print(response.body);
  return response.statusCode;
}

Future<List?> getShoppingCartsCustomer() async {
  List<dynamic>? list = [];

  final prefs = await SharedPreferences.getInstance();
  var url =
      Uri.https(URL_API, '/api/shopping_cart/getShoppingCartsCustomer.php');
  var response = await http.post(
    url,
    body: json.encode({}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.body);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  return list;
}

Future<List?> getSubscriptionsCustomer() async {
  List<dynamic>? list = [];

  final prefs = await SharedPreferences.getInstance();
  var url =
      Uri.https(URL_API, '/api/subscription/getSubscriptionsCustomer.php');
  var response = await http.post(
    url,
    body: json.encode({}),
    headers: {
      "Content-Type": "application/json",
      "AUTH": prefs.getString('token')!
    },
  );
  print(response.body);
  if (response.body.isNotEmpty) {
    list = json.decode(utf8.decode(response.bodyBytes));
  } else {
    list = null;
  }
  return list;
}

Future<Map<String, dynamic>> getPoll() async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/poll/getPollCustomer.php');
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "AUTH": prefs.getString('token')!
      },
      body: json.encode({}));
  print(response.statusCode);

  // List<dynamic> list = json.decode(response.body);
  Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return data;
}

Future<int> sendPollAnswers(List<String> answers) async {
  final prefs = await SharedPreferences.getInstance();
  var url = Uri.https(URL_API, '/api/poll/sendPollAnswers.php');
  var response = await http.post(url,
      headers: {
        "Content-Type": "application/json",
        "AUTH": prefs.getString('token')!
      },
      body: json.encode({"answers": answers}));
  print(response.statusCode);

  // List<dynamic> list = json.decode(response.body);
  // Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
  return response.statusCode;
}
// {"service_id":"3","name":"123","description":"1234","area_id":"1","provider_id":"2","worker_id":"1","service_timestamp":"2022-11-24 16:09:42","category_id":"3","provider_fee":"0","isDeleted":"0","price":"12","validity":"1","amount_of_customers":"13","type":"sell_service"}