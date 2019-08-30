class CustomItem {
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  CustomItem({
    this.thumbnailUrl,
    this.title,
    this.subtitle,
    this.author,
    this.publishDate,
    this.readDuration,
  });

  CustomItem.safeFromJson(Map<dynamic, dynamic> json)
      : thumbnailUrl = json['thumbnailUrl']?.toString() ?? '',
        title = json['title']?.toString() ?? '',
        subtitle = json['subtitle']?.toString() ?? '',
        author = json['author']?.toString() ?? '',
        publishDate = json['publishDate']?.toString() ?? '',
        readDuration = json['readDuration']?.toString() ?? '';

  CustomItem.fromJson(Map<dynamic, dynamic> json)
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