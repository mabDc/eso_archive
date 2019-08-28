class SearchCustomItem {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  SearchCustomItem({
    this.thumbnailUrl,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  SearchCustomItem.safeFromJson(Map<String, dynamic> json)
      : thumbnailUrl = json['thumbnailUrl']?.toString() ?? '',
        title = json['title']?.toString() ?? '',
        subtitle = json['subtitle']?.toString() ?? '',
        author = json['author']?.toString() ?? '',
        publishDate = json['publishDate']?.toString() ?? '',
        readDuration = json['readDuration']?.toString() ?? '';

  SearchCustomItem.fromJson(Map<String, dynamic> json)
      : thumbnailUrl = json['thumbnailUrl'],
        title = json['title'],
        subtitle = json['subtitle'],
        author = json['author'],
        publishDate = json['publishDate'],
        readDuration = json['readDuration'];
        
  Map<String, dynamic> toJson() => {
        'thumbnailUrl': thumbnailUrl,
        'title': title,
        'subtitle': subtitle,
        'author': author,
        'publishDate': publishDate,
        'readDuration': readDuration,
      };
}

// final items = <SearchItem>[
//   SearchItem(
//     title: 'Flutter 1.0 Launch',
//     subtitle: 'Flutter continues to improve and expand its horizons.'
//         'This text should max out at two lines and clip',
//     author: 'Dash',
//     publishDate: 'Dec 28',
//     readDuration: '5 mins',
//   ),
//   SearchItem(
//     title: 'Flutter 1.2 Release - Continual updates to the framework',
//     subtitle: 'Flutter once again improves and makes updates.',
//     author: 'Flutter',
//     publishDate: 'Feb 26',
//     readDuration: '12 mins',
//   ),
// ];

// '''
// (()=>{
//   return [{
//     title: 'Flutter 1.0 Launch',
//     subtitle: 'Flutter continues to improve and expand its horizons.'+
//         'This text should max out at two lines and clip',
//     author: 'Dash',
//     publishDate: 'Dec 28',
//     readDuration: '5 mins',
//   },{
//     title: 'Flutter 1.2 Release - Continual updates to the framework',
//     subtitle: 'Flutter once again improves and makes updates.',
//     author: 'Flutter',
//     publishDate: 'Feb 26',
//     readDuration: '12 mins',
//   }];
// })()
// '''
