class MainItemViewBean {
  String title;
  dynamic img;
  String url;

  @pragma('vm:entry-point')
  int iconTextColors;

  MainItemViewBean({this.title, this.img, this.url,this.iconTextColors=0xff666666});
}
