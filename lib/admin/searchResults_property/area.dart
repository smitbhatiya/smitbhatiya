import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Area_Search extends StatefulWidget {
  const Area_Search({Key key}) : super(key: key);

  @override
  _Area_SearchState createState() => _Area_SearchState();
}

class _Area_SearchState extends State<Area_Search> {

  List areaListResult = [];

  final Query query2 = FirebaseFirestore.instance
      .collection("Property Details")
      .where("landmark", isEqualTo: "Varachha");

  Future getAreaWithSearch() async {
    List areaList = [];
    try {
      await query2.getDocuments().then((querySnapshot) => {
        querySnapshot.documents.forEach((element) {
          areaList.add(element.data());
        })
      });
      return areaList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchAreaList() async {
    dynamic areaResult = await getAreaWithSearch();

    if(areaResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        areaListResult = areaResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAreaList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: areaListResult.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)
                          )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)
                        ),
                        child: Image.network(
                          areaListResult[index]['firstImage'],
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 13),
                        height: 30,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          areaListResult[index]['project name'],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 13),
                        alignment: Alignment.topRight,
                        height: 30,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          areaListResult[index]['price'],
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 13),
                  child: RichText(
                    text: TextSpan(
                        text: "Posted by : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          TextSpan(
                              text: areaListResult[index]['posted by'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400
                              )
                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 13),
                  child: RichText(
                    text: TextSpan(
                        text: "Location : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          TextSpan(
                            text: areaListResult[index]['city'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 13),
                  child: RichText(
                    text: TextSpan(
                        text: "Type : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          TextSpan(
                            text: areaListResult[index]['category'],
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 13),
                  child: RichText(
                    text: TextSpan(
                        text: "Status : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          TextSpan(
                              text: areaListResult[index]['status'],
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400
                              )
                          )
                        ]
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
