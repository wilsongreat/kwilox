import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kwilox/app/pages/add_product_page.dart';
import 'package:kwilox/utils/snackbar.dart';
import 'package:kwilox/widgets/drink_list_tile.dart';
import 'package:lottie/lottie.dart';

import 'app/Provider/providers.dart';
import 'models/drink_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<Drink>>(
            stream: ref.read(databaseProvider)!.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active &&
                  snapshot.data != null) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.network(
                            "https://assets2.lottiefiles.com/packages/lf20_v4d0iG.json", // here
                            width: 200,
                            repeat: true),
                        const Text("No Drinks  Available..."),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final drink = snapshot.data![index];
                      return DrinkListTile(
                          drink: drink,
                          onDelete: () async {
                            openIconSnackBar(
                              context,
                              "Deleting item...",
                              const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            );
                            await ref
                                .read(databaseProvider)!
                                .deleteProduct(drink.id!);
                          });
                      // return ListTile(
                      //   title: Text(drink.name),
                      //   subtitle: Text("Price: " + drink.price.toString()),
                      //   leading: drink.imageUrl != ""
                      //       ? Image.network(drink.imageUrl, height: 300)
                      //       : Container(),
                      //   trailing: IconButton(
                      //       icon: const Icon(Icons.delete),
                      //       onPressed: () => {
                      //             ref
                      //                 .read(databaseProvider)!
                      //                 .deleteProduct(drink.id!)
                      //           }),
                      // );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color(0xFF3D16D6),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddProductPage()));
        },
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }
}
