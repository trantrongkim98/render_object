import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:render_object/comment.dart';
import 'package:render_object/high_comment.dart';
import 'package:render_object/process_bar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Container(
    //     margin: EdgeInsets.only(top: 200),
    //     child: Comment(
    //       avatar: ClipRRect(
    //         borderRadius: BorderRadius.circular(32),
    //         child: Image.network(
    //           'https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.6435-9/142432028_1736925749810194_5366117611380784464_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=ZLPTusW5vRQAX_A3jCs&_nc_ht=scontent.fsgn4-1.fna&oh=a7933121abb56f940a850425ddb35c6f&oe=613E5386',
    //           width: 32,
    //           height: 32,
    //         ),
    //       ),
    //       shouldDrawBottomLine: true,
    //       shouldDrawTopLine: true,
    //       child: Container(
    //         constraints: BoxConstraints(
    //             maxWidth: MediaQuery.of(context).size.width - 76),
    //         decoration: BoxDecoration(
    //             color: Color(0xFFF5F6F7),
    //             borderRadius: BorderRadius.circular(10)),
    //         padding: EdgeInsets.all(16),
    //         child: Text('''Các vấn đề phát sinh, sad fas asd
    //             f asd
    //              fas
    //               f
    //               as
    //               fas
    //                fas thắc mắc trong quá trình diễn ra sự kiện, các bạn vui lòng inbox'''),
    //       ),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (ctx, index) {
              return HighComment(
                avatar: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    'https://scontent.fsgn4-1.fna.fbcdn.net/v/t1.6435-9/142432028_1736925749810194_5366117611380784464_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=ZLPTusW5vRQAX_A3jCs&_nc_ht=scontent.fsgn4-1.fna&oh=a7933121abb56f940a850425ddb35c6f&oe=613E5386',
                    width: 32,
                    height: 32,
                  ),
                ),
                // shouldDrawBottomLine: index == 19 ? false : true,
                // shouldDrawTopLine: index == 0 ? false : true,
                comment: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 76),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5F6F7),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(16),
                      child: Text('''Các vấn đề phát sinh, sad fas asd
              f asd
               fas
                    f
                    as 
                    fas
                     fas thắc mắc trong quá trình diễn ra sự kiện, các bạn vui lòng inbox'''),
                    ),
                    SizedBox(height: 46),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _item(String text) {
    return Row();
    return Container(
      constraints: BoxConstraints(maxWidth: 150),
      child: Text(text),
    );
  }
}
