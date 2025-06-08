
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlbumPageView extends StatefulWidget {
  const AlbumPageView({super.key});

  @override
  State<AlbumPageView> createState() => _InfinitePageViewState();
}

class _InfinitePageViewState extends State<AlbumPageView> {
  final ScrollController controller = ScrollController();
  late List<String> _messages;
  int totalCount = 100;
  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    _messages = List.generate(totalCount, (i) => 'Message   #${totalCount - i}');
  }

  void scrollListener() async {
    var max = controller.position.maxScrollExtent;
    var offset = controller.offset;


    if (controller.position.atEdge) {
      bool isTop = controller.position.pixels == 0;
      if (isTop) {
        print('isTop');
        _messages.insertAll(0,_messages.getRange(0, totalCount));
      } else {
        print('isBottom');
        _messages.addAll(_messages.getRange(0, totalCount));
      }
      setState(() {
        totalCount = _messages.length;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Infinite PageView')),
        body: ListView.builder(
          controller: controller,
          itemCount: totalCount,
          itemBuilder: (BuildContext context, int index) {
            return Text(_messages[index]);
          },
        ));
  }


}