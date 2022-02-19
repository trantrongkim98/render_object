import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:render_object/comment.dart';
import 'package:render_object/high_comment.dart';
import 'package:render_object/process_bar.dart';

final comments = <String>[
  'Nhìn nhảm ghê á trời',
  'Ủa không xem thôi mắc gì bảo nhảm',
  'ủa chứ xem xong, không thích không được comment à, lạ đời',
  'Mấy ông học văn bảo: "Anh với em như hyperbole và đường tiệm cận/ Mãi gần nhau nhưng chẳng gặp nhau". Thời gian sau này có ông thêm vào: "Chỉ sợ nay mai em lỡ có bầu/ Anh không muốn cũng thôi làm đường conic".',
  '''Thật ra khi bạn học đến phần tiệm cận và hàm phân thức bậc nhất trên bậc nhất đặt câu hỏi này là bình thường, và ý hỏi của bạn ý sâu xa hơn. Mình từng có hs hỏi câu này rồi.
Cái này một phần là do chương trình học chỉ trình bày gói gọn một số hàm và đồ thị của nó, nên học sinh khó hình dung và mở rộng tư duy ra các hàm khác được. Lại thêm thi tno có mấy trò học mẹo nữa, nên lại càng khó hiểu bản chất.
Ý hỏi của bạn ấy theo mình đoán là thế này, ví dụ như hàm y=1/x nhận tcn là đt x=0 thì lúc đó khi x dần đến vô cùng ta có coi là đths cắt được đt x=0 hay ko? Thì câu trả lời là không.
Giới hạn ( lim ) trong định nghĩa tiệm cận ngang của hàm phân thức đã thể hiện rõ việc đths y=1/x chỉ tiến đến đt x=0 thôi chứ mãi mãi không thể chạm vào. Vì hiển nhiên kể cả khi x là rất lớn => 1/x là rất nhỏ, nhưng ta vẫn có thể lấy ra số 1/(x+1) là nhỏ hơn … Như vậy giữa đồ thị hàm số và tiện cận luôn có khoảng cách và mãi mãi không thể chạm vào ( hay cắt nhau )
Giống như mình và cush vậy :(( đi mãi chỉ có thể làm bạn :((''',
  'Sự cắt nhau không liên quan gì đến khái niệm tiệm cận nên chúng(tiệm cận và đths) có thể cắt nhau.',
  'Vẫn cắt tốt',
  'trưa mai có đá với Arsenal trên con đường chinh phục cúp C1 ko anh',
  'có lắc',
  'Nhớ west brom nhớ arsenal :((',
  'Các vấn đề phát sinh, thắc mắc trong quá trình diễn ra sự kiện, các bạn vui lòng inbox',
  'Nếu ngày mai bạn được lên công ty đi làm lại, bạn sẽ mặc gì nhỉ?',
  'Để đảm bảo mục đích của thử thách, hình ảnh hoặc video clip phải có cùng 1 background nha',
  'Các vấn đề phát sinh, thắc mắc trong quá trình diễn ra sự kiện, các bạn vui lòng inbox',
  'Để đảm bảo mục đích của thử thách, hình ảnh hoặc video clip phải có cùng 1 background nha',
  'Để đảm bảo mục đích của thử thách',
  '''Italia dẫn đầu giải về chỉ số… phạm lỗi

Với tổng cộng 93 lần bị thổi phạt vì phạm lỗi, Italia chính là đội tuyển phạm nhiều lỗi nhất tại EURO 2020. 

Chưa hết, tập thể Italia đã 100 lần bị đối thủ phạm lỗi và cũng trở thành đội tuyển bị phạm lỗi nhiều nhất giải. 

2 chỉ số này của ĐT Anh là 71 và 88. '''
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int?> showAlls = List.generate(comments.length, (index) => 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView.builder(
            itemCount: comments.length,
            itemBuilder: (ctx, index) {
              bool shouldDrawBottomLine =
                  index == ((comments.length / 5).round() * 5)
                      ? false
                      : (index % 5 != 4) && index != comments.length - 1;
              bool shouldDrawTopLine = index == 0 ? false : index % 5 != 1;
              return HighComment(
                shouldDrawBottomLine: shouldDrawBottomLine,
                shouldDrawTopLine: shouldDrawTopLine,
                isParentComment: index % 5 == 0,
                avatar: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    'https://scontent.fsgn5-14.fna.fbcdn.net/v/t1.6435-9/142432028_1736925749810194_5366117611380784464_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=I3EpO5KGzJEAX90L1UV&_nc_ht=scontent.fsgn5-14.fna&oh=00_AT8i4UpqrAf1SmLwdq9UNvcAj84XjsAL1QlCp23xSCRXUw&oe=62377F06',
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
                      showAlls[index] = showAlls[index] == null ? 3 : null;
                    });
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 76,
                      minWidth: 140,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F6F7),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      comments[index],
                      maxLines: showAlls[index],
                    ),
                  ),
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
