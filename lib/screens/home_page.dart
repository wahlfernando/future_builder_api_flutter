import 'package:flutter/material.dart';
import 'package:future_builder_api_flutter/model/user_model.dart';
import 'package:future_builder_api_flutter/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('User Profile')),
      ),
      body: FutureBuilder<List<UserModel>>(
        future: ApiService().getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ...snapshot.data!.map((e) => ListTile(
                      title: Text(e.firstName),
                      subtitle: Text(e.lastName),
                      trailing: CircleAvatar(
                        backgroundImage: NetworkImage(e.avatar),
                      ),
                    ))
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
