 import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class ArticleEntity with JsonConvert<ArticleEntity> {
	String apkLink;
	int audit;
	String author;
	bool canEdit;
	int chapterId;
	String chapterName;
	bool collect;
	int courseId;
	String desc;
	String descMd;
	String envelopePic;
	bool fresh;
	String host;
	int id;
	String link;
	String niceDate;
	String niceShareDate;
	String origin;
	String prefix;
	String projectLink;
	int publishTime;
	int realSuperChapterId;
	int selfVisible;
	int shareDate;
	String shareUser;
	int superChapterId;
	String superChapterName;
	List<ArticleTags> tags;
	String title;
	int type;
	int userId;
	int visible;
	int zan;
}

class ArticleTags with JsonConvert<ArticleTags> {
	String name;
	String url;
}
