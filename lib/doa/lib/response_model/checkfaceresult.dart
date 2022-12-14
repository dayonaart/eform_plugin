class Checkfaceresult {
  String? nik;
  String? refNum;
  String? channel;
  String? retryCount;
  String? faceAttack;
  String? quality;
  String? resultCode;
  String? resultMessage;
  String? resultStatus;
  String? availableLiveness;
  String? errorCode;
  String? errorMessage;
  String? imageContent;

  Checkfaceresult({
    this.nik,
    this.refNum,
    this.channel,
    this.retryCount,
    this.faceAttack,
    this.quality,
    this.resultCode,
    this.resultMessage,
    this.resultStatus,
    this.availableLiveness,
    this.errorCode,
    this.errorMessage,
    this.imageContent,
  });

  factory Checkfaceresult.fromJson(Map<String, dynamic> json) {
    return Checkfaceresult(
      nik: json['nik'] as String?,
      refNum: json['refNum'] as String?,
      channel: json['channel'] as String?,
      retryCount: json['retryCount'] as String?,
      faceAttack: json['faceAttack'] as String?,
      quality: json['quality'] as String?,
      resultCode: json['resultCode'] as String?,
      resultMessage: json['resultMessage'] as String?,
      resultStatus: json['resultStatus'] as String?,
      availableLiveness: json['availableLiveness'] as String?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
      imageContent: json['imageContent'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'nik': nik,
        'refNum': refNum,
        'channel': channel,
        'retryCount': retryCount,
        'faceAttack': faceAttack,
        'quality': quality,
        'resultCode': resultCode,
        'resultMessage': resultMessage,
        'resultStatus': resultStatus,
        'availableLiveness': availableLiveness,
        'errorCode': errorCode,
        'errorMessage': errorMessage,
        'imageContent': imageContent,
      };
}
