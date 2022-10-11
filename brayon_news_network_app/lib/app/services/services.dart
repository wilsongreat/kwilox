import 'dart:convert';

import 'package:brayon_news_network_app/app/models/news_model/NewsModel.dart';
import 'package:brayon_news_network_app/app/models/search_news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewsServices extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _updateTitleTextEditingController =
      TextEditingController();
  final TextEditingController _updateDescriptionTextEditingController =
      TextEditingController();
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get firstNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  TextEditingController get registerEmailController => _registerEmailController;

  TextEditingController get registerPasswordController =>
      _registerPasswordController;

  TextEditingController get titleTextEditingController =>
      _titleTextEditingController;

  TextEditingController get descriptionTextEditingController =>
      _descriptionTextEditingController;

  TextEditingController get updateTitleTextEditingController =>
      _updateTitleTextEditingController;

  TextEditingController get updateDescriptionTextEditingController =>
      _updateDescriptionTextEditingController;
  TextEditingController get searchTextEditingController =>
      _searchTextEditingController;
  bool _isLoading = false;
  var token;
  var baseUrl = 'https://brayon.herokuapp.com/api/';
  var loginresponse;
  var registerResponse;

  Future<void> signUpUser() async {
    var url = Uri.parse('https://brayon.herokuapp.com/api/users/signup');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    var payload = {
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": registerEmailController.text,
      "password": registerPasswordController.text
    };
    try {
      registerResponse = await http.post(url,
          headers: requestHeaders, body: jsonEncode(payload));

      print('Response status: ${registerResponse.statusCode}');
      print('Response body: ${registerResponse.body}');
    } catch (e, s) {
      print(e);
      print(s);
    }
    notifyListeners();
  }

  Future<void> loginUser(context) async {
    var url = Uri.parse('https://brayon.herokuapp.com/api/users/login');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    var payload = {
      "password": _passwordController.text,
      "email": _emailController.text
    };
    notifyListeners();

    try {
      loginresponse = await http.post(url,
          headers: requestHeaders, body: jsonEncode(payload));
      if (loginresponse.statusCode == 202) {
        print('Response status: ${loginresponse.statusCode}');
        print('Response body: ${loginresponse.body}');
        var responseData = jsonDecode(loginresponse.body);
        final storage = await SharedPreferences.getInstance();
        storage.setString('token', responseData['access_token']);
        print(responseData);
        notifyListeners();
      }
      // storage.setString('email', emailTextController.text);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> updateNews(String id) async {
    var url = Uri.parse('https://brayon.herokuapp.com/api/news/update/:id$id');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    var payload = {
      "title": _updateTitleTextEditingController.text,
      "body_of_news": _updateDescriptionTextEditingController.text
    };
    notifyListeners();

    try {
      var response = await http.put(url,
          headers: requestHeaders, body: jsonEncode(payload));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      notifyListeners();
      var responseData = jsonDecode(response.body);
      token = responseData['access-token'];

      final storage = await SharedPreferences.getInstance();
      storage.setString('token', responseData['access-token']);
      // storage.setString('email', emailTextController.text);

      print(responseData);
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<NewsModel> getAllNews() async {
    var endPoint = 'news/all';
    var url = Uri.parse('https://brayon.herokuapp.com/api/news/all');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
    };
    try {
      var response = await http.get(url, headers: requestHeaders);
      print('Response status: ${response.statusCode}');

      var responseData = NewsModel.fromJson(jsonDecode(response.body));
      print(responseData);
      var data = jsonDecode(response.body);
      print(jsonDecode(response.body));
      // print(responseData.news![2].title);
      print(responseData.data);
      print(data['data'][0]['title']);
      return responseData;
    } catch (e, s) {
      throw Exception('Something went wrong:$e');
    }
  }

  Future<void> createNews() async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.parse('https://brayon.herokuapp.com/api/news/create');
    var payload = {
      "title": _titleTextEditingController.text,
      "body_of_news": _descriptionTextEditingController.text
    };
    notifyListeners();
    var response = await http.post(url,
        headers: requestHeaders, body: jsonEncode(payload));

    try {
      if (response.statusCode == 200) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        var responseData = jsonDecode(response.body);
        final storage = await SharedPreferences.getInstance();
        storage.setString('token', responseData['access_token']);
        print(responseData);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<SearchModel>> newsSearch(String query) async {
    final url =
        'https://brayon.herokuapp.com/api/news/title?title=${_searchTextEditingController.text}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var responseData = SearchModel.fromJson(jsonDecode(response.body));
      List<SearchModel> responseList = [responseData];
      return responseList;
    } else {
      throw Exception('not found');
    }
  }
}
