import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PostPage extends StatefulWidget {
  final UserModel user;

  const PostPage({Key? key, required this.user}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<PostModel> posts = [];
  UserModel? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    intData();
    setState(() {
      user = widget.user;
    });
  }

  intData() async {
    await context.read<UsersProvider>().getPost(widget.user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFDEE7E8),
          body: ListView(
            children: [
              Column(
                children: [
                  Container(
                      width: 100.w,
                      height: 372.0,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/image/logo.png"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          width: 1.0,
                          color: const Color(0xFF707070),
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                //006A74
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CircleAvatar(
                                      backgroundColor: Color(0xFF006A74),
                                      child: Icon(Icons.arrow_back_ios)),
                                ),
                              ))
                        ],
                      )),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 80.w,
                                    child: Text(
                                      user!.name!,
                                      style: const TextStyle(
                                        fontFamily: 'Segoe UI',
                                        fontSize: 29.0,
                                        color: Color(0xFF2A5F31),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    user!.email!,
                                    style: const TextStyle(
                                      fontFamily: 'Segoe UI',
                                      fontSize: 16.0,
                                      color: Color(0xFF7A7A7A),
                                    ),
                                  )
                                ],
                              ),
                              const CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/image/logo.png"))
                            ],
                          ),
                        ),
                        Wrap(
                          // crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 100.0,
                          // verticalDirection: VerticalDirection.up,
                          children: [
                            actions("Web", user!.website!),
                            actions("Company", user!.company!.name!),
                            actions("It live", user!.address!.city!),
                            actions("Phone", user!.phone!),
                            // actions(),
                          ],
                        )
                      ],
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(8),
                    child: const Text(
                      'Post',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: 29.0,
                        color: Color(0xFF2A5F31),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  FutureBuilder<List<PostModel>>(
                      future: context
                          .read<UsersProvider>()
                          .getPost(widget.user.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                PostModel element = snapshot.data![index];

                                return post(element.title!, element.body!);
                              });
                        } else {
                          return const CircularProgressIndicator();
                        }
                      })

                  // separador()
                ],
              ),
            ],
          )),
    );
  }

  Widget post(String title, String description) {
    return Container(
      width: 100.w,
      color: Colors.white,
      // height: 100,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(
        top: 8,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 13.0,
            color: Color(0xFF2A5F31),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'Segoe UI',
            fontSize: 13.0,
            color: Color(0xFF474747),
          ),
        )
      ]),
    );
  }

  Widget actions(String label, String value) {
    return Container(
      // margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
      margin: const EdgeInsets.only(
        top: 30,
      ),
      // width: 50.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 12.0,
              color: Color(0xFF2A5F31),
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: 35.w,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 15.0,
                color: Color(0xFF474747),
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
