import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final List<Food>? food;
  final List<FoodCategory>? foodCategory;
  final List<FoodSet>? foodSet;

  const Result({
    this.food,
    this.foodCategory,
    this.foodSet,
  });

  @override
  List<Object?> get props => [
        food,
        foodCategory,
        foodSet,
      ];
}

class Food {
  String? foodId;
  String? foodName;
  String? foodNameAlt;
  double? foodPrice;
  String? foodDesc;
  int? foodSorting;
  bool? active;
  String? foodSetId;
  String? foodCatId;
  String? revenueClassId;
  String? taxRateId;
  String? taxRate2Id;
  bool? priority;
  bool? printSingle;
  bool? isCommand;
  bool? foodShowOption;
  String? foodPdaNumber;
  DateTime? modifyOn;
  DateTime? createOn;
  String? pureImageName;
  String? imageName;
  int? qtyLimit;
  bool? isLimit;
  String? productId;
  bool? isOutStock;
  bool? isFree;
  bool? isShow;
  bool? isShowInstruction;
  String? imageNameString;
  int? thirdPartyGroupId;
  String? foodBaseId;
  bool? isThirdParty;
  dynamic plu;
  String? imageThirdParty;

  Food({
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
}

class FoodCategory {
  String? foodCatId;
  String? foodCatName;
  int? foodCatSorting;
  dynamic foodCatDesc;
  String? foodCatColor;
  String? foodCatIcon;
  bool? priority;
  int? foodCatParent;
  bool? active;

  FoodCategory({
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
}

class FoodSet {
  String? foodSetId;
  String? foodSetName;
  String? foodSetChar;
  int? foodSetSorting;
  bool? isThirdParty;
  bool? active;

  FoodSet({
    this.foodSetId,
    this.foodSetName,
    this.foodSetChar,
    this.foodSetSorting,
    this.isThirdParty,
    this.active,
  });
}
