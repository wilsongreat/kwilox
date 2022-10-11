import 'package:brayon_news_network_app/app/models/news_model/NewsModel.dart';
import 'package:brayon_news_network_app/app/services/services.dart';
import 'package:brayon_news_network_app/app/widgets/custom_Input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNews extends StatefulWidget {
  final Data newsModel;
  const EditNews({Key? key, required this.newsModel}) : super(key: key);

  @override
  State<EditNews> createState() => _EditNewsState();
}

class _EditNewsState extends State<EditNews> {
  @override
  void initState() {
    NewsServices().updateTitleTextEditingController.text =
        '${widget.newsModel.title}';
    NewsServices().descriptionTextEditingController.text =
        '${widget.newsModel.bodyOfNews}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<NewsServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D16D6),
        title: Text('Edit News'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            CustomInputFieldFb1(
              inputController: data.titleTextEditingController,
              labelText: 'Title',
              hintText: 'Title',
            ),
            const SizedBox(height: 15),
            CustomInputFieldFb1(
              height: 100.0,
              inputController: data.descriptionTextEditingController,
              labelText: 'Description',
              hintText: 'Description',
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  data.updateNews(widget.newsModel.sId.toString());
                },
                child: const Text("Update News")),
          ])),
    );
  }
}
