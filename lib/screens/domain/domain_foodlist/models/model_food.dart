import 'package:equatable/equatable.dart';
import 'dart:convert';

FoodEntity foodEntityFromJson(String str) =>
    FoodEntity.fromJson(json.decode(str));

String foodEntityToJson(FoodEntity data) => json.encode(data.toJson());

class FoodEntity extends Equatable {
  final Result? result;

  const FoodEntity({
    this.result,
  });

  factory FoodEntity.fromJson(Map<String, dynamic> json) => FoodEntity(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
      };

  @override
  List<Object?> get props => [result];
}

class Result extends Equatable {
  final List<Food>? food;
  final List<FoodCategory>? foodCategory;
  final List<FoodSet>? foodSet;

  const Result({
    this.food,
    this.foodCategory,
    this.foodSet,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        food: json["food"] == null
            ? []
            : List<Food>.from(json["food"]!.map((x) => Food.fromJson(x))),
        foodCategory: json["foodCategory"] == null
            ? []
            : List<FoodCategory>.from(
                json["foodCategory"]!.map((x) => FoodCategory.fromJson(x))),
        foodSet: json["foodSet"] == null
            ? []
            : List<FoodSet>.from(
                json["foodSet"]!.map((x) => FoodSet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "food": food == null
            ? []
            : List<dynamic>.from(food!.map((x) => x.toJson())),
        "foodCategory": foodCategory == null
            ? []
            : List<dynamic>.from(foodCategory!.map((x) => x.toJson())),
        "foodSet": foodSet == null
            ? []
            : List<dynamic>.from(foodSet!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [food, foodCategory, foodSet];
}

class Food extends Equatable {
  final String? foodId;
  final String? foodName;
  final String? foodNameAlt;
  final double? foodPrice;
  final String? foodDesc;
  final int? foodSorting;
  final bool? active;
  final String? foodSetId;
  final String? foodCatId;
  final String? revenueClassId;
  final String? taxRateId;
  final String? taxRate2Id;
  final bool? priority;
  final bool? printSingle;
  final bool? isCommand;
  final bool? foodShowOption;
  final String? foodPdaNumber;
  final DateTime? modifyOn;
  final DateTime? createOn;
  final String? pureImageName;
  final String? imageName;
  final int? qtyLimit;
  final bool? isLimit;
  final String? productId;
  final bool? isOutStock;
  final bool? isFree;
  final bool? isShow;
  final bool? isShowInstruction;
  final String? imageNameString;
  final int? thirdPartyGroupId;
  final String? foodBaseId;
  final bool? isThirdParty;
  final dynamic plu;
  final String? imageThirdParty;

  const Food({
    this.foodId,
    this.foodName,
    this.foodNameAlt,
    this.foodPrice,
    this.foodDesc,
    this.foodSorting,
    this.active,
    this.foodSetId,
    this.foodCatId,
    this.revenueClassId,
    this.taxRateId,
    this.taxRate2Id,
    this.priority,
    this.printSingle,
    this.isCommand,
    this.foodShowOption,
    this.foodPdaNumber,
    this.modifyOn,
    this.createOn,
    this.pureImageName,
    this.imageName,
    this.qtyLimit,
    this.isLimit,
    this.productId,
    this.isOutStock,
    this.isFree,
    this.isShow,
    this.isShowInstruction,
    this.imageNameString,
    this.thirdPartyGroupId,
    this.foodBaseId,
    this.isThirdParty,
    this.plu,
    this.imageThirdParty,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        foodId: json["foodId"],
        foodName: json["foodName"],
        foodNameAlt: json["foodNameAlt"],
        foodPrice: json["foodPrice"]?.toDouble(),
        foodDesc: json["foodDesc"],
        foodSorting: json["foodSorting"],
        active: json["active"],
        foodSetId: json["foodSetId"],
        foodCatId: json["foodCatId"],
        revenueClassId: json["revenueClassId"],
        taxRateId: json["taxRateId"],
        taxRate2Id: json["taxRate2Id"],
        priority: json["priority"],
        printSingle: json["printSingle"],
        isCommand: json["isCommand"],
        foodShowOption: json["foodShowOption"],
        foodPdaNumber: json["foodPDANumber"],
        modifyOn:
            json["modifyOn"] == null ? null : DateTime.parse(json["modifyOn"]),
        createOn:
            json["createOn"] == null ? null : DateTime.parse(json["createOn"]),
        pureImageName: json["pureImageName"],
        imageName: json["imageName"],
        qtyLimit: json["qtyLimit"],
        isLimit: json["isLimit"],
        productId: json["productId"],
        isOutStock: json["isOutStock"],
        isFree: json["isFree"],
        isShow: json["isShow"],
        isShowInstruction: json["isShowInstruction"],
        imageNameString: json["imageNameString"],
        thirdPartyGroupId: json["thirdPartyGroupId"],
        foodBaseId: json["foodBaseId"],
        isThirdParty: json["isThirdParty"],
        plu: json["plu"],
        imageThirdParty: json["imageThirdParty"],
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "foodName": foodName,
        "foodNameAlt": foodNameAlt,
        "foodPrice": foodPrice,
        "foodDesc": foodDesc,
        "foodSorting": foodSorting,
        "active": active,
        "foodSetId": foodSetId,
        "foodCatId": foodCatId,
        "revenueClassId": revenueClassId,
        "taxRateId": taxRateId,
        "taxRate2Id": taxRate2Id,
        "priority": priority,
        "printSingle": printSingle,
        "isCommand": isCommand,
        "foodShowOption": foodShowOption,
        "foodPDANumber": foodPdaNumber,
        "modifyOn": modifyOn?.toIso8601String(),
        "createOn": createOn?.toIso8601String(),
        "pureImageName": pureImageName,
        "imageName": imageName,
        "qtyLimit": qtyLimit,
        "isLimit": isLimit,
        "productId": productId,
        "isOutStock": isOutStock,
        "isFree": isFree,
        "isShow": isShow,
        "isShowInstruction": isShowInstruction,
        "imageNameString": imageNameString,
        "thirdPartyGroupId": thirdPartyGroupId,
        "foodBaseId": foodBaseId,
        "isThirdParty": isThirdParty,
        "plu": plu,
        "imageThirdParty": imageThirdParty,
      };

  @override
  List<Object?> get props => [
        foodId,
        foodName,
        foodNameAlt,
        foodPrice,
        foodDesc,
        foodSorting,
        active,
        foodSetId,
        foodCatId,
        revenueClassId,
        taxRateId,
        taxRate2Id,
        priority,
        printSingle,
        isCommand,
        foodShowOption,
        foodPdaNumber,
        modifyOn,
        createOn,
        pureImageName,
        imageName,
        qtyLimit,
        isLimit,
        productId,
        isOutStock,
        isFree,
        isShow,
        isShowInstruction,
        imageNameString,
        thirdPartyGroupId,
        foodBaseId,
        isThirdParty,
        plu,
        imageThirdParty,
      ];
}

class FoodCategory extends Equatable {
  final String? foodCatId;
  final String? foodCatName;
  final int? foodCatSorting;
  final dynamic foodCatDesc;
  final String? foodCatColor;
  final String? foodCatIcon;
  final bool? priority;
  final int? foodCatParent;
  final bool? active;

  const FoodCategory({
    this.foodCatId,
    this.foodCatName,
    this.foodCatSorting,
    this.foodCatDesc,
    this.foodCatColor,
    this.foodCatIcon,
    this.priority,
    this.foodCatParent,
    this.active,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        foodCatId: json["foodCatId"],
        foodCatName: json["foodCatName"],
        foodCatSorting: json["foodCatSorting"],
        foodCatDesc: json["foodCatDesc"],
        foodCatColor: json["foodCatColor"],
        foodCatIcon: json["foodCatIcon"],
        priority: json["priority"],
        foodCatParent: json["foodCatParent"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "foodCatId": foodCatId,
        "foodCatName": foodCatName,
        "foodCatSorting": foodCatSorting,
        "foodCatDesc": foodCatDesc,
        "foodCatColor": foodCatColor,
        "foodCatIcon": foodCatIcon,
        "priority": priority,
        "foodCatParent": foodCatParent,
        "active": active,
      };

  @override
  List<Object?> get props => [
        foodCatId,
        foodCatName,
        foodCatSorting,
        foodCatDesc,
        foodCatColor,
        foodCatIcon,
        priority,
        foodCatParent,
        active,
      ];
}

class FoodSet extends Equatable {
  final String? foodSetId;
  final String? foodSetName;
  final String? foodSetChar;
  final int? foodSetSorting;
  final bool? isThirdParty;
  final bool? active;

  const FoodSet({
    this.foodSetId,
    this.foodSetName,
    this.foodSetChar,
    this.foodSetSorting,
    this.isThirdParty,
    this.active,
  });

  factory FoodSet.fromJson(Map<String, dynamic> json) => FoodSet(
        foodSetId: json["foodSetId"],
        foodSetName: json["foodSetName"],
        foodSetChar: json["foodSetChar"],
        foodSetSorting: json["foodSetSorting"],
        isThirdParty: json["isThirdParty"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "foodSetId": foodSetId,
        "foodSetName": foodSetName,
        "foodSetChar": foodSetChar,
        "foodSetSorting": foodSetSorting,
        "isThirdParty": isThirdParty,
        "active": active,
      };

  @override
  List<Object?> get props => [
        foodSetId,
        foodSetName,
        foodSetChar,
        foodSetSorting,
        isThirdParty,
        active,
      ];
}
