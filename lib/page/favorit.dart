import 'package:carrot_market_flutter/repository/contents_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/data_utils.dart';
import 'detail.dart';

class MyFavoritContents extends StatefulWidget {
  const MyFavoritContents({super.key});

  @override
  State<MyFavoritContents> createState() => _MyFavoritContentsState();
}

class _MyFavoritContentsState extends State<MyFavoritContents> {
  late ContentsRepository contentsRepository;

  @override
  void initState() {
    super.initState();
    contentsRepository = ContentsRepository();
  }

  AppBar _appBarWidget() {
    return AppBar(
      title: const Text(
        "관심목록",
        style: TextStyle(fontSize: 15),
      ),
      elevation: 1,
    );
  }

  _makeDataList(List<dynamic> datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  Map<String, String> content = Map.from(datas[index]);
                  return DetailContentView(data: content);
                },
              ));
              print(datas[index]["title"]!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: datas[index]["cid"]!,
                      child: Image.asset(
                        datas[index]["image"]!,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            datas[index]["title"]!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 15),
                          ),
                          Text(datas[index]["location"]!,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 189, 188, 188))),
                          Text(DataUtils.calcStringToWon(
                              datas[index]["price"]!)),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/heart_off.svg",
                                    width: 13,
                                    height: 13,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(datas[index]["likes"]!)
                                ]),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
        separatorBuilder: ((context, index) {
          return Container(
            height: 1,
            color: Colors.black.withOpacity(0.4),
          );
        }),
        itemCount: datas.length);
  }

  Widget _bodyWidget() {
    return FutureBuilder(
      future: _loadMyFavoritContentList(),
      builder: (BuildContext context, dynamic snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("데이터 오류"));
        }

        if (snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }

        return const Center(
          child: Text("해당 지역에 데이터가 없습니다."),
        );
      },
    );
  }

  Future<List<dynamic>> _loadMyFavoritContentList() async {
    return await contentsRepository.loadFavoritContent() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }
}
