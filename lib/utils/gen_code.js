
function genCode(name, code) {
    var safeFromJson = '';
    var fromJson = '';
    var toJson = '';

    `${code}`.split('\n').forEach(line => {
        var v = line.trim().split(/\s+/)[1].replace(';', '');
        safeFromJson += `${v} = json['${v}'] ?? default${name}.${v};\n    `;
        fromJson += `${v} = json['${v}'],\n    `;
        toJson += `'${v}': ${v},\n    `;
    });

    return `${name}.safeFromJson(Map<String, dynamic> json) {
    final default${name} = ${name}();
    ${safeFromJson}}

    ${name}.fromJson(Map<String, dynamic> json)
    :${fromJson};

    Map<String, dynamic> toJson() => {
    ${toJson}};
    `;

}

var re;
re = genCode('rule', `  int id = DateTime.now().microsecondsSinceEpoch;
String name;
String host;
String type = 'video';
bool enCheerio = false;
String discoverUrl;
String discoverItems;
String searchUrl;
String searchItems;
String detailUrl;
String detailItems;
bool enMultiRoads = false;
String chapterUrl;
String chapterItems;
String contentUrl;
String contentItems;`);
console.log(re)

