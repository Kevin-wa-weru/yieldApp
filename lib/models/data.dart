import 'dart:convert';

List<Farms> farmsFromJson(String str) =>
    List<Farms>.from(json.decode(str).map((x) => Farms.fromJson(x)));

String farmsToJson(List<Farms> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Farms {
  Farms({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.createdById,
    required this.fields,
    required this.square,
    required this.isOrganic,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int createdById;
  List<Field> fields;
  double square;
  bool isOrganic;

  factory Farms.fromJson(Map<String, dynamic> json) => Farms(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdById: json["createdById"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        square: json["square"].toDouble(),
        isOrganic: json["isOrganic"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdById": createdById,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "square": square,
        "isOrganic": isOrganic,
      };
}

class Field {
  Field({
    required this.id,
    required this.name,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
    required this.jsonFigure,
    required this.farmId,
    required this.actualArea,
    required this.boundaryArea,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.sections,
    required this.lastRefreshDate,
  });

  int id;
  String name;
  int createdById;
  DateTime createdAt;
  DateTime updatedAt;
  String jsonFigure;
  int farmId;
  double actualArea;
  double boundaryArea;
  String postalCode;
  String latitude;
  String longitude;
  List<Section> sections;
  DateTime lastRefreshDate;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        id: json["id"],
        name: json["name"],
        createdById: json["createdById"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        jsonFigure: json["jsonFigure"],
        farmId: json["farmId"],
        actualArea: json["actualArea"].toDouble(),
        boundaryArea: json["boundaryArea"].toDouble(),
        postalCode: json["postalCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
        lastRefreshDate: DateTime.parse(json["lastRefreshDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdById": createdById,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "jsonFigure": jsonFigure,
        "farmId": farmId,
        "actualArea": actualArea,
        "boundaryArea": boundaryArea,
        "postalCode": postalCode,
        "latitude": latitude,
        "longitude": longitude,
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
        "lastRefreshDate": lastRefreshDate.toIso8601String(),
      };
}

class Section {
  Section({
    required this.id,
    required this.createdById,
    required this.fieldId,
    required this.createdAt,
    required this.updatedAt,
    required this.cropId,
    required this.crop,
    required this.cropVarietyId,
    required this.cropVariety,
    required this.name,
    required this.jsonFigure,
    required this.actualArea,
    required this.targetYield,
    required this.plantingDensity,
    required this.targetYieldUnitType,
    required this.plantingDate,
    required this.harvestDate,
    required this.budBreak,
  });

  int id;
  int createdById;
  int fieldId;
  DateTime createdAt;
  DateTime updatedAt;
  int cropId;
  Crop crop;
  int cropVarietyId;
  CropVariety cropVariety;
  String name;
  String jsonFigure;
  double actualArea;
  int targetYield;
  int plantingDensity;
  String targetYieldUnitType;
  DateTime plantingDate;
  DateTime harvestDate;
  DateTime budBreak;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        createdById: json["createdById"],
        fieldId: json["fieldId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        cropId: json["cropId"],
        crop: Crop.fromJson(json["crop"]),
        cropVarietyId: json["cropVarietyId"],
        cropVariety: CropVariety.fromJson(json["cropVariety"]),
        name: json["name"],
        jsonFigure: json["jsonFigure"],
        actualArea: json["actualArea"].toDouble(),
        targetYield: json["targetYield"],
        plantingDensity: json["plantingDensity"],
        targetYieldUnitType: json["targetYieldUnitType"],
        plantingDate: DateTime.parse(json["plantingDate"]),
        harvestDate: DateTime.parse(json["harvestDate"]),
        budBreak: DateTime.parse(json["budBreak"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdById": createdById,
        "fieldId": fieldId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "cropId": cropId,
        "crop": crop.toJson(),
        "cropVarietyId": cropVarietyId,
        "cropVariety": cropVariety.toJson(),
        "name": name,
        "jsonFigure": jsonFigure,
        "actualArea": actualArea,
        "targetYield": targetYield,
        "plantingDensity": plantingDensity,
        "targetYieldUnitType": targetYieldUnitType,
        "plantingDate": plantingDate.toIso8601String(),
        "harvestDate": harvestDate.toIso8601String(),
        "budBreak": budBreak.toIso8601String(),
      };
}

class Crop {
  Crop({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdById,
    required this.name,
    required this.cropClassificationType,
    required this.lbsPerBushel,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int createdById;
  String name;
  int cropClassificationType;
  int lbsPerBushel;

  factory Crop.fromJson(Map<String, dynamic> json) => Crop(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdById: json["createdById"],
        name: json["name"],
        cropClassificationType: json["cropClassificationType"],
        lbsPerBushel: json["lbsPerBushel"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdById": createdById,
        "name": name,
        "cropClassificationType": cropClassificationType,
        "lbsPerBushel": lbsPerBushel,
      };
}

class CropVariety {
  CropVariety({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdById,
    required this.cropClassificationType,
    required this.cropId,
    required this.name,
    required this.minIdealTemperature,
    required this.maxIdealTemperature,
    required this.minThresholdTemperature,
    required this.maxThresholdTemperature,
    required this.temperatureUnitType,
    required this.harvestType,
    required this.minYield,
    required this.maxYield,
    required this.yieldUnitType,
    required this.notes,
    required this.isActive,
    this.commonActiveIngredients,
    required this.commonPests,
    required this.commonDiseases,
    required this.cropGrowthStages,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int createdById;
  int cropClassificationType;
  int cropId;
  String name;
  int minIdealTemperature;
  int maxIdealTemperature;
  int minThresholdTemperature;
  int maxThresholdTemperature;
  int temperatureUnitType;
  int harvestType;
  int minYield;
  int maxYield;
  int yieldUnitType;
  String notes;
  bool isActive;
  dynamic commonActiveIngredients;
  List<dynamic> commonPests;
  List<dynamic> commonDiseases;
  List<dynamic> cropGrowthStages;

  factory CropVariety.fromJson(Map<String, dynamic> json) => CropVariety(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdById: json["createdById"],
        cropClassificationType: json["cropClassificationType"],
        cropId: json["cropId"],
        name: json["name"],
        minIdealTemperature: json["minIdealTemperature"],
        maxIdealTemperature: json["maxIdealTemperature"],
        minThresholdTemperature: json["minThresholdTemperature"],
        maxThresholdTemperature: json["maxThresholdTemperature"],
        temperatureUnitType: json["temperatureUnitType"],
        harvestType: json["harvestType"],
        minYield: json["minYield"],
        maxYield: json["maxYield"],
        yieldUnitType: json["yieldUnitType"],
        notes: json["notes"],
        isActive: json["isActive"],
        commonActiveIngredients: json["commonActiveIngredients"],
        commonPests: List<dynamic>.from(json["commonPests"].map((x) => x)),
        commonDiseases:
            List<dynamic>.from(json["commonDiseases"].map((x) => x)),
        cropGrowthStages:
            List<dynamic>.from(json["cropGrowthStages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "createdById": createdById,
        "cropClassificationType": cropClassificationType,
        "cropId": cropId,
        "name": name,
        "minIdealTemperature": minIdealTemperature,
        "maxIdealTemperature": maxIdealTemperature,
        "minThresholdTemperature": minThresholdTemperature,
        "maxThresholdTemperature": maxThresholdTemperature,
        "temperatureUnitType": temperatureUnitType,
        "harvestType": harvestType,
        "minYield": minYield,
        "maxYield": maxYield,
        "yieldUnitType": yieldUnitType,
        "notes": notes,
        "isActive": isActive,
        "commonActiveIngredients": commonActiveIngredients,
        "commonPests": List<dynamic>.from(commonPests.map((x) => x)),
        "commonDiseases": List<dynamic>.from(commonDiseases.map((x) => x)),
        "cropGrowthStages": List<dynamic>.from(cropGrowthStages.map((x) => x)),
      };
}
