import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:pearl/models/api.dart';
import 'package:pearl/models/f0skr.dart';
import 'package:pearl/models/f1skr.dart';
import 'package:pearl/models/f2skr.dart';
import 'package:pearl/models/f3skr.dart';
import 'package:pearl/models/nnovssps.dart';
import 'package:pearl/models/pu_type.dart';
import 'package:pearl/models/pump_constant.dart';
import 'package:pearl/models/rod_and_pump_data.dart';
import 'package:pearl/models/sr_api.dart';
import 'package:pearl/models/sr_data.dart';
import 'package:pearl/models/sr_grade.dart';
import 'package:pearl/models/twotskr.dart';

class SRPFunction {
  Future<void> initializeF0SkrData() async {
    var box = await Hive.openBox<F0SkrModel>('f0SkrBox');

    final String response =
        await rootBundle.loadString('assets/N-NovsFo-Skr.json');
    final List<dynamic> data = json.decode(response);

    List<F0SkrModel> f0SkrList = F0SkrModel.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, F0SkrModel> f0SkrMap = {
        for (int i = 0; i < f0SkrList.length; i++) 'f0Skr_$i': f0SkrList[i]
      };

      // Insert all data at once
      await box.putAll(f0SkrMap);

      print("F0Skr data inserted into Hive.");
    } else {
      print("F0Skr data already exists.");
    }
  }

  Future<void> initializeTwoTSkrData() async {
    var box = await Hive.openBox<TwoTSkrModel>('twoTSkrBox');

    final String response =
        await rootBundle.loadString('assets/N-Novs2T-S2Kr.json');
    final List<dynamic> data = json.decode(response);

    List<TwoTSkrModel> twoTSkrList = TwoTSkrModel.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, TwoTSkrModel> twoTSkrMap = {
        for (int i = 0; i < twoTSkrList.length; i++)
          'twoTSkr_$i': twoTSkrList[i]
      };

      // Insert all data at once
      await box.putAll(twoTSkrMap);

      print("TwoTSkr data inserted into Hive.");
    } else {
      print("TwoTSkr data already exists.");
    }
  }

  Future<void> initializeF3SkrData() async {
    var box = await Hive.openBox<F3SkrModel>('f3SkrBox');

    final String response =
        await rootBundle.loadString('assets/N-NovsF3-Skr.json');
    final List<dynamic> data = json.decode(response);

    List<F3SkrModel> f3SkrList = F3SkrModel.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, F3SkrModel> f3SkrMap = {
        for (int i = 0; i < f3SkrList.length; i++) 'f3Skr_$i': f3SkrList[i]
      };

      // Insert all data at once
      await box.putAll(f3SkrMap);

      print("F3Skr data inserted into Hive.");
    } else {
      print("F3Skr data already exists.");
    }
  }

  Future<void> initializeF2SkrData() async {
    var box = await Hive.openBox<F2SkrModel>('f2SkrBox');

    final String response =
        await rootBundle.loadString('assets/N-NovsF2-Skr.json');
    final List<dynamic> data = json.decode(response);

    List<F2SkrModel> f2SkrList = F2SkrModel.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, F2SkrModel> f2SkrMap = {
        for (int i = 0; i < f2SkrList.length; i++) 'f2Skr_$i': f2SkrList[i]
      };

      // Insert all data at once
      await box.putAll(f2SkrMap);

      print("F2Skr data inserted into Hive.");
    } else {
      print("F2Skr data already exists.");
    }
  }

  Future<void> initializeF1SkrData() async {
    var box = await Hive.openBox<F1SkrModel>('f1SkrBox');

    final String response =
        await rootBundle.loadString('assets/N-NovsF1-Skr.json');
    final List<dynamic> data = json.decode(response);

    List<F1SkrModel> f1SkrList = F1SkrModel.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, F1SkrModel> f1SkrMap = {
        for (int i = 0; i < f1SkrList.length; i++) 'f1Skr_$i': f1SkrList[i]
      };

      // Insert all data at once
      await box.putAll(f1SkrMap);

      print("F1Skr data inserted into Hive.");
    } else {
      print("F1Skr data already exists.");
    }
  }

  Future<void> initializeNnovssps() async {
    var box = await Hive.openBox<nnovssps>('nnovsspsBox');

    final String response =
        await rootBundle.loadString('assets/N-NovsSpS.json');
    final List<dynamic> data = json.decode(response);

    List<nnovssps> nnovsspsList = nnovssps.fromJsonList(data);

    if (box.isEmpty) {
      // Create a map to use with putAll
      Map<String, nnovssps> nnovsspsMap = {
        for (int i = 0; i < nnovsspsList.length; i++)
          'nnovssps_$i': nnovsspsList[i]
      };

      // Insert all data at once
      await box.putAll(nnovsspsMap);

      print("nnovssps data inserted into Hive.");
    } else {
      print("nnovssps data already exists.");
    }
  }

  Future<void> initializeRodPumpData() async {
    try {
      var box = await Hive.openBox<RodPumpData>('RodPumpDataBox');

      // Check if the data is already inserted
      if (box.isEmpty) {
        // Load JSON data from the file
        final String response =
            await rootBundle.loadString('assets/RodandPumpData.json');
        final List<dynamic> data = json.decode(response);

        // Convert JSON data to a list of RodPumpData objects
        List<RodPumpData> rodPumpDataList = RodPumpData.fromJsonList(data);

        // Create a map to use with putAll
        Map<String, RodPumpData> rodPumpDataMap = {
          for (int i = 0; i < rodPumpDataList.length; i++)
            'rodPumpData_$i': rodPumpDataList[i]
        };

        // Insert all data at once
        await box.putAll(rodPumpDataMap);

        print("RodPumpData inserted into Hive.");
      } else {
        print("RodPumpData already exists.");
      }
    } catch (error) {
      print("Error initializing RodPumpData: $error");
    }
  }

  Future<void> initializeSRData() async {
    var box = await Hive.openBox<SRData>('SRDataBox');
    // await box.clear();

    // Load the JSON file from the assets
    final String response = await rootBundle.loadString('assets/SRData.json');
    final data = json.decode(response);

    List<String> rodSizes = List<String>.from(data['rodSize']);
    List<double> metalAreas = List<double>.from(data['metalArea']);
    List<double> rodWeights = List<double>.from(data['rodWeight']);
    List<double> elasticConstants = List<double>.from(data['elasticConstant']);

    // Insert data only if the box is empty
    if (box.isEmpty) {
      // Find the maximum length among the four lists
      int maxLength = [
        rodSizes.length,
        metalAreas.length,
        rodWeights.length,
        elasticConstants.length
      ].reduce((a, b) => a > b ? a : b);

      // Create a list of SRData objects
      List<SRData> srDataList = List.generate(maxLength, (i) {
        return SRData(
          rodSize: i < rodSizes.length ? rodSizes[i] : "",
          metalArea: i < metalAreas.length ? metalAreas[i] : 0.0,
          rodWeight: i < rodWeights.length ? rodWeights[i] : 0.0,
          elasticConstant:
              i < elasticConstants.length ? elasticConstants[i] : 0.0,
        );
      });

      // Create a map to use with putAll
      Map<String, SRData> srDataMap = {
        for (int i = 0; i < srDataList.length; i++) 'srData_$i': srDataList[i]
      };

      // Insert all data at once
      await box.putAll(srDataMap);

      print("SRData inserted into Hive.");
    } else {
      print("SRData already exists.");
    }
  }

  Future<void> initializeSRAPI() async {
    var box = await Hive.openBox<SR_API>('SRAPIBox');
    // await box.clear();

    // Load the rodNo values from the JSON file
    final String response =
        await rootBundle.loadString('assets/SuckerRodAPI.json');
    final List<dynamic> data = json.decode(response);

    // Extract rodNo values from JSON
    List<int> rodNos = data.map((item) => item['rodNo'] as int).toList();

    // Insert rodNo values into Hive if the box is empty
    if (box.isEmpty) {
      // Create a list of SR_API objects
      List<SR_API> srApiList =
          rodNos.map((rodNo) => SR_API(rodNo: rodNo)).toList();

      // Create a map to use with putAll
      Map<String, SR_API> srApiMap = {
        for (int i = 0; i < srApiList.length; i++) 'srAPI_$i': srApiList[i]
      };

      // Insert all data at once
      await box.putAll(srApiMap);

      print("SRAPI inserted into Hive.");
    } else {
      print("SRAPI already exists.");
    }
  }

  Future<void> initializeAPI() async {
    var box = await Hive.openBox<API>('apiBox');

    // Load the JSON file from the assets
    final String response = await rootBundle.loadString('assets/API.json');
    final data = json.decode(response);

    List<String> tubingSize = List<String>.from(data['tubingSize']);
    List<double> outsideDiameter = List<double>.from(data['outsideDiameter']
        .map((x) => (x is String) ? double.tryParse(x) : x));
    List<double> insideDiameter = List<double>.from(data['insideDiameter']
        .map((x) => (x is String) ? double.tryParse(x) : x));
    List<double> metalArea = List<double>.from(
        data['metalArea'].map((x) => (x is String) ? double.tryParse(x) : x));
    List<double> elasticConstant = List<double>.from(data['elasticConstant']
        .map((x) => (x is String) ? double.tryParse(x) : x));

    // Clear the box if needed
    // await box.clear();

    // Insert data only if the box is empty
    if (box.isEmpty) {
      // Find the maximum length among the five lists
      int maxLength = [
        tubingSize.length,
        outsideDiameter.length,
        insideDiameter.length,
        metalArea.length,
        elasticConstant.length
      ].reduce((a, b) => a > b ? a : b);

      // Create a list of API objects
      List<API> apiList = List.generate(maxLength, (i) {
        return API(
          tubingSize: i < tubingSize.length ? tubingSize[i] : "",
          outsideDiameter:
              i < outsideDiameter.length ? outsideDiameter[i] : 0.0,
          insideDiameter: i < insideDiameter.length ? insideDiameter[i] : 0.0,
          metalArea: i < metalArea.length ? metalArea[i] : 0.0,
          elasticConstant:
              i < elasticConstant.length ? elasticConstant[i] : 0.0,
        );
      });

      // Create a map to use with putAll
      Map<String, API> apiMap = {
        for (int i = 0; i < apiList.length; i++) 'api_$i': apiList[i]
      };

      // Insert all data at once
      await box.putAll(apiMap);

      print("API data inserted into Hive.");
    } else {
      print("API data already exists.");
    }
  }

  Future<void> initializePUType() async {
    var box = await Hive.openBox<PUType>('puTypes');

    // Load the JSON file from the assets
    final String response = await rootBundle.loadString('assets/PUType.json');
    final data = json.decode(response);

    List<String> conventionalData = List<String>.from(data['conventionalData']);
    List<String> markIIData = List<String>.from(data['markII']);
    List<String> airBalanceData = List<String>.from(data['airBalance']);

    // Clear the box if you want to refresh data
    // await box.clear();

    if (box.isEmpty) {
      // Determine the maximum length of the three lists
      int maxLength = [
        conventionalData.length,
        markIIData.length,
        airBalanceData.length
      ].reduce((a, b) => a > b ? a : b);

      // Create a list of PUType objects
      List<PUType> puTypes = List.generate(maxLength, (i) {
        String conventional =
            i < conventionalData.length ? conventionalData[i] : "";
        String markII = i < markIIData.length ? markIIData[i] : "";
        String airBalance = i < airBalanceData.length ? airBalanceData[i] : "";
        return PUType(
          conventional: conventional,
          markII: markII,
          airBalance: airBalance,
        );
      });

      // Create a map to use with putAll
      Map<String, PUType> puTypeMap = {
        for (int i = 0; i < puTypes.length; i++) 'pu_$i': puTypes[i]
      };

      // Insert all data at once
      await box.putAll(puTypeMap);

      print("Data inserted into Hive.");
    } else {
      print("Data already exists.");
    }
  }

  Future<void> initializeSRGrade() async {
    // Open the box for SRGrade
    var box = await Hive.openBox<SRGrade>('SRGrades');

    // Load the JSON file from the assets
    final String response = await rootBundle.loadString('assets/SRGrade.json');
    final data = json.decode(response);

    // Extract the fields from the JSON data
    List<String> apiGrade = List<String>.from(data['apiGrade']);
    List<String> yieldStrength = List<String>.from(data['yieldStrength']);
    List<String> tensileStrength = List<String>.from(data['tensileStrength']);

    // Clear the box if you want to refresh data
    // await box.clear();

    // Insert data only if the box is empty
    if (box.isEmpty) {
      // Find the maximum length among the three lists
      int maxLength = [
        apiGrade.length,
        yieldStrength.length,
        tensileStrength.length
      ].reduce((a, b) => a > b ? a : b);

      // Create a list of SRGrade objects
      List<SRGrade> srGrades = List.generate(maxLength, (i) {
        return SRGrade(
          apiGrade: i < apiGrade.length ? apiGrade[i] : "",
          yieldStrength: i < yieldStrength.length ? yieldStrength[i] : "",
          tensileStrength: i < tensileStrength.length ? tensileStrength[i] : "",
        );
      });

      // Create a map to use with putAll
      Map<String, SRGrade> srGradeMap = {
        for (int i = 0; i < srGrades.length; i++) 'sr_$i': srGrades[i]
      };

      // Insert all data at once
      await box.putAll(srGradeMap);

      print("SRGrade data inserted into Hive.");
    } else {
      print("SRGrade data already exists.");
    }
  }

  Future<void> initializePumpConstant() async {
    var box = await Hive.openBox<PumpConstant>('PumpConstants');

    // await box.clear();
    if (box.isEmpty) {
      // Load the JSON file from the assets
      final String response =
          await rootBundle.loadString('assets/PumpConstant.json');
      final data = json.decode(response);

      List<String> plungerDiameter = List<String>.from(data['plungerDiameter']);
      List<String> plungerArea = List<String>.from(data['plungerArea']);
      List<String> fluidLoadFactor = List<String>.from(data['fluidLoadFactor']);
      List<String> pumpFactor = List<String>.from(data['pumpFactor']);

      // Find the maximum length among the four lists
      int maxLength = [
        plungerDiameter.length,
        plungerArea.length,
        fluidLoadFactor.length,
        pumpFactor.length
      ].reduce((a, b) => a > b ? a : b);

      // Create a list of PumpConstant objects
      List<PumpConstant> pumpConstants = List.generate(maxLength, (i) {
        return PumpConstant(
          plungerDiameter: i < plungerDiameter.length ? plungerDiameter[i] : "",
          plungerArea: i < plungerArea.length ? plungerArea[i] : "",
          fluidLoadFactor: i < fluidLoadFactor.length ? fluidLoadFactor[i] : "",
          pumpFactor: i < pumpFactor.length ? pumpFactor[i] : "",
        );
      });

      // Create a map to use with putAll
      Map<String, PumpConstant> pumpConstantMap = {
        for (int i = 0; i < pumpConstants.length; i++)
          'pump_$i': pumpConstants[i]
      };

      // Insert all data at once
      await box.putAll(pumpConstantMap);

      print("PumpConstant data inserted into Hive.");
    } else {
      print("PumpConstant data already exists.");
    }
  }

  double fluidLevel(double pumpDepth, double submergence) {
    final fluidLevel = pumpDepth - submergence;
    return fluidLevel;
  }

  Future<double?> RodWeight(String rodNo, String plungerDiameter) async {
    var box = await Hive.openBox<RodPumpData>('RodPumpDataBox');

    // Iterate through all entries in the box
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == plungerDiameter) {
        print(data.rodWeight);
        return data.rodWeight;
      }
    }

// Second pass: Check for 'All' match
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == 'All') {
        print(data.rodWeight);
        return data.rodWeight;
      }
    }

// If no match is found, return a default value or handle accordingly
    return null; // or any other default value or action
  }

  Future<double?> getElasticConstant(
      String rodNo, String plungerDiameter) async {
    var box = await Hive.openBox<RodPumpData>('RodPumpDataBox');

    // Iterate through all entries in the box
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == plungerDiameter) {
        print(data.elasticConstant);
        return data.elasticConstant;
      }
    }

// Second pass: Check for 'All' match
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == 'All') {
        print(data.elasticConstant);
        return data.elasticConstant;
      }
    }

// If no match is found, return a default value or handle accordingly
    return null; // or any other default value or action
  }

  Future<double?> getElasticConstantByTubingSize(String tubingSize) async {
    var box = await Hive.openBox<API>('apiBox');

    // Iterate through all entries in the box
    for (int i = 0; i < box.length; i++) {
      API? data = box.get('api_$i');
      if (data != null) {
        if (data.tubingSize == tubingSize) {
          return data.elasticConstant;
        }
      }
    }

    // Return null if no matching entry is found
    return null;
  }

  Future<double?> getFrequencyFactor(
      String rodNo, String plungerDiameter) async {
    var box = await Hive.openBox<RodPumpData>('RodPumpDataBox');

    // Iterate through all entries in the box
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == plungerDiameter) {
        print(data.frequencyFactor);
        return data.frequencyFactor;
      }
    }

// Second pass: Check for 'All' match
    for (int i = 0; i < box.length; i++) {
      RodPumpData? data = box.getAt(i);
      if (data != null &&
          data.rodNo == rodNo &&
          data.plungerDiameter == 'All') {
        print(data.frequencyFactor);
        return data.frequencyFactor;
      }
    }

// If no match is found, return a default value or handle accordingly
    return null; // or any other default value or action
  }

  double differentialFluidLoad(
      double fluidSG, double plungerDiameter, double fluidLevel) {
    final differentialFluidLoad =
        0.34 * fluidSG * pow(plungerDiameter, 2) * fluidLevel;
    return differentialFluidLoad;
  }

  double totalRodsElasticConstant(double rodElasticConstant, double pumpDepth) {
    final totalRodsElasticConstant = rodElasticConstant * pumpDepth;
    return totalRodsElasticConstant;
  }

  double loadToStretchTotalRodsSkr(
      double strokeLength, double totalRodsElasticConstant) {
    final loadToStretchTotalRodsSkr = strokeLength / totalRodsElasticConstant;
    return loadToStretchTotalRodsSkr;
  }

  double loadToStretchTotalRodsFoSkr(
      double differentialFluidLoad, double loadToStretchTotalRodsSkr) {
    final loadToStretchTotalRodsFoSkr =
        differentialFluidLoad / loadToStretchTotalRodsSkr;
    return loadToStretchTotalRodsFoSkr;
  }

  double loadToStretchTotalRodsNNo(double pumpingSpeed, double pumpDepth) {
    final loadToStretchTotalRodsNNo = pumpingSpeed * pumpDepth / 245000;
    return loadToStretchTotalRodsNNo;
  }

  double loadToStretchTotalRodsNNoI(
      double loadToStretchTotalRodsNNo, double frequencyFactor) {
    final loadToStretchTotalRodsNNoI =
        loadToStretchTotalRodsNNo / frequencyFactor;
    return loadToStretchTotalRodsNNoI;
  }

  double unanchoredTubingElasticConstant(
      double tubingElasticConstant, double pumpDepth, double anchored) {
    final unanchoredTubingElasticConstant =
        tubingElasticConstant * pumpDepth * anchored;
    return unanchoredTubingElasticConstant;
  }

  double bottomHolePumpStroke(
      double strokeLength,
      double differentialFluidLoad,
      double unanchoredTubingElasticConstant,
      double unanchoredTubingElasticConstantSps) {
    final bottomHolePumpStroke =
        (unanchoredTubingElasticConstantSps * strokeLength) -
            (differentialFluidLoad * unanchoredTubingElasticConstant);

    return bottomHolePumpStroke;
  }

  double pumpDisplacement(double bottomHolePumpStroke, double pumpingSpeed,
      double plungerDiameter) {
    final pumpDisplacement =
        0.1166 * bottomHolePumpStroke * pumpingSpeed * pow(plungerDiameter, 2);
    return pumpDisplacement;
  }

  double totalRodsWeightInAir(double rodSpecificWeight, double pumpDepth) {
    final totalRodsWeightInAir = rodSpecificWeight * pumpDepth;
    return totalRodsWeightInAir;
  }

  double bouyancyFactor(double fluidSG) {
    final bouyancyFactor = 1 - (0.128 * fluidSG);
    return bouyancyFactor;
  }

  double totalRodsWeightInFluid(
      double totalRodsWeightInAir, double bouyancyFactor) {
    final totalRodsWeightInFluid = totalRodsWeightInAir * bouyancyFactor;
    return totalRodsWeightInFluid;
  }

  double totalRodsWeightInFluidWrfSkr(
      double loadToStretchTotalRodsSkr, double totalRodsWeightInFluid) {
    final totalRodsWeightInFluidWrfSkr =
        totalRodsWeightInFluid / loadToStretchTotalRodsSkr;
    return totalRodsWeightInFluidWrfSkr;
  }

  double totalRodsWeightInFluidTaStar(double z) {
    final totalRodsWeightInFluidTaStar = z / 100;
    return totalRodsWeightInFluidTaStar;
  }

  double adjustment(double totalRodsWeightInFluidWrfSkr) {
    final adjustment = (totalRodsWeightInFluidWrfSkr - 0.3) / 0.1;
    return adjustment;
  }

  double adjustmentTa(double adjustment, double totalRodsWeightInFluidTaStar) {
    final adjustmentTa = 1 + (totalRodsWeightInFluidTaStar * adjustment);
    return adjustmentTa;
  }

  double polishedRodHorsepower(
      double totalRodsWeightInFluidF3Skr,
      double loadToStretchTotalRodsSkr,
      double strokeLength,
      double pumpingSpeed) {
    final polishedRodHorsepower = totalRodsWeightInFluidF3Skr *
        loadToStretchTotalRodsSkr *
        strokeLength *
        pumpingSpeed *
        2.35 *
        1e-6;
    return polishedRodHorsepower;
  }

  double maximumStress(double peakPolishedRodLoad, double metalArea) {
    final maximumStress = peakPolishedRodLoad / metalArea;
    return maximumStress;
  }

  double minimumStress(double minimumPolishedRodLoad, double metalArea) {
    final minimumStress = minimumPolishedRodLoad / metalArea;
    return minimumStress;
  }

  double primeMoverHPNemaC(
      double plungerDiameter,
      double pumpingSpeed,
      double strokeLength,
      double fluidSG,
      double pumpDepth,
      double totalRodsWeightInFluid) {
    const double constant1 = 7.36 * 1e-6; // 7.36 * 10^-6
    const double constant2 = 6.31 * 1e-7; // 6.31 * 10^-7
    const double factor = 0.94; // the denominator value

    double part1 = constant1 *
        0.1166 *
        pow(plungerDiameter, 2) *
        pumpingSpeed *
        strokeLength *
        fluidSG *
        pumpDepth;

    double part2 =
        constant2 * totalRodsWeightInFluid * strokeLength * plungerDiameter;

    return (part1 + part2) * 1.897 / factor;
  }

  double primeMoverHPNemaD(
      double plungerDiameter,
      double pumpingSpeed,
      double strokeLength,
      double fluidSG,
      double pumpDepth,
      double totalRodsWeightInFluid) {
    const double constant1 = 7.36 * 1e-6; // 7.36 * 10^-6
    const double constant2 = 6.31 * 1e-7; // 6.31 * 10^-7
    const double factor = 0.94; // the denominator value

    double part1 = constant1 *
        0.1166 *
        pow(plungerDiameter, 2) *
        pumpingSpeed *
        strokeLength *
        fluidSG *
        pumpDepth;

    double part2 =
        constant2 * totalRodsWeightInFluid * strokeLength * plungerDiameter;

    return (part1 + part2) * 1.375 / factor;
  }

  double brakeHPNemaC(double pumpDisplacement, double pumpDepth,
      double pumpingUnitGeometryValue) {
    const double divisor = 45000;
    return (pumpDisplacement * pumpDepth / divisor) * pumpingUnitGeometryValue;
  }

  double brakeHPNemaD(double pumpDisplacement, double pumpDepth,
      double pumpingUnitGeometryValue) {
    const double divisor = 56000;
    return (pumpDisplacement * pumpDepth / divisor) * pumpingUnitGeometryValue;
  }

  double pumpCapacity(double pumpDisplacement, double pumpEfficiency) {
    return pumpDisplacement * (pumpEfficiency / 100);
  }

  double pumpingUnitTorque(double peakCrankTorque, double torqueRating) {
    return peakCrankTorque / torqueRating;
  }

  double pumpingUnitLoad(double peakPolishedRodLoad, double loadRating) {
    return peakPolishedRodLoad / loadRating;
  }

  double rodStress(double maximumStress, double maximumAllowableStress) {
    return maximumStress / maximumAllowableStress;
  }

  Future<double?> interpolateYUsingSpS(
      double x, double z, List<nnovssps> dataList) async {
    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => a.nNo.compareTo(b.nNo));

    // Initialize variables to store the interpolation points for x as double
    double? x1Value;
    double? x2Value;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x && (x1Value == null || currentNNo > x1Value)) {
        x1Value = currentNNo;
      }
      if (currentNNo >= x && (x2Value == null || currentNNo < x2Value)) {
        x2Value = currentNNo;
      }
      // Break the loop if both points are found
      if (x1Value != null && x2Value != null) break;
    }

    if (x1Value == null || x2Value == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Initialize variables to store the interpolation points for z
    double? z1Value;
    double? z2Value;

    // Find z1 and z2
    List<double> spSValues = [0.05, 0.1, 0.2, 0.3, 0.4, 0.5];
    for (double spS in spSValues) {
      if (spS <= z && (z1Value == null || spS > z1Value)) {
        z1Value = spS;
      }
      if (spS >= z && (z2Value == null || spS < z2Value)) {
        z2Value = spS;
      }
      if (z1Value != null && z2Value != null) break;
    }

    if (z1Value == null || z2Value == null) {
      print("Suitable bounds for z not found.");
      return null;
    }

    // Retrieve the values for interpolation
    double a1, a2, b1, b2;
    if (z1Value == 0.05) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_05");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_05");
    } else if (z1Value == 0.1) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_1");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_1");
    } else if (z1Value == 0.2) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_2");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_2");
    } else if (z1Value == 0.3) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_3");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_3");
    } else if (z1Value == 0.4) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_4");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_4");
    } else if (z1Value == 0.5) {
      a1 = getSpSValueForNNo(dataList, x1Value, "spS0_5");
      a2 = getSpSValueForNNo(dataList, x2Value, "spS0_5");
    } else {
      return null;
    }

    if (z2Value == 0.05) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_05");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_05");
    } else if (z2Value == 0.1) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_1");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_1");
    } else if (z2Value == 0.2) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_2");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_2");
    } else if (z2Value == 0.3) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_3");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_3");
    } else if (z2Value == 0.4) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_4");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_4");
    } else if (z2Value == 0.5) {
      b1 = getSpSValueForNNo(dataList, x1Value, "spS0_5");
      b2 = getSpSValueForNNo(dataList, x2Value, "spS0_5");
    } else {
      return null;
    }

    // Calculate y1 and y2 based on the given formula
    double y1 = a2 - (x2Value - x) * (a2 - a1) / (x2Value - x1Value);
    double y2 = b2 - (x2Value - x) * (b2 - b1) / (x2Value - x1Value);

    // Calculate y based on y1 and y2
    double y = y2 - (y2 - y1) * (z2Value - z) / (z2Value - z1Value);

    return y;
  }

  double getSpSValueForNNo(
      List<nnovssps> dataList, double nNoValue, String spSField) {
    for (var data in dataList) {
      if (double.parse(data.nNo) == nNoValue) {
        switch (spSField) {
          case "spS0_05":
            return data.spS0_05;
          case "spS0_1":
            return data.spS0_1;
          case "spS0_2":
            return data.spS0_2;
          case "spS0_3":
            return data.spS0_3;
          case "spS0_4":
            return data.spS0_4;
          case "spS0_5":
            return data.spS0_5;
          default:
            throw ArgumentError("Invalid spSField");
        }
      }
    }
    throw ArgumentError("nNoValue not found in dataList");
  }

  Future<double?> interpolateYUsingF1Skr(
      double x, double z, List<F1SkrModel> dataList) async {
    // Ensure the dataList is not empty
    if (dataList.isEmpty) {
      print("DataList is empty.");
      return null;
    }

    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => a.nNo.compareTo(b.nNo));

    // Initialize variables to store the interpolation points for x as double
    double? x1Value;
    double? x2Value;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x && (x1Value == null || currentNNo > x1Value)) {
        x1Value = currentNNo;
      }
      if (currentNNo >= x && (x2Value == null || currentNNo < x2Value)) {
        x2Value = currentNNo;
      }
      // Break the loop if both points are found
      if (x1Value != null && x2Value != null) break;
    }

    if (x1Value == null || x2Value == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Initialize variables to store the interpolation points for z
    double? z1Value;
    double? z2Value;

    // Find z1 and z2
    List<double> spSValues = [0.1, 0.2, 0.3, 0.4, 0.5];
    // Initialize z1Value to 0.1 if z is less than the smallest value in spSValues

    for (double spS in spSValues) {
      if (spS <= z && (z1Value == null || spS > z1Value)) {
        z1Value = spS;
      }
    }

// Ensure z1Value is set to 0.1 if z is less than the smallest value in spSValues
    if (z < spSValues.first) {
      z1Value = 0.1;
    }

// Find the index of z1Value and set z2Value to the next index
    if (z1Value != null) {
      int index = spSValues.indexOf(z1Value);
      if (index != -1 && index < spSValues.length - 1) {
        z2Value = spSValues[index + 1];
      }
    }

    if (z1Value == null || z2Value == null) {
      print("Suitable bounds for z not found.");
      return null;
    }

    // Retrieve the values for interpolation
    try {
      double a1 = getF1skrValueForNNo(dataList, x1Value, z1Value);
      double a2 = getF1skrValueForNNo(dataList, x2Value, z1Value);

      double b1 = getF1skrValueForNNo(dataList, x1Value, z2Value);
      double b2 = getF1skrValueForNNo(dataList, x2Value, z2Value);

      // Calculate y1 and y2 based on the given formula
      double y1 = a2 - (x2Value - x) * (a2 - a1) / (x2Value - x1Value);
      double y2 = b2 - (x2Value - x) * (b2 - b1) / (x2Value - x1Value);

      // Calculate y based on y1 and y2
      double y = y2 - (y2 - y1) * (z2Value - z) / (z2Value - z1Value);

      return y;
    } catch (e) {
      print("Error during interpolation: $e");
      return null;
    }
  }

  double getF1skrValueForNNo(
      List<F1SkrModel> dataList, double nNoValue, double spSValue) {
    for (var data in dataList) {
      if (double.parse(data.nNo) == nNoValue) {
        if (spSValue == 0.1) {
          return data.f1Skr0_1;
        } else if (spSValue == 0.2) {
          return data.f1Skr0_2;
        } else if (spSValue == 0.3) {
          return data.f1Skr0_3;
        } else if (spSValue == 0.4) {
          return data.f1Skr0_4;
        } else if (spSValue == 0.5) {
          return data.f1Skr0_5;
        } else {
          throw ArgumentError("Invalid spSValue");
        }
      }
    }
    throw ArgumentError("nNoValue not found in dataList");
  }

  Future<double?> interpolateYUsingF2Skr(
      double x, double z, List<F2SkrModel> dataList) async {
    // Ensure the dataList is not empty
    if (dataList.isEmpty) {
      print("DataList is empty.");
      return null;
    }

    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => a.nNo.compareTo(b.nNo));

    // Initialize variables to store the interpolation points for x as double
    double? x1Value;
    double? x2Value;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x && (x1Value == null || currentNNo > x1Value)) {
        x1Value = currentNNo;
      }
      if (currentNNo >= x && (x2Value == null || currentNNo < x2Value)) {
        x2Value = currentNNo;
      }
      // Break the loop if both points are found
      if (x1Value != null && x2Value != null) break;
    }

    if (x1Value == null || x2Value == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Initialize variables to store the interpolation points for z
    double? z1Value;
    double? z2Value;

    // Find z1 and z2
    List<double> spSValues = [0.1, 0.2, 0.3, 0.4, 0.5];
    // Initialize z1Value to 0.1 if z is less than the smallest value in spSValues
    for (double spS in spSValues) {
      if (spS <= z && (z1Value == null || spS > z1Value)) {
        z1Value = spS;
      }
    }

// Ensure z1Value is set to 0.1 if z is less than the smallest value in spSValues
    if (z < spSValues.first) {
      z1Value = 0.1;
    }

// Find the index of z1Value and set z2Value to the next index
    if (z1Value != null) {
      int index = spSValues.indexOf(z1Value);
      if (index != -1 && index < spSValues.length - 1) {
        z2Value = spSValues[index + 1];
      }
    }

    if (z1Value == null || z2Value == null) {
      print("Suitable bounds for z not found.");
      return null;
    }

    // Retrieve the values for interpolation
    double a1 = getF2skrValueForNNo(dataList, x1Value, z1Value);
    double a2 = getF2skrValueForNNo(dataList, x2Value, z1Value);

    double b1 = getF2skrValueForNNo(dataList, x1Value, z2Value);
    double b2 = getF2skrValueForNNo(dataList, x2Value, z2Value);

    // Calculate y1 and y2 based on the given formula
    double y1 = a2 - (x2Value - x) * (a2 - a1) / (x2Value - x1Value);
    double y2 = b2 - (x2Value - x) * (b2 - b1) / (x2Value - x1Value);

    // Calculate y based on y1 and y2
    double y = y2 - (y2 - y1) * (z2Value - z) / (z2Value - z1Value);

    return y;
  }

  double getF2skrValueForNNo(
      List<F2SkrModel> dataList, double nNoValue, double spSValue) {
    for (var data in dataList) {
      if (double.parse(data.nNo) == nNoValue) {
        if (spSValue == 0.1) {
          return data.f2Skr0_1;
        } else if (spSValue == 0.2) {
          return data.f2Skr0_2;
        } else if (spSValue == 0.3) {
          return data.f2Skr0_3;
        } else if (spSValue == 0.4) {
          return data.f2Skr0_4;
        } else if (spSValue == 0.5) {
          return data.f2Skr0_5;
        } else {
          throw ArgumentError("Invalid spSValue");
        }
      }
    }
    throw ArgumentError("nNoValue not found in dataList");
  }

  Future<double?> interpolateYUsingF3Skr(
      double x, double z, List<F3SkrModel> dataList) async {
    // Ensure the dataList is not empty
    if (dataList.isEmpty) {
      print("DataList is empty.");
      return null;
    }

    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => a.nNo.compareTo(b.nNo));

    // Initialize variables to store the interpolation points for x as double
    double? x1Value;
    double? x2Value;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x && (x1Value == null || currentNNo > x1Value)) {
        x1Value = currentNNo;
      }
      if (currentNNo >= x && (x2Value == null || currentNNo < x2Value)) {
        x2Value = currentNNo;
      }
      // Break the loop if both points are found
      if (x1Value != null && x2Value != null) break;
    }

    if (x1Value == null || x2Value == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Initialize variables to store the interpolation points for z
    double? z1Value;
    double? z2Value;

    // Find z1 and z2
    List<double> spSValues = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6];
    // Initialize z1Value to 0.1 if z is less than the smallest value in spSValues
    for (double spS in spSValues) {
      if (spS <= z && (z1Value == null || spS > z1Value)) {
        z1Value = spS;
      }
    }

// Ensure z1Value is set to 0.1 if z is less than the smallest value in spSValues
    if (z < spSValues.first) {
      z1Value = 0.1;
    }

// Find the index of z1Value and set z2Value to the next index
    if (z1Value != null) {
      int index = spSValues.indexOf(z1Value);
      if (index != -1 && index < spSValues.length - 1) {
        z2Value = spSValues[index + 1];
      }
    }

    if (z1Value == null || z2Value == null) {
      print("Suitable bounds for z not found.");
      return null;
    }

    // Retrieve the values for interpolation
    double a1 = getF3skrValueForNNo(dataList, x1Value, z1Value);
    double a2 = getF3skrValueForNNo(dataList, x2Value, z1Value);

    double b1 = getF3skrValueForNNo(dataList, x1Value, z2Value);
    double b2 = getF3skrValueForNNo(dataList, x2Value, z2Value);

    // Calculate y1 and y2 based on the given formula
    double y1 = a2 - (x2Value - x) * (a2 - a1) / (x2Value - x1Value);
    double y2 = b2 - (x2Value - x) * (b2 - b1) / (x2Value - x1Value);

    // Calculate y based on y1 and y2
    double y = y2 - (y2 - y1) * (z2Value - z) / (z2Value - z1Value);

    return y;
  }

  double getF3skrValueForNNo(
      List<F3SkrModel> dataList, double nNoValue, double spSValue) {
    for (var data in dataList) {
      if (double.parse(data.nNo) == nNoValue) {
        if (spSValue == 0.1) {
          return data.f3Skr0_1;
        } else if (spSValue == 0.2) {
          return data.f3Skr0_2;
        } else if (spSValue == 0.3) {
          return data.f3Skr0_3;
        } else if (spSValue == 0.4) {
          return data.f3Skr0_4;
        } else if (spSValue == 0.5) {
          return data.f3Skr0_5;
        } else if (spSValue == 0.6) {
          return data.f3Skr0_6;
        } else {
          throw ArgumentError("Invalid spSValue");
        }
      }
    }
    throw ArgumentError("nNoValue not found in dataList");
  }

  Future<double?> interpolateYUsingTwoTSkr(
      double x, double z, List<TwoTSkrModel> dataList) async {
    // Ensure the dataList is not empty
    if (dataList.isEmpty) {
      print("DataList is empty.");
      return null;
    }

    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => a.nNo.compareTo(b.nNo));

    // Initialize variables to store the interpolation points for x as double
    double? x1Value;
    double? x2Value;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x && (x1Value == null || currentNNo > x1Value)) {
        x1Value = currentNNo;
      }
      if (currentNNo >= x && (x2Value == null || currentNNo < x2Value)) {
        x2Value = currentNNo;
      }
      // Break the loop if both points are found
      if (x1Value != null && x2Value != null) break;
    }

    if (x1Value == null || x2Value == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Initialize variables to store the interpolation points for z
    double? z1Value;
    double? z2Value;

    // Find z1 and z2
    List<double> spSValues = [0.1, 0.2, 0.3, 0.4, 0.5];
    // Initialize z1Value to 0.1 if z is less than the smallest value in spSValues
    for (double spS in spSValues) {
      if (spS <= z && (z1Value == null || spS > z1Value)) {
        z1Value = spS;
      }
    }

// Ensure z1Value is set to 0.1 if z is less than the smallest value in spSValues
    if (z < spSValues.first) {
      z1Value = 0.1;
    }

// Find the index of z1Value and set z2Value to the next index
    if (z1Value != null) {
      int index = spSValues.indexOf(z1Value);
      if (index != -1 && index < spSValues.length - 1) {
        z2Value = spSValues[index + 1];
      }
    }

    if (z1Value == null || z2Value == null) {
      print("Suitable bounds for z not found.");
      return null;
    }

    // Retrieve the values for interpolation
    double a1 = getTwoTSkrValueForNNo(dataList, x1Value, z1Value);
    double a2 = getTwoTSkrValueForNNo(dataList, x2Value, z1Value);

    double b1 = getTwoTSkrValueForNNo(dataList, x1Value, z2Value);
    double b2 = getTwoTSkrValueForNNo(dataList, x2Value, z2Value);

    // Calculate y1 and y2 based on the given formula
    double y1 = a2 - (x2Value - x) * (a2 - a1) / (x2Value - x1Value);
    double y2 = b2 - (x2Value - x) * (b2 - b1) / (x2Value - x1Value);

    // Calculate y based on y1 and y2
    double y = y2 - (y2 - y1) * (z2Value - z) / (z2Value - z1Value);

    return y;
  }

  double getTwoTSkrValueForNNo(
      List<TwoTSkrModel> dataList, double nNoValue, double spSValue) {
    for (var data in dataList) {
      if (double.parse(data.nNo) == nNoValue) {
        if (spSValue == 0.1) {
          return data.tSkr0_1;
        } else if (spSValue == 0.2) {
          return data.tSkr0_2;
        } else if (spSValue == 0.3) {
          return data.tSkr0_3;
        } else if (spSValue == 0.4) {
          return data.tSkr0_4;
        } else if (spSValue == 0.5) {
          return data.tSkr0_5;
        } else {
          throw ArgumentError("Invalid spSValue");
        }
      }
    }
    throw ArgumentError("nNoValue not found in dataList");
  }

  double? interpolateUsingF0Skr(double x, double y, List<F0SkrModel> dataList) {
    // Ensure the dataList is not empty
    if (dataList.isEmpty) {
      print("DataList is empty.");
      return null;
    }

    // Sort dataList by nNo to ensure correct order
    dataList.sort((a, b) => double.parse(a.nNo).compareTo(double.parse(b.nNo)));

    // Initialize variables to store the interpolation points for x
    F0SkrModel? x1Row;
    F0SkrModel? x2Row;

    // Find the points for interpolation for x
    for (var data in dataList) {
      double currentNNo = double.parse(data.nNo);
      if (currentNNo <= x &&
          (x1Row == null || currentNNo > double.parse(x1Row.nNo))) {
        x1Row = data;
      }
      if (currentNNo >= x &&
          (x2Row == null || currentNNo < double.parse(x2Row.nNo))) {
        x2Row = data;
      }
      if (x1Row != null && x2Row != null) break;
    }

    if (x1Row == null || x2Row == null) {
      print("Suitable bounds for x not found.");
      return null;
    }

    // Function to get y value from the row
    double getYValue(F0SkrModel row, double y) {
      if (y < row.f0Skr15) {
        return row.f0Skr15;
      } else if (y < row.f0Skr10) {
        return row.f0Skr15;
      } else if (y < row.f0Skr7_5) {
        return row.f0Skr10;
      } else if (y < row.f0Skr5) {
        return row.f0Skr7_5;
      } else if (y < row.f0Skr3) {
        return row.f0Skr5;
      } else if (y < row.f0Skr1_5) {
        return row.f0Skr3;
      } else if (y < row.f0Skr1) {
        return row.f0Skr1_5;
      } else if (y < row.f0Skr0) {
        return row.f0Skr1;
      } else if (y < row.f0Skr_1_75) {
        return row.f0Skr0;
      } else if (y < row.f0Skr_1_75_2) {
        return row.f0Skr_1_75;
      } else if (y < row.f0Skr0_2) {
        return row.f0Skr_1_75_2;
      } else if (y < row.f0Skr1_2) {
        return row.f0Skr0_2;
      } else if (y < row.f0Skr1_5) {
        return row.f0Skr1_2;
      } else {
        return row.f0Skr1_5;
      }
    }

    double getNextYValue(F0SkrModel row, double yValue) {
      if (yValue == row.f0Skr15) return row.f0Skr10;
      if (yValue == row.f0Skr10) return row.f0Skr7_5;
      if (yValue == row.f0Skr7_5) return row.f0Skr5;
      if (yValue == row.f0Skr5) return row.f0Skr3;
      if (yValue == row.f0Skr3) return row.f0Skr1_5;
      if (yValue == row.f0Skr1_5) return row.f0Skr1;
      if (yValue == row.f0Skr1) return row.f0Skr0;
      if (yValue == row.f0Skr0) return row.f0Skr_1_75;
      if (yValue == row.f0Skr_1_75) return row.f0Skr_1_75_2;
      if (yValue == row.f0Skr_1_75_2) return row.f0Skr0_2;
      if (yValue == row.f0Skr0_2) return row.f0Skr1_2;
      return row.f0Skr1_5_2;
    }

    double getCorrespondingYValue(F0SkrModel row, double yValue) {
      if (yValue == x1Row!.f0Skr15) return row.f0Skr15;
      if (yValue == x1Row.f0Skr10) return row.f0Skr10;
      if (yValue == x1Row.f0Skr7_5) return row.f0Skr7_5;
      if (yValue == x1Row.f0Skr5) return row.f0Skr5;
      if (yValue == x1Row.f0Skr3) return row.f0Skr3;
      if (yValue == x1Row.f0Skr1_5) return row.f0Skr1_5;
      if (yValue == x1Row.f0Skr1) return row.f0Skr1;
      if (yValue == x1Row.f0Skr0) return row.f0Skr0;
      if (yValue == x1Row.f0Skr_1_75) return row.f0Skr_1_75;
      if (yValue == x1Row.f0Skr_1_75_2) return row.f0Skr_1_75_2;
      if (yValue == x1Row.f0Skr0_2) return row.f0Skr0_2;
      if (yValue == x1Row.f0Skr1_2) return row.f0Skr1_2;
      return row.f0Skr1_5_2;
    }

    // Get y1.1, y1.2, y2.1, y2.2 values
    double y1_1 = getYValue(x1Row, y);
    double y1_2 = getNextYValue(x1Row, y1_1);
    double y2_1 = getCorrespondingYValue(x2Row, y1_1);
    double y2_2 = getNextYValue(x2Row, y2_1);

    // Function to get z value from the y value
    double getZValue(double yValue) {
      if (yValue == x1Row!.f0Skr15) {
        return 15.0;
      }
      if (yValue == x1Row.f0Skr10) {
        return 10.0;
      }
      if (yValue == x1Row.f0Skr7_5) {
        return 7.5;
      }
      if (yValue == x1Row.f0Skr5) {
        return 5.0;
      }
      if (yValue == x1Row.f0Skr3) {
        return 3.0;
      }
      if (yValue == x1Row.f0Skr1_5) {
        return 1.5;
      }
      if (yValue == x1Row.f0Skr1) {
        return 1.0;
      }
      if (yValue == x1Row.f0Skr0) {
        return 0.0;
      }
      if (yValue == x1Row.f0Skr_1_75) {
        return -1.75;
      }
      if (yValue == x1Row.f0Skr_1_75_2) {
        return -1.75;
      }
      if (yValue == x1Row.f0Skr0_2) {
        return 0.0;
      }
      if (yValue == x1Row.f0Skr1_2) {
        return 1.0;
      }
      return 1.5;
    }

    double getZValuex2(double yValue) {
      if (yValue == x2Row!.f0Skr15) {
        return 15.0;
      }
      if (yValue == x2Row.f0Skr10) {
        return 10.0;
      }
      if (yValue == x2Row.f0Skr7_5) {
        return 7.5;
      }
      if (yValue == x2Row.f0Skr5) {
        return 5.0;
      }
      if (yValue == x2Row.f0Skr3) {
        return 3.0;
      }
      if (yValue == x2Row.f0Skr1_5) {
        return 1.5;
      }
      if (yValue == x2Row.f0Skr1) {
        return 1.0;
      }
      if (yValue == x2Row.f0Skr0) {
        return 0.0;
      }
      if (yValue == x2Row.f0Skr_1_75) {
        return -1.75;
      }
      if (yValue == x2Row.f0Skr_1_75_2) {
        return -1.75;
      }
      if (yValue == x2Row.f0Skr0_2) {
        return 0.0;
      }
      if (yValue == x2Row.f0Skr1_2) {
        return 1.0;
      }
      return 1.5;
    }

    // Get z1, z2, z3, z4 values
    double z1 = getZValue(y1_1);
    double z2 = getZValue(y1_2);
    double z3 = getZValuex2(y2_1);
    double z4 = getZValuex2(y2_2);

    // Calculate r1 and r2
    double r1 = z2 + (y - y1_2) / (y1_1 - y1_2) * (z1 - z2);
    double r2 = z4 + (y - y2_2) / (y2_1 - y2_2) * (z3 - z4);

    return (r1 + r2) / 2;
  }

  double conventionalPPRL(double totalRodsWeightInFluid,
      double totalRodsWeightInFluidF1Skr, double loadToStretchTotalRodsSkr) {
    return totalRodsWeightInFluid +
        (totalRodsWeightInFluidF1Skr * loadToStretchTotalRodsSkr);
  }

  double MarkIIPPRL(double totalRodsWeightInFluid, double differentialFluidLoad,
      double totalRodsWeightInFluidF1Skr, double loadToStretchTotalRodsSkr) {
    return totalRodsWeightInFluid +
        differentialFluidLoad +
        0.75 *
            (totalRodsWeightInFluidF1Skr * loadToStretchTotalRodsSkr -
                differentialFluidLoad);
  }

  double airBalancePPRL(
      double totalRodsWeightInFluid,
      double differentialFluidLoad,
      double totalRodsWeightInFluidF1Skr,
      double loadToStretchTotalRodsSkr) {
    return totalRodsWeightInFluid +
        differentialFluidLoad +
        0.85 *
            (totalRodsWeightInFluidF1Skr * loadToStretchTotalRodsSkr -
                differentialFluidLoad);
  }

  double conventionalMPRL(double totalRodsWeightInFluid,
      double loadToStretchTotalRodsSkr, double totalRodsWeightInFluidF2Skr) {
    return totalRodsWeightInFluid -
        (totalRodsWeightInFluidF2Skr * loadToStretchTotalRodsSkr);
  }

  double markIIMPRL(double MarkIIPPRL, double totalRodsWeightInFluidF1Skr,
      double totalRodsWeightInFluidF2Skr, double loadToStretchTotalRodsSkr) {
    return MarkIIPPRL -
        (totalRodsWeightInFluidF1Skr + totalRodsWeightInFluidF2Skr) *
            loadToStretchTotalRodsSkr;
  }

  double airBalanceMPRL(
      double airBalancePPRL,
      double totalRodsWeightInFluidF1Skr,
      double totalRodsWeightInFluidF2Skr,
      double loadToStretchTotalRodsSkr) {
    return airBalancePPRL -
        (totalRodsWeightInFluidF1Skr + totalRodsWeightInFluidF2Skr) *
            loadToStretchTotalRodsSkr;
  }

  double conventionalPT(
    double totalRodsWeightInFluid2tSkr,
    double loadToStretchTotalRodsSkr,
    double strokeLength,
    double adjustmentTa,
  ) {
    return totalRodsWeightInFluid2tSkr *
        loadToStretchTotalRodsSkr *
        strokeLength /
        2 *
        adjustmentTa;
  }

  double markIIPT(double markIIPPRL, double markIIMPRL, double strokeLength) {
    return (markIIPPRL * 0.93 - markIIMPRL * 1.2) * strokeLength / 4;
  }

  double airBalancePT(
    double totalRodsWeightInFluid2tSkr,
    double strokeLength,
    double totalRodsElasticConstant,
    double totalRodsWeightInFluid,
    double loadToStretchTotalRodsSkr,
    double adjustmentTa,
  ) {
    return 0.96 *
        totalRodsWeightInFluid2tSkr *
        ((pow(strokeLength, 2) / 2)) *
        1 /
        totalRodsElasticConstant *
        (1 +
            ((totalRodsWeightInFluid / loadToStretchTotalRodsSkr) - 0.3) *
                adjustmentTa /
                10);
  }

  double conventionalCBE(
    double differentialFluidLoad,
    double totalRodsWeightInFluid,
  ) {
    return 1.06 * (totalRodsWeightInFluid + differentialFluidLoad / 2);
  }

  double markIICBE(double markIIPPRL, double markIIMPRL) {
    return 1.04 * (markIIPPRL + 1.25 * markIIMPRL) / 2;
  }

  double airBalanceCBE(double airBalancePPRL, double airBalanceMPRL) {
    return 1.06 * (airBalancePPRL + airBalanceMPRL) / 2;
  }
}
