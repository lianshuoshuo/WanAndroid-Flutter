
import 'package:flutter_wanandroid/entity/user_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['admin'] != null) {
		data.admin = json['admin'];
	}
	if (json['chapterTops'] != null) {
		data.chapterTops = (json['chapterTops'] as List).map((v) => v).toList().cast<dynamic>();
	}
	if (json['coinCount'] != null) {
		data.coinCount = json['coinCount'] is String
				? int.tryParse(json['coinCount'])
				: json['coinCount'].toInt();
	}
	if (json['collectIds'] != null) {
		data.collectIds = (json['collectIds'] as List).map((v) => v is String
				? int.tryParse(v)
				: v.toInt()).toList().cast<int>();
	}
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['icon'] != null) {
		data.icon = json['icon'].toString();
	}
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['password'] != null) {
		data.password = json['password'].toString();
	}
	if (json['publicName'] != null) {
		data.publicName = json['publicName'].toString();
	}
	if (json['token'] != null) {
		data.token = json['token'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'] is String
				? int.tryParse(json['type'])
				: json['type'].toInt();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['admin'] = entity.admin;
	data['chapterTops'] = entity.chapterTops;
	data['coinCount'] = entity.coinCount;
	data['collectIds'] = entity.collectIds;
	data['email'] = entity.email;
	data['icon'] = entity.icon;
	data['id'] = entity.id;
	data['nickname'] = entity.nickname;
	data['password'] = entity.password;
	data['publicName'] = entity.publicName;
	data['token'] = entity.token;
	data['type'] = entity.type;
	data['username'] = entity.username;
	return data;
}