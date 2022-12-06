import 'dart:convert';
import 'package:doro/pages/buyService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var URL_API = 'doro.kz';

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
  var url = Uri.https(URL_API, '/api/training/getTrainigsScheduleCustomer.php');
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
  var url = Uri.https(URL_API, '/api/training/getTrainingsForDay.php');
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




// {"service_id":"3","name":"123","description":"1234","area_id":"1","provider_id":"2","worker_id":"1","service_timestamp":"2022-11-24 16:09:42","category_id":"3","provider_fee":"0","isDeleted":"0","price":"12","validity":"1","amount_of_customers":"13","type":"sell_service"}