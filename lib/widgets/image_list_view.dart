import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nft_template/screens/nft_screen.dart';

class ImageListView extends StatefulWidget {
  final int startIndex;
  final int duration;
  const ImageListView({
    Key? key,
    required this.startIndex,
    this.duration = 30,
  }) : super(key: key);

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        _autoScroll();
      }
    });

    //Add this to make sure that the controller has been attached to the ListView
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _autoScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _autoScroll() {
    final _currentScrollPosition = _scrollController.offset;
    final _scrollEndPosition = _scrollController.position.maxScrollExtent;

    scheduleMicrotask(
      () {
        _scrollController.animateTo(
          _currentScrollPosition == _scrollEndPosition ? 0 : _scrollEndPosition,
          duration: Duration(seconds: widget.duration),
          curve: Curves.linear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: 130,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return _ImageTile(
              image: "assets/nft/${widget.startIndex + index}.png",
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

class _ImageTile extends StatelessWidget {
  final String image;
  const _ImageTile({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          NFTScreen.pageRoute,
          arguments: image,
        );
      },
      child: Hero(
        tag: image,
        child: Image.asset(
          image,
          width: 130,
        ),
      ),
    );
  }
}
