import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_basic_1/components/manor_temperature_widget.dart';

class DetailContentView extends StatefulWidget {
  Map<String, String> data;
  DetailContentView({Key key, this.data}) : super(key: key);
  @override
  _DetailContentViewState createState() => _DetailContentViewState();
}

class _DetailContentViewState extends State<DetailContentView> {
  Size size;
  List<Map<String, String>> imgList;
  int _current;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _current = 0;
    size = MediaQuery.of(context).size;
    imgList = [
      {"id": "0", "url": widget.data["image"]},
      {"id": "1", "url": widget.data["image"]},
      {"id": "2", "url": widget.data["image"]},
      {"id": "3", "url": widget.data["image"]},
      {"id": "4", "url": widget.data["image"]},
    ];
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent, //투명처리
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share, color: Colors.white),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: Colors.white),
        ),
      ],
    );
  }

  Widget _makeSliderImage() {
    return Container(
      child: Stack(
        children: [
          Hero(
            tag: widget.data["cid"],
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width, //정사각형만들기
                  initialPage: 0, //시작페이지
                  enableInfiniteScroll: false, //무한스크롤 제한
                  viewportFraction: 1, //화면에 어느정도 보이게하는지 (1이면 꽉참)
                  onPageChanged: (index, reason) {
                    //페이지 바뀔때마다 일어나는
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imgList.map((map) {
                //스크롤 이미지 설정
                return Image.asset(
                  map["url"],
                  width: size.width,
                  fit: BoxFit.fill,
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              // indicator 부분
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((map) {
                return Container(
                  width: 9.0,
                  height: 9.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == int.parse(map["id"])
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     child: Image.asset("assets/images/user.png"),
          //   ),
          // )
          CircleAvatar(
            radius: 25,
            backgroundImage: Image.asset("assets/images/user.png").image,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "개발하는 길동",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "제주시 도남동",
              )
            ],
          ),
          Expanded(
            child: ManorTemperature(
              manorTemp: 37.5,
            ),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return Column(
      children: [_makeSliderImage(), _sellerSimpleInfo()],
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      width: size.width,
      height: 55,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
