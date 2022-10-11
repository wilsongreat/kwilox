import 'package:brayon_news_network_app/app/services/services.dart';
import 'package:brayon_news_network_app/app/widgets/custom_Input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateNews extends StatefulWidget {
  const CreateNews({Key? key}) : super(key: key);

  @override
  State<CreateNews> createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<NewsServices>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF3D16D6),
        title: Text('Create News'),
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
                  data.createNews();
                },
                child: const Text("Create News")),
          ])),
    );
  }
}
