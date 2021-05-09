class ArticleDbEntity {
  String author;
  String desc;
  String title;
  String shareUser;
  String niceDate;
  String link;


  ArticleDbEntity( this.author, this.desc, this.title, this.shareUser,
      this.niceDate, this.link);

  ArticleDbEntity.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    desc = json['desc'];
    title = json['title'];
    shareUser = json['shareUser'];
    niceDate = json['niceDate'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['desc'] = this.desc;
    data['title'] = this.title;
    data['shareUser'] = this.shareUser;
    data['niceDate'] = this.niceDate;
    data['link'] = this.link;
    return data;
  }
}
