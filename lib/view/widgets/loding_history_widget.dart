import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingHistoryCard extends StatelessWidget {
  const LoadingHistoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:10.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade200,
        enabled: true,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 5 ),
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )), Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )),

                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
                        child: Container(
                          height: 10,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey.shade100,thickness: 0.5,),

          ],
        ),
      ),
    );
  }
}