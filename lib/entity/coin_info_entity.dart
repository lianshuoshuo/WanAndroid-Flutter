class CoinInfoEntity {
  int coinCount;
  String rank;
  int userId;
  String username;

  CoinInfoEntity({this.coinCount, this.rank, this.userId, this.username});

  CoinInfoEntity.fromJson(Map<String, dynamic> json) {
    coinCount = json['coinCount'];
    rank = json['rank'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinCount'] = this.coinCount;
    data['rank'] = this.rank;
    data['userId'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}
