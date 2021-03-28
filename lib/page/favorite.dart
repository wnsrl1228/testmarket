import 'package:flutter/material.dart';
import 'package:flutter_basic_1/repository/contents_repository.dart';
import 'package:flutter_basic_1/utils/data_utils.dart';
import 'package:flutter_svg/svg.dart';

import 'detail.dart';

class MyFavoriteContents extends StatefulWidget {
  @override
  _MyFavoriteContentsState createState() => _MyFavoriteContentsState();
}

class _MyFavoriteContentsState extends State<MyFavoriteContents> {
  ContentsRepository contentsRepository;
  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }

  Widget _appbarWidget() {
    return AppBar(
      title: Text(
        "관심목록",
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadMyFavoriteContentList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text("데이터 오류"),
          );
        }
        if (snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }

        return Center(
          child: Text("해당 지역에 데이터가 없습니다."),
        );
      },
    );
  }

  _makeDataList(List<dynamic> datas) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailContentView(
                data: datas[index],
              );
            }));
            print(datas[index]["title"]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index]["cid"],
                      child: Image.asset(
                        datas[index]["image"],
                        width: 100,
                        height: 100,
                      ),
                    )),
                Expanded(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          datas[index]["title"],
                          style: TextStyle(fontSize: 15),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          datas[index]["location"],
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withOpacity(0.3)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          DataUtils.calcStringToMon(datas[index]["price"]),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/heart_off.svg",
                                  width: 13,
                                  height: 13,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(datas[index]["likes"]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: datas.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1, color: Colors.black.withOpacity(0.4));
      },
    );
  }

  Future<List<dynamic>> _loadMyFavoriteContentList() async {
    return await contentsRepository.loadFavoriteContents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
