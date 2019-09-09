import 'package:flutter/material.dart';
import '../database/search_item.dart';
import 'video_page.dart';
import 'thumbnail_detail_page.dart';
import 'show_error.dart';

class DetailPage extends StatelessWidget {
  DetailPage({
    this.searchItem,
    Key key,
  }) : super(key: key);

  final SearchItem searchItem;

  @override
  Widget build(BuildContext context) {
    switch (searchItem.contentType) {
          case 'video':
            return VideoPage(
              searchItem: searchItem
            );
            break;
          case 'thumbnail':
            return ThumbnailDetailPage(
              searchItem: searchItem
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: Text('contentType error'),
              ),
              body: ShowError(
                errorMsg:
                    'undefined contentType of ${searchItem.contentType} in ruleID ${searchItem.ruleID}',
              ),
            );
        }
  }
}
