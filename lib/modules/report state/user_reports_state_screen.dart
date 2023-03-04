import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:masr_a7la/models/user_model.dart';
import 'package:masr_a7la/models/problem_model.dart';
import 'open image/open_image.dart';

class UserReportsStateScreen extends StatelessWidget {
  const UserReportsStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: FutureBuilder<List<MAProblemModel>>(
        future: (FirebaseFirestore.instance
                .collection('problems')
                .where('user_id', isEqualTo: fb!.uid)
                .get())
            .then((value) => value.docs.map((doc) {
                  return MAProblemModel.fromJSON(doc.data());
                }).toList()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint('Loading');
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'لا يوجد تقارير',
                style: GoogleFonts.almarai(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          }
          if (snapshot.data!.isEmpty) {
            return Container(
              color: Colors.white,
              child: Center(
                  child: Text(
                'لا يوجد تقارير',
                style: GoogleFonts.almarai(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              )),
            );
          } else {
            if (snapshot.hasData) {
              // final problemModel2 = MAProblemModel.fromJSON(
              //     snapshot.data!.docs as Map, snapshot.data!.dat as String);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  // final problemModel = MAProblemModel.fromJSON(
                  //     snapshot.data!.data()[index] as Map,
                  //    );
                  final mp = snapshot.data![index];

                  return FutureBuilder(
                    future: (FirebaseFirestore.instance
                        .collection('users')
                        .doc(mp.uID)
                        .get()),
                    builder: (context, fusnap) {
                      if (fusnap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!fusnap.hasData) {
                        return Center(
                          child: Text(
                            'لا يوجد تقارير',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      }
                      if (fusnap.hasData) {
                        final user =
                            MAUserModel.fromJSON(fusnap.data?.data() as Map);
                        return reportcard(index, mp, user, context);
                      } else {
                        return Center(
                          child: Text(
                            'لا يوجد تقارير',
                            style: GoogleFonts.almarai(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget reportcard(int index, MAProblemModel problemModel,
      MAUserModel userModel, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 2, top: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.teal,
            width: 2.0,
          ),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 15), blurRadius: 25, color: Colors.black12),
          ],
        ),
        //width: 420,
        height: 230,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.teal,
                              radius: 20,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              userModel.fullName ?? 'no name',
                              //'${userData['full name']}',
                              // fullname!,

                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.end,
                              style: GoogleFonts.almarai(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 5,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      problemModel.title!,
                                      //'عنوان التقرير',
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      problemModel.disc!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      problemModel.locationDisc!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      problemModel.prTime!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.almarai(
                                        fontSize: 12,
                                        // color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text('الحاله : ',
                                            style: GoogleFonts.almarai()),
                                        Expanded(
                                          child: Text(
                                            'قيد المراجعه',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.almarai(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 120,
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                    //color: Colors.red,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OpenImageScreen(
                          imageUrl: problemModel,
                          index: index,
                        );
                      }));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        '${problemModel.imageUrl}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
