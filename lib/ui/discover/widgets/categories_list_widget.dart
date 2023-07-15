import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("categories").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  print("categories ${snapshot.data!.docs[index].data()["name"]}");
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(Get.width * 0.04),
                      child: Container(
                        width: Get.width / 8,
                        height: Get.width / 8,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.width * 0.04)),
                        child: Image.network(
                          snapshot.data!.docs[index].data()["imageUrl"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        snapshot.data!.docs[index].data()["name"],
                        maxLines: 2,
                        style: const TextStyle(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
