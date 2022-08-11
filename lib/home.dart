import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:render_object/high_comment.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> comments = <String>[];
  List<int?> showAll = List.generate(0, (index) => 3);
  double width70 = 0;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("assets/comments.txt").then((data) {
      comments = data.split("\n");
      showAll = List.generate(comments.length, (index) => 3);
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width70 = MediaQuery.of(context).size.width - 76;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (ctx, index) {
              bool shouldDrawBottomLine = index == ((comments.length / 5).round() * 5) ? false : (index % 5 != 4) && index != comments.length - 1;
              bool shouldDrawTopLine = index == 0 ? false : index % 5 != 1;
              return HighComment(
                shouldDrawBottomLine: shouldDrawBottomLine,
                shouldDrawTopLine: shouldDrawTopLine,
                isParentComment: index % 5 == 0,
                avatar: ClipRRect(
                  clipBehavior: Clip.none,
                  borderRadius: BorderRadius.circular(32),
                  child: CachedNetworkImage(
                    imageUrl: 'https://cdn-icons-png.flaticon.com/512/742/742750.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                actions: Container(
                  height: 32,
                  color: Colors.red,
                  child: Row(
                    children: [
                      Container(
                        child: Text('like'),
                      ),
                      SizedBox(width: 8),
                      Container(
                        child: Text('reply'),
                      ),
                    ],
                  ),
                ),
                comment: GestureDetector(
                  onTap: () {
                    setState(() {
                      showAll[index] = showAll[index] == null ? 3 : null;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 70,
                      minWidth: 140,
                    ),
                    decoration: BoxDecoration(color: Color(0xFFF5F6F7), borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      comments[index],
                      textScaleFactor: 1.6,
                      maxLines: showAll[index],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
