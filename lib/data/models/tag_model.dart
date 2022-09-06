import 'package:flutter_twitch_clone/data/models/model.dart';

class TagModel extends Model {
  TagModel({
    this.tagId,
    this.isAuto,
    this.localizationNames,
    this.localizationDescriptions,
  });

  String? tagId;
  bool? isAuto;
  Localization? localizationNames;
  Localization? localizationDescriptions;

  TagModel copyWith({
    String? tagId,
    bool? isAuto,
    Localization? localizationNames,
    Localization? localizationDescriptions,
  }) =>
      TagModel(
        tagId: tagId ?? this.tagId,
        isAuto: isAuto ?? this.isAuto,
        localizationNames: localizationNames ?? this.localizationNames,
        localizationDescriptions:
            localizationDescriptions ?? this.localizationDescriptions,
      );

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        tagId: json["tag_id"],
        isAuto: json["is_auto"],
        localizationNames: Localization.fromJson(json["localization_names"]),
        localizationDescriptions:
            Localization.fromJson(json["localization_descriptions"]),
      );
  @override
  Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "is_auto": isAuto,
        "localization_names":
            localizationNames != null ? localizationNames!.toJson() : {},
        "localization_descriptions": localizationDescriptions != null
            ? localizationDescriptions!.toJson()
            : {},
      };

  @override
  Model fromJson(json) {
    return TagModel.fromJson(json);
  }
}

class Localization {
  Localization({
    this.bgBg,
    this.csCz,
    this.daDk,
    this.deDe,
    this.elGr,
    this.enUs,
    this.esEs,
    this.esMx,
    this.fiFi,
    this.frFr,
    this.huHu,
    this.itIt,
    this.jaJp,
    this.koKr,
    this.nlNl,
    this.noNo,
    this.plPl,
    this.ptBr,
    this.ptPt,
    this.roRo,
    this.ruRu,
    this.skSk,
    this.svSe,
    this.thTh,
    this.trTr,
    this.viVn,
    this.zhCn,
    this.zhTw,
  });

  String? bgBg;
  String? csCz;
  String? daDk;
  String? deDe;
  String? elGr;
  String? enUs;
  String? esEs;
  String? esMx;
  String? fiFi;
  String? frFr;
  String? huHu;
  String? itIt;
  String? jaJp;
  String? koKr;
  String? nlNl;
  String? noNo;
  String? plPl;
  String? ptBr;
  String? ptPt;
  String? roRo;
  String? ruRu;
  String? skSk;
  String? svSe;
  String? thTh;
  String? trTr;
  String? viVn;
  String? zhCn;
  String? zhTw;

  Localization copyWith({
    String? bgBg,
    String? csCz,
    String? daDk,
    String? deDe,
    String? elGr,
    String? enUs,
    String? esEs,
    String? esMx,
    String? fiFi,
    String? frFr,
    String? huHu,
    String? itIt,
    String? jaJp,
    String? koKr,
    String? nlNl,
    String? noNo,
    String? plPl,
    String? ptBr,
    String? ptPt,
    String? roRo,
    String? ruRu,
    String? skSk,
    String? svSe,
    String? thTh,
    String? trTr,
    String? viVn,
    String? zhCn,
    String? zhTw,
  }) =>
      Localization(
        bgBg: bgBg ?? this.bgBg,
        csCz: csCz ?? this.csCz,
        daDk: daDk ?? this.daDk,
        deDe: deDe ?? this.deDe,
        elGr: elGr ?? this.elGr,
        enUs: enUs ?? this.enUs,
        esEs: esEs ?? this.esEs,
        esMx: esMx ?? this.esMx,
        fiFi: fiFi ?? this.fiFi,
        frFr: frFr ?? this.frFr,
        huHu: huHu ?? this.huHu,
        itIt: itIt ?? this.itIt,
        jaJp: jaJp ?? this.jaJp,
        koKr: koKr ?? this.koKr,
        nlNl: nlNl ?? this.nlNl,
        noNo: noNo ?? this.noNo,
        plPl: plPl ?? this.plPl,
        ptBr: ptBr ?? this.ptBr,
        ptPt: ptPt ?? this.ptPt,
        roRo: roRo ?? this.roRo,
        ruRu: ruRu ?? this.ruRu,
        skSk: skSk ?? this.skSk,
        svSe: svSe ?? this.svSe,
        thTh: thTh ?? this.thTh,
        trTr: trTr ?? this.trTr,
        viVn: viVn ?? this.viVn,
        zhCn: zhCn ?? this.zhCn,
        zhTw: zhTw ?? this.zhTw,
      );

  factory Localization.fromJson(Map<String, dynamic> json) => Localization(
        bgBg: json["bg-bg"],
        csCz: json["cs-cz"],
        daDk: json["da-dk"],
        deDe: json["de-de"],
        elGr: json["el-gr"],
        enUs: json["en-us"],
        esEs: json["es-es"],
        esMx: json["es-mx"],
        fiFi: json["fi-fi"],
        frFr: json["fr-fr"],
        huHu: json["hu-hu"],
        itIt: json["it-it"],
        jaJp: json["ja-jp"],
        koKr: json["ko-kr"],
        nlNl: json["nl-nl"],
        noNo: json["no-no"],
        plPl: json["pl-pl"],
        ptBr: json["pt-br"],
        ptPt: json["pt-pt"],
        roRo: json["ro-ro"],
        ruRu: json["ru-ru"],
        skSk: json["sk-sk"],
        svSe: json["sv-se"],
        thTh: json["th-th"],
        trTr: json["tr-tr"],
        viVn: json["vi-vn"],
        zhCn: json["zh-cn"],
        zhTw: json["zh-tw"],
      );

  Map<String, dynamic> toJson() => {
        "bg-bg": bgBg,
        "cs-cz": csCz,
        "da-dk": daDk,
        "de-de": deDe,
        "el-gr": elGr,
        "en-us": enUs,
        "es-es": esEs,
        "es-mx": esMx,
        "fi-fi": fiFi,
        "fr-fr": frFr,
        "hu-hu": huHu,
        "it-it": itIt,
        "ja-jp": jaJp,
        "ko-kr": koKr,
        "nl-nl": nlNl,
        "no-no": noNo,
        "pl-pl": plPl,
        "pt-br": ptBr,
        "pt-pt": ptPt,
        "ro-ro": roRo,
        "ru-ru": ruRu,
        "sk-sk": skSk,
        "sv-se": svSe,
        "th-th": thTh,
        "tr-tr": trTr,
        "vi-vn": viVn,
        "zh-cn": zhCn,
        "zh-tw": zhTw,
      };
}
