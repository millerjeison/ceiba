import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/providers/users_provider.dart';
import 'package:ceiba/views/pages/post_page/post_page.dart';
import 'package:ceiba/views/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _filter = TextEditingController();

  List<UserModel> usersList = [];

  String _searchText = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          usersList = context.read<UsersProvider>().users;
        });
      } else {
        _searchText = _filter.text;
        // setState(() { });
        _buscar();
      }
    });
    setState(() {
      usersList = context.read<UsersProvider>().users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFF6F6F6),
            // appBar: AppBar(
            //   title: const Text('Lista de usuarios'),
            // ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 26),
                    child: const Text(
                      'Prueba de ingreso \nCeiba',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 33.0,
                        color: const Color(0xFF484848),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    // margin: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/image/logo.png")),
                        Container(
                          width: 70.w,
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color(0xFF014A51).withOpacity(0.26),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: TextFormField(
                              controller: _filter,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(Icons.search),
                                  hintText: 'Search user',
                                  iconColor: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                    height: 70.h,
                    // color: Colors.red,
                    child: usersList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: usersList.length,
                            itemBuilder: (context, index) {
                              UserModel element = usersList[index];
                              return target(
                                  name: element.name,
                                  phone: element.phone,
                                  email: element.email,
                                  onclic: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PostPage(
                                            user: element,
                                          ),
                                        ));
                                  });
                            })
                        : const Center(
                            child: Text(
                            'List is empty',
                            style: TextStyle(fontSize: 17),
                          )),
                  ),
                ],
              ),
            )));
  }

  _buscar() {
    if (_searchText.isNotEmpty) {
      List<UserModel> tempList = [];

      for (var i in context.read<UsersProvider>().users) {
        if (i.name!.toLowerCase().contains(_searchText.toLowerCase())) {
          tempList.add(i);
        }
      }
      usersList = tempList;
      setState(() {});
    }
  }
}
