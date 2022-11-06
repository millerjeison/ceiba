import 'package:flutter/material.dart';

Widget textDescription(IconData icon, String text) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.all(4),
        child: Icon(
          icon,
          color: const Color(0xFF014A51),
          size: 15,
        ),
      ),
      Text(
        '$text',
        style: const TextStyle(
          fontFamily: 'Segoe UI',
          fontSize: 16.0,
          color: Color(0xFF7A7A7A),
        ),
      ),
    ],
  );
}

Widget target(
    {required String? name,
    required String? phone,
    required String? email,
    required Function()? onclic}) {
  return GestureDetector(
    onTap: onclic,
    child: Container(
        width: 354.0,
        height: 140.0,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: const Offset(0, 3.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  width: 71.0,
                  height: 70.0,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(35.5, 35.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/image/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$name',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 20.0,
                          color: Color(0xFF2A5F31),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      textDescription(Icons.phone, phone!),
                      textDescription(Icons.email, email!)
                    ],
                  ),
                )
              ],
            ),
            const Text(
              'Ver publicaciones',
              style: TextStyle(
                fontFamily: 'Segoe UI',
                fontSize: 13.0,
                color: Color(0xFF2A5F31),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )),
  );
}
