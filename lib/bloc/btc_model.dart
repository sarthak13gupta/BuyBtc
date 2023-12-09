class BtcModel {
  BtcModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.marketCapChangePercentage24H,
    required this.sparklineIn7D,
  });

  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  int marketCapRank;
  double totalVolume;
  double high24H;
  double low24H;
  double priceChange24H;
  double marketCapChangePercentage24H;
  SparklineIn7D sparklineIn7D;

  factory BtcModel.fromJson(Map<String, dynamic> json) => BtcModel(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: json["current_price"].toDouble(),
        marketCapRank: json["market_cap_rank"],
        totalVolume: json["total_volume"].toDouble(),
        high24H: json["high_24h"].toDouble(),
        low24H: json["low_24h"].toDouble(),
        priceChange24H: json["price_change_24h"]?.toDouble(),
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"]?.toDouble(),
        sparklineIn7D: SparklineIn7D.fromJson(json["sparkline_in_7d"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap_rank": marketCapRank,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "sparkline_in_7d": sparklineIn7D.toJson(),
      };
}

class SparklineIn7D {
  SparklineIn7D({
    required this.price,
  });

  List<double> price;

  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
        price: List<double>.from(json["price"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "price": List<dynamic>.from(price.map((x) => x)),
      };
}

class ChartModel {
  DateTime time;
  double? price;

  ChartModel({
    required this.time,
    this.price,
  });

  factory ChartModel.fromJson(List l) {
    return ChartModel(
      time: DateTime.fromMillisecondsSinceEpoch(l[0]),
      price: l[1],
    );
  }
}

class ChartData {
  List<ChartModel> chartValues;
  double minPrice;
  double maxPrice;

  ChartData({
    required this.chartValues,
    required this.maxPrice,
    required this.minPrice,
  });
}
