import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';

class BannerEntity with JsonConvert<BannerEntity> {
	String desc;
	double id;
	String imagePath;
	double isVisible;
	double order;
	String title;
	double type;
	String url;
}
