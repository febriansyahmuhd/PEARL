import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
import 'package:pearl/services/srp_formula.dart';

// Custom Body Content Widget
class SRPBody extends StatefulWidget {
  final Function(Map<String, dynamic>) onDataChanged;

  const SRPBody({super.key, required this.onDataChanged});

  @override
  State<SRPBody> createState() => _SRPBodyState();
}

class _SRPBodyState extends State<SRPBody> {
  final TextEditingController _pd = TextEditingController();
  double? resuldPd;
  final TextEditingController _smg = TextEditingController();
  double? resultSmg;
  final TextEditingController _fsg = TextEditingController();
  final TextEditingController _pe = TextEditingController();
  final TextEditingController _sf = TextEditingController();
  final TextEditingController _sl = TextEditingController();
  final TextEditingController _ps = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _wellNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? selectedTubingSize; // Variable to hold the selected tubing size
  String? selectedPlungerDiameter; // Variable to hold the selected value
  String? selectedApiGrade; // Variable to hold the selected API grade
  String? selectedTensileStrength;
  String? selectedPUType; // Variable to hold the selected PU type
  String? selectedPUTypeval; // Variable to hold the selected PU type
  double? selectedElasticConstant; // Variable to hold the selected PU type
  int? selectedRodNo; // Variable to hold the selected PU type
  List<String> tubingSizes = [];
  List<double> outsideDiameters = [];
  List<double> insideDiameters = [];
  List<double> metalAreas = [];
  List<double> elasticConstants = [];
  List<String?> plungerDiameters = [];
  List<String?> pumpFactor = [];
  List<String?> fluidLoadFactor = [];
  List<String?> plungerArea = [];
  List<String?> apiGrades = [];
  List<String?> yieldStrength = [];
  List<String?> tensileStrength = [];
  List<String> puTypes = [];
  List<String?> selectedPUTypeValue = [];
  List<int?> rodNos = [];
  List<double?> metalAreaList = [];
  List<nnovssps> dataListnnovssps = [];
  List<F1SkrModel> dataListF1skr = [];
  List<F2SkrModel> dataListF2skr = [];
  List<F3SkrModel> dataListF3skr = [];
  List<TwoTSkrModel> dataList2tskr = [];
  List<F0SkrModel> dataListf0skr = [];
  List<RodPumpData> rodPumpDataList = [];
  List<SRData> SRDataList = [];
  Map<String, int?> rodValues = {};
  Map<String, int?> multipliedValues = {};
  Map<String, int?> weightValues = {};
  // Map<String, dynamic> dataSave = {};
  var fluidSG = 0.0;
  var tubingSize = 0.0;
  var plungerDiameter = 0.0;
  var suckerRodApi = 0;
  var suckerrodtensileStrength = 0.0;
  var pumpEfficiency = 0.0;
  var serviceFactor = 0.0;
  var torqueRating = 0.0;
  var loadRating = 0.0;
  var strokeLength = 0.0;
  var pumpingSpeed = 0.0;
  var anchoredValue = 0.0;
  var maximumAllowableStress = 0.0;
  var pumpCapacity = 0.0;
  var pumpingUnitTorque = 0.0;
  var pumpingUnitLoad = 0.0;
  var rodStress = 0.0;
  var counterBalance = 0.0;
  var power = 0.0;
  var pumpingUnitGeometryValue = 0.0;
  var tubingElasticConstant = 0.0;
  var rodSpecificWeight = 0.0;
  var rodElasticConstant = 0.0;
  var frequencyFactor = 0.0;
  var peakPolishedRodLoad = 0.0;
  var minimumPolishedRodLoad = 0.0;
  var peakCrankTorque = 0.0;
  var counterWeightRequired = 0.0;
  var totalQuantity = 0;
  var totalLength = 0;
  var totalWeight = 0;
  var metalArea = 0.0;
  bool isResultVisible = false;
  bool _isToggled = false;

  @override
  void initState() {
    super.initState();
    initializeAsyncData();
    // widget.onDataChanged(dataSave);
  }

  void initializeAsyncData() async {
    await fetchTubingSizes();
    await fetchPlungerDiameters();
    await fetchApiGrades();
    await fetchPUTypes();
    await fetchSRApis();
    dataListnnovssps = await getNnovsspsDataList();
    dataListF1skr = await getF1skrDataList();
    dataListF2skr = await getF2skrDataList();
    dataListF3skr = await getF3skrDataList();
    dataList2tskr = await get2tskrDataList();
    dataListf0skr = await getf0skrDataList();
    rodPumpDataList = await getrodPumpDataList();
    SRDataList = await getSRDataList();

    // Notify listeners for _pd and _smg after async operations
    _pd.addListener(_calculateResultPd);
    _smg.addListener(_calculateResultSmg);
  }

  int calculateValue(double d6Value) {
    return ((d6Value - 6) / 25).round();
  }

  double parseMixedFraction(String input) {
    // Remove any extra spaces from the input
    input = input.trim();

    // Check if the input matches the mixed fraction pattern
    List<String> parts = input.split(" ");
    if (parts.length == 2) {
      // Parse the whole number part
      double wholeNumber = double.tryParse(parts[0]) ?? 0.0;

      // Parse the fraction part
      List<String> fractionParts = parts[1].split("/");
      if (fractionParts.length == 2) {
        double numerator = double.tryParse(fractionParts[0]) ?? 0.0;
        double denominator = double.tryParse(fractionParts[1]) ?? 1.0;

        // Return the decimal representation
        return wholeNumber + (numerator / denominator);
      }
    } else if (parts.length == 1) {
      // Handle cases where there's only a fraction or a whole number
      List<String> fractionParts = parts[0].split("/");
      if (fractionParts.length == 2) {
        // Pure fraction without a whole number
        double numerator = double.tryParse(fractionParts[0]) ?? 0.0;
        double denominator = double.tryParse(fractionParts[1]) ?? 1.0;
        return numerator / denominator;
      } else {
        // Just a whole number without fraction
        return double.tryParse(parts[0]) ?? 0.0;
      }
    }
    throw FormatException("Invalid input format: $input");
  }

  Future<List<nnovssps>> getNnovsspsDataList() async {
    var box = await Hive.openBox<nnovssps>('nnovsspsBox');
    return box.values.toList();
  }

  Future<List<F1SkrModel>> getF1skrDataList() async {
    var box = await Hive.openBox<F1SkrModel>('f1SkrBox');
    return box.values.toList();
  }

  Future<List<F2SkrModel>> getF2skrDataList() async {
    var box = await Hive.openBox<F2SkrModel>('f2SkrBox');
    return box.values.toList();
  }

  Future<List<F3SkrModel>> getF3skrDataList() async {
    var box = await Hive.openBox<F3SkrModel>('f3SkrBox');
    return box.values.toList();
  }

  Future<List<TwoTSkrModel>> get2tskrDataList() async {
    var box = await Hive.openBox<TwoTSkrModel>('twoTSkrBox');
    return box.values.toList();
  }

  Future<List<F0SkrModel>> getf0skrDataList() async {
    var box = await Hive.openBox<F0SkrModel>('f0SkrBox');
    return box.values.toList();
  }

  Future<List<RodPumpData>> getrodPumpDataList() async {
    var box = await Hive.openBox<RodPumpData>('RodPumpDataBox');
    return box.values.toList();
  }

  Future<List<SRData>> getSRDataList() async {
    var box = await Hive.openBox<SRData>('SRDataBox');
    return box.values.toList();
  }

  Future<void> fetchPUTypes() async {
    final String response = await rootBundle.loadString('assets/PUType.json');
    final Map<String, dynamic> data =
        json.decode(response); // Ensure the data is a Map
    setState(() {
      puTypes = data.keys.toList();
    });
  }

  Future<void> updateSelectedPumpValues(String? pumpType) async {
    var box = await Hive.openBox<PUType>('puTypes');
    if (pumpType != null) {
      List<String?> newValues;
      if (pumpType.contains("conventionalData")) {
        newValues = box.values.map((puType) => puType.conventional).toList();
      } else if (pumpType.contains("markII")) {
        newValues = box.values.map((puType) => puType.markII).toList();
      } else if (pumpType.contains("airBalance")) {
        newValues = box.values.map((puType) => puType.airBalance).toList();
      } else {
        newValues = [];
      }

      // Filter out null or empty values
      newValues = newValues
          .where((value) => value != null && value.isNotEmpty)
          .toList();

      setState(() {
        selectedPUTypeValue =
            newValues; // Update the values for the second dropdown
        selectedPUTypeval = null; // Reset the second dropdown value
      });
    }
  }

  Future<void> fetchApiGrades() async {
    var box = await Hive.openBox<SRGrade>(
        'SRGrades'); // Replace with your actual box name
    setState(() {
      apiGrades = box.values
          .map((srGrade) => srGrade.apiGrade)
          .toList(); // Assuming apiGrade is a String
      yieldStrength = box.values
          .map((srGrade) => srGrade.yieldStrength)
          .toList(); // Assuming apiGrade is a String
      tensileStrength = box.values
          .map((srGrade) => srGrade.tensileStrength)
          .toList(); // Assuming apiGrade is a String
    });
  }

  Future<void> fetchSRApis() async {
    var box = await Hive.openBox<SR_API>(
        'SRAPIBox'); // Replace with your actual box name
    setState(() {
      rodNos = box.values.map((srApi) => srApi.rodNo).toList();
      rodNos.sort(); // Sort the list in ascending order
    });
  }

  Future<void> fetchPlungerDiameters() async {
    var box = await Hive.openBox<PumpConstant>(
        'PumpConstants'); // Replace with your actual box name
    setState(() {
      plungerDiameters = box.values.map((pumpConstant) {
        double parsedDiameter =
            parseMixedFraction(pumpConstant.plungerDiameter.toString());
        return parsedDiameter.toStringAsFixed(2);
      }).toList();
      fluidLoadFactor = box.values
          .map((pumpConstant) => pumpConstant
              .fluidLoadFactor) // Assuming plungerDiameter is a double
          .toList();
      plungerArea = box.values
          .map((pumpConstant) =>
              pumpConstant.plungerArea) // Assuming plungerDiameter is a double
          .toList();
      pumpFactor = box.values
          .map((pumpConstant) =>
              pumpConstant.pumpFactor) // Assuming plungerDiameter is a double
          .toList();
    });
  }

  Future<void> fetchTubingSizes() async {
    // Open the Hive box and get the tubing sizes from your API model
    var box =
        await Hive.openBox<API>('apiBox'); // Replace with your actual box name
    setState(() {
      // Assuming you have a method to get the list of tubing sizes from your API model
      tubingSizes = box.values
          .map((api) => api.tubingSize)
          .toList(); // Update this based on your API model structure
      outsideDiameters = box.values
          .map((api) => api.outsideDiameter)
          .toList(); // Update this based on your API model structure
      insideDiameters = box.values
          .map((api) => api.insideDiameter)
          .toList(); // Update this based on your API model structure
      metalAreas = box.values
          .map((api) => api.metalArea)
          .toList(); // Update this based on your API model structure
      elasticConstants = box.values
          .map((api) => api.elasticConstant)
          .toList(); // Update this based on your API model structure
    });
  }

  void _calculateResultPd() {
    setState(() {
      double? parsedValue =
          double.tryParse(_pd.text); // Parse _ps.text to an integer
      if (parsedValue != null) {
        resuldPd = parsedValue * 3.281; // Calculate the result
      } else {
        resuldPd = null; // Reset result if _ps.text is not a valid integer
      }
    });
  }

  void _calculateResultSmg() {
    setState(() {
      double? parsedValuesmg = double.tryParse(_smg.text);
      if (parsedValuesmg != null) {
        resultSmg = parsedValuesmg * 3.281; // Calculate the result
      } else {
        resultSmg = null; // Reset result if _ps.text is not a valid integer
      }
    });
  }

  Map<String, int?> getRodValues(List<RodPumpData> dataList, String rodNo,
      String plungerDiameter, int totalQuantity) {
    for (var data in dataList) {
      if (data.rodNo == rodNo && data.plungerDiameter == plungerDiameter) {
        return {
          '1/2': (data.rodString1_2 / 100 * totalQuantity).round(),
          '5/8': (data.rodString5_8 / 100 * totalQuantity).round(),
          '3/4': (data.rodString3_4 / 100 * totalQuantity).round(),
          '7/8': (data.rodString7_8 / 100 * totalQuantity).round(),
          '1': (data.rodString1 / 100 * totalQuantity).round(),
          '1 1/8': (data.rodString11_8 / 100 * totalQuantity).round(),
        };
      }
    }
    // Return a map with null values if no matching rodNo and plungerDiameter found
    return {
      '1/2': null,
      '5/8': null,
      '3/4': null,
      '7/8': null,
      '1': null,
      '1 1/8': null,
    };
  }

  Map<String, int?> multiplyMapValues(Map<String, int?> inputMap) {
    return inputMap
        .map((key, value) => MapEntry(key, value != null ? value * 25 : null));
  }

  int sumMapValues(Map<String, int?> inputMap) {
    int sum = 0;
    inputMap.forEach((key, value) {
      if (value != null) {
        sum += value;
      }
    });
    return sum;
  }

  double? getRodWeight(List<SRData> srDataList, String rodSize) {
    for (var data in srDataList) {
      if (data.rodSize == rodSize) {
        return data.rodWeight;
      }
    }
    return null;
  }

  Map<String, int?> multiplyMapValuesWithRodWeight(Map<String, int?> inputMap,
      List<SRData> srDataList, double buoyancyFactor) {
    return inputMap.map((key, value) {
      double? rodWeight = getRodWeight(srDataList, key);
      if (value != null && value > 0 && rodWeight != null) {
        double result = value * rodWeight * buoyancyFactor;
        return MapEntry(key, result.round().toInt());
      } else {
        return MapEntry(key, 0);
      }
    });
  }

  double? getLargestMetalArea(
      Map<String, int?> rodValues, List<SRData> srDataList) {
    List<double?> metalAreas = [];

    rodValues.forEach((key, value) {
      if (value != null && value > 0) {
        SRData? srData = srDataList.firstWhere(
          (element) => element.rodSize == key,
          orElse: () => SRData(
              rodSize: "",
              metalArea: 0.0,
              rodWeight: 0.0,
              elasticConstant: 0.0),
        );
        if (srData.rodSize.isNotEmpty) {
          metalAreas.add(srData.metalArea);
        }
      }
    });

    // Get the largest value in the list
    return metalAreas.isNotEmpty
        ? metalAreas.reduce((a, b) => a! > b! ? a : b)
        : null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  void _scrollToResult() {
    if (isResultVisible) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  // void saveData() {
  //   Map<String, dynamic> data = {
  //     "name": _nameController.text,
  //     "wellName": _wellNameController.text,
  //     "date": _dateController.text,
  //     "selectedRodNo": selectedRodNo,
  //     "selectedTubingSize": selectedTubingSize,
  //     "selectedPlungerDiameter": selectedPlungerDiameter,
  //     "selectedApiGrade": selectedApiGrade,
  //     "selectedTensileStrength": selectedTensileStrength,
  //     "selectedPUType": selectedPUType,
  //     "selectedPUTypeval": selectedPUTypeval,
  //     "selectedElasticConstant": selectedElasticConstant,
  //     "pd": _pd.text,
  //     "smg": _smg.text,
  //     "fsg": _fsg.text,
  //     "pe": _pe.text,
  //     "sf": _sf.text,
  //     "sl": _sl.text,
  //     "ps": _ps.text,
  //     // Add other variables as needed
  //   };

  //   // Save data to Hive
  //   saveDataToHive(data);
  // }

  // void saveDataToHive(Map<String, dynamic> data) async {
  //   final box = Hive.box<DynamicModel>('dynamicBox');
  //   final dynamicModel = DynamicModel(data: data);
  //   await box.put('dynamicKey', dynamicModel);
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _wellNameController,
                          decoration:
                              const InputDecoration(labelText: 'Well Name'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_today),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Pump Depth row
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Pump Depth",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _pd,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 1600",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text("m"),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 150),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        resuldPd != null ? "$resuldPd" : "0",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("ft"),
                  ],
                ),
              ),
              // resultSmg as double row
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Submergence",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _smg,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 100",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 150),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        resultSmg != null ? "$resultSmg" : "0",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("ft"),
                  ],
                ),
              ),
              //Fluid SG row
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Fluid SG",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _fsg,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 1",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // tubing size dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Tubing Size",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(":"),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: selectedTubingSize,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTubingSize =
                                newValue; // Update the selected value

                            tubingSize = parseMixedFraction(
                                selectedTubingSize as String);
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        items: tubingSizes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Tubing Size",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("in"),
                  ],
                ),
              ),
              // Plunger Diameter Dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Plunger Diameter",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<String?>(
                        isExpanded: true,
                        value: selectedPlungerDiameter,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPlungerDiameter =
                                newValue; // Update the selected value

                            plungerDiameter = parseMixedFraction(
                                selectedPlungerDiameter as String);
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        items: plungerDiameters
                            .map<DropdownMenuItem<String?>>((String? value) {
                          return DropdownMenuItem<String?>(
                            value: value,
                            child: Text(
                              value!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Plunger Diameter",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "in",
                    ),
                  ],
                ),
              ),
              //Sucker Rod API Dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Sucker Rod API",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<int>(
                        isExpanded: true,
                        value:
                            selectedRodNo, // This should be a variable holding the selected rodNo
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedRodNo = newValue;

                            suckerRodApi = selectedRodNo as int;
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        items: rodNos.map<DropdownMenuItem<int>>((int? rodNo) {
                          return DropdownMenuItem<int>(
                            value: rodNo, // Use rodNo as the value
                            child: Text(
                              '$rodNo',
                              style: const TextStyle(fontSize: 14),
                            ), // Display the rodNo value
                          );
                        }).toList(),
                        hint: const Text(
                          "Select API",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Sucker Rod Grade Dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Sucker Rod Grade",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: selectedApiGrade,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedApiGrade =
                                newValue; // Update the selected value
                            // Get the index of the selected grade
                            int index = apiGrades.indexOf(newValue!);
                            // Update the tensileStrength based on the selected index
                            suckerrodtensileStrength =
                                double.parse(tensileStrength[index] as String);
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        items: apiGrades
                            .asMap()
                            .entries
                            .map<DropdownMenuItem<String>>((entry) {
                          // int index = entry.key;
                          String? apiGrade = entry.value;
                          // String? tensileStrengthvalue = tensileStrength[index];

                          return DropdownMenuItem<String>(
                            value: apiGrade, // Use apiGrade as the value
                            child: Text(
                              '$apiGrade',
                              style: const TextStyle(fontSize: 14),
                            ), // Display both
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Sucker Rod Grade",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Pump Efficiency
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Pump Efficiency",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _pe,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 80",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("%"),
                  ],
                ),
              ),
              // Service Factor
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Service Factor",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _sf,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 0.9",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Pumping Unit Geometry Dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Select Pump Type",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(":"),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: selectedPUType,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPUType =
                                newValue; // Update the selected value

                            if (selectedPUType == "markII") {
                              pumpingUnitGeometryValue = 0.8;
                            } else {
                              pumpingUnitGeometryValue = 1.0;
                            }

                            updateSelectedPumpValues(
                                selectedPUType); // Update second dropdown values
                          });
                        },
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        items: puTypes
                            .map<DropdownMenuItem<String>>((String item) {
                          String displayText;
                          if (item == "conventionalData") {
                            displayText = "Conventional";
                          } else if (item == "markII") {
                            displayText = "Mark II";
                          } else if (item == "airBalance") {
                            displayText = "Air Balance";
                          } else {
                            displayText = item; // Default case
                          }

                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              displayText,
                              style: const TextStyle(fontSize: 14),
                            ), // Use the displayText variable
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Pump Type",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Pumping Unit Type Dropdown
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Select Pump Value",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(":"),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: DropdownButtonFormField<String?>(
                        isExpanded: true,
                        value: selectedPUTypeval,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPUTypeval =
                                newValue; // Update the selected value
                            final RegExp regExpTV = RegExp(r'-(\d+)D-');
                            RegExp regExpLR = RegExp(r'D-(\d+)-');
                            final Match? match = regExpTV
                                .firstMatch(selectedPUTypeval as String);
                            final Match? matchLR = regExpLR
                                .firstMatch(selectedPUTypeval as String);
                            if (match != null) {
                              torqueRating = double.parse(match.group(1)!) *
                                  1000; // Set the extracted value to the TextField
                              loadRating = double.parse(matchLR!.group(1)!) *
                                  100; // Set the extracted value to the TextField
                            }
                          });
                        },
                        items: selectedPUTypeValue
                            .map<DropdownMenuItem<String?>>((String? item) {
                          return DropdownMenuItem<String?>(
                            value: item,
                            child: Text(
                              item ?? "N/A",
                              style: const TextStyle(fontSize: 14),
                            ), // Display the item name or "N/A"
                          );
                        }).toList(),
                        hint: const Text(
                          "Select Pump Value",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //Torque Rating
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Torque Rating",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        torqueRating != null ? "$torqueRating" : "0",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              //load rating
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Load Rating",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        loadRating != null ? "$loadRating" : "0",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              //Stroke length
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Stroke Length",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _sl,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 168",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("in"),
                  ],
                ),
              ),
              //Pumping Speed
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 125,
                      child: Text(
                        "Pumping Speed",
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(":"),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 45.0,
                      child: TextField(
                        controller: _ps,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[\d\.]')),
                        ],
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // You can customize the color of the bottom border here
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors
                                  .grey, // Color of the border when TextField is not focused
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors
                                  .blue, // Color of the border when TextField is focused
                            ),
                          ),
                          hintText: "ex: 3",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        style: const TextStyle(
                          fontSize: 14, // Change this to your desired font size
                          color: Colors
                              .black, // You can also customize the text color
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text("SPM"),
                  ],
                ),
              ),
              // Anchored switch yes/no
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 125,
                          child: Text(
                            "Anchored",
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(":"),
                        const SizedBox(
                          width: 10,
                        ),
                        Switch(
                          value: _isToggled,
                          onChanged: (value) {
                            setState(() {
                              _isToggled = value;

                              if (_isToggled == true) {
                                anchoredValue = 0.0;
                              } else {
                                anchoredValue = 1.0;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //Run Button
              Padding(
                padding: const EdgeInsets.all(16.0), // Add padding if needed
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.9, // 90% of screen width
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Simulate an async operation
                        await Future.delayed(const Duration(seconds: 1));
                        // Perform asynchronous work here
                        double parsedFluidSG = double.parse(_fsg.text);
                        double parsedPumpEfficiency = double.parse(_pe.text);
                        double parsedServiceFactor = double.parse(_sf.text);
                        double parsedStrokeLength = double.parse(_sl.text);
                        double parsedPumpingSpeed = double.parse(_ps.text);
                        double? parsedRodSpecificWeight =
                            await SRPFunction().RodWeight(
                          suckerRodApi.toString(),
                          plungerDiameter.toStringAsFixed(2),
                        );
                        double? parsedElasticConstant =
                            await SRPFunction().getElasticConstant(
                          suckerRodApi.toString(),
                          plungerDiameter.toStringAsFixed(2),
                        );
                        double? parsedFrequencyFactor =
                            await SRPFunction().getFrequencyFactor(
                          suckerRodApi.toString(),
                          plungerDiameter.toStringAsFixed(2),
                        );
                        double? parsedTubingElasticConstant =
                            await SRPFunction().getElasticConstantByTubingSize(
                          selectedTubingSize.toString(),
                        );
                        var fluidLevel = SRPFunction().fluidLevel(
                            resuldPd as double, resultSmg as double);
                        var differentialFluidLoad = SRPFunction()
                            .differentialFluidLoad(
                                parsedFluidSG, plungerDiameter, fluidLevel);
                        var totalRodsElasticConstant = SRPFunction()
                            .totalRodsElasticConstant(
                                parsedElasticConstant!, resuldPd as double);

                        var loadToStretchTotalRodsSkr = SRPFunction()
                            .loadToStretchTotalRodsSkr(
                                parsedStrokeLength, totalRodsElasticConstant);
                        var loadToStretchTotalRodsFoSkr = SRPFunction()
                            .loadToStretchTotalRodsFoSkr(differentialFluidLoad,
                                loadToStretchTotalRodsSkr);

                        var loadToStretchTotalRodsNNo = SRPFunction()
                            .loadToStretchTotalRodsNNo(
                                parsedPumpingSpeed, resuldPd as double);

                        var loadToStretchTotalRodsNNoI = SRPFunction()
                            .loadToStretchTotalRodsNNoI(
                                loadToStretchTotalRodsNNo,
                                parsedFrequencyFactor!);

                        double? unanchoredTubingElasticConstantSps =
                            await SRPFunction().interpolateYUsingSpS(
                                loadToStretchTotalRodsNNoI,
                                loadToStretchTotalRodsFoSkr,
                                dataListnnovssps);

                        double? totalRodsWeightInFluidF1Skr =
                            await SRPFunction().interpolateYUsingF1Skr(
                                loadToStretchTotalRodsNNo,
                                loadToStretchTotalRodsFoSkr,
                                dataListF1skr);
                        double? totalRodsWeightInFluidF2Skr =
                            await SRPFunction().interpolateYUsingF2Skr(
                                loadToStretchTotalRodsNNo,
                                loadToStretchTotalRodsFoSkr,
                                dataListF2skr);
                        double? totalRodsWeightInFluidF3Skr =
                            await SRPFunction().interpolateYUsingF3Skr(
                                loadToStretchTotalRodsNNo,
                                loadToStretchTotalRodsFoSkr,
                                dataListF3skr);
                        double? totalRodsWeightInFluid2tSkr =
                            await SRPFunction().interpolateYUsingTwoTSkr(
                                loadToStretchTotalRodsNNo,
                                loadToStretchTotalRodsFoSkr,
                                dataList2tskr);

                        double? totalRodsWeightInFluidTaStar =
                            await SRPFunction().interpolateUsingF0Skr(
                                loadToStretchTotalRodsNNoI,
                                loadToStretchTotalRodsFoSkr,
                                dataListf0skr);

                        totalQuantity = calculateValue(resuldPd!);

                        rodValues = getRodValues(
                            rodPumpDataList,
                            suckerRodApi.toString(),
                            plungerDiameter.toStringAsFixed(2),
                            totalQuantity);

                        multipliedValues = multiplyMapValues(rodValues);
                        totalLength = sumMapValues(multipliedValues);

                        // Ensure that parsedRodSpecificWeight is not null
                        if (parsedRodSpecificWeight == null ||
                            parsedTubingElasticConstant == null) {
                          // Handle the case where no matching entry is found
                          print("No matching rod found.");
                          return;
                        }

                        fluidSG = parsedFluidSG;
                        pumpEfficiency = parsedPumpEfficiency;
                        serviceFactor = parsedServiceFactor;
                        strokeLength = parsedStrokeLength;
                        pumpingSpeed = parsedPumpingSpeed;
                        rodSpecificWeight = parsedRodSpecificWeight;
                        rodElasticConstant = parsedElasticConstant;
                        frequencyFactor = parsedFrequencyFactor;
                        tubingElasticConstant = parsedTubingElasticConstant;

                        var bouyancyFactor =
                            SRPFunction().bouyancyFactor(fluidSG);

                        weightValues = multiplyMapValuesWithRodWeight(
                            multipliedValues, SRDataList, bouyancyFactor);

                        totalWeight = sumMapValues(weightValues);

                        metalArea = getLargestMetalArea(rodValues, SRDataList)!;

                        print("metalArea: $metalArea");

                        // Update the state synchronously
                        setState(() {
                          totalRodsWeightInFluidTaStar = SRPFunction()
                              .totalRodsWeightInFluidTaStar(
                                  totalRodsWeightInFluidTaStar!);
                          var totalRodsWeightInAir = SRPFunction()
                              .totalRodsWeightInAir(
                                  rodSpecificWeight, resuldPd as double);

                          var totalRodsWeightInFluid = SRPFunction()
                              .totalRodsWeightInFluid(
                                  totalRodsWeightInAir, bouyancyFactor);
                          var totalRodsWeightInFluidWrfSkr = SRPFunction()
                              .totalRodsWeightInFluidWrfSkr(
                                  loadToStretchTotalRodsSkr,
                                  totalRodsWeightInFluid);
                          var adjustment = SRPFunction()
                              .adjustment(totalRodsWeightInFluidWrfSkr);
                          var adjustmentTa = SRPFunction().adjustmentTa(
                              adjustment, totalRodsWeightInFluidTaStar!);

                          if (selectedPUType == "conventionalData") {
                            peakPolishedRodLoad = SRPFunction()
                                .conventionalPPRL(
                                    totalRodsWeightInFluid,
                                    totalRodsWeightInFluidF1Skr!,
                                    loadToStretchTotalRodsSkr);

                            minimumPolishedRodLoad = SRPFunction()
                                .conventionalMPRL(
                                    totalRodsWeightInFluid,
                                    loadToStretchTotalRodsSkr,
                                    totalRodsWeightInFluidF2Skr!);

                            peakCrankTorque = SRPFunction().conventionalPT(
                                totalRodsWeightInFluid2tSkr!,
                                loadToStretchTotalRodsSkr,
                                strokeLength,
                                adjustmentTa);

                            counterWeightRequired = SRPFunction()
                                .conventionalCBE(differentialFluidLoad,
                                    totalRodsWeightInFluid);
                          } else if (selectedPUType == "markII") {
                            peakPolishedRodLoad = SRPFunction().MarkIIPPRL(
                                totalRodsWeightInFluid,
                                differentialFluidLoad,
                                totalRodsWeightInFluidF1Skr!,
                                loadToStretchTotalRodsSkr);

                            minimumPolishedRodLoad = SRPFunction().markIIMPRL(
                                peakPolishedRodLoad,
                                totalRodsWeightInFluidF1Skr!,
                                totalRodsWeightInFluidF2Skr!,
                                loadToStretchTotalRodsSkr);

                            peakCrankTorque = SRPFunction().markIIPT(
                                peakPolishedRodLoad,
                                minimumPolishedRodLoad,
                                strokeLength);

                            counterWeightRequired = SRPFunction().markIICBE(
                                peakPolishedRodLoad, minimumPolishedRodLoad);
                          } else {
                            peakPolishedRodLoad = SRPFunction().airBalancePPRL(
                                totalRodsWeightInFluid,
                                differentialFluidLoad,
                                totalRodsWeightInFluidF1Skr!,
                                loadToStretchTotalRodsSkr);

                            minimumPolishedRodLoad = SRPFunction()
                                .airBalanceMPRL(
                                    peakPolishedRodLoad,
                                    totalRodsWeightInFluidF1Skr!,
                                    totalRodsWeightInFluidF2Skr!,
                                    loadToStretchTotalRodsSkr);

                            peakCrankTorque = SRPFunction().airBalancePT(
                                totalRodsWeightInFluid2tSkr!,
                                strokeLength,
                                totalRodsElasticConstant,
                                totalRodsWeightInFluid,
                                loadToStretchTotalRodsSkr,
                                adjustmentTa);

                            counterWeightRequired = SRPFunction().airBalanceCBE(
                                peakPolishedRodLoad, minimumPolishedRodLoad);
                          }

                          var unanchoredTubingElasticConstant = SRPFunction()
                              .unanchoredTubingElasticConstant(
                                  tubingElasticConstant,
                                  resuldPd as double,
                                  anchoredValue);
                          var bottomHolePumpStroke = SRPFunction()
                              .bottomHolePumpStroke(
                                  strokeLength,
                                  differentialFluidLoad,
                                  unanchoredTubingElasticConstant,
                                  unanchoredTubingElasticConstantSps!);
                          var pumpDisplacement = SRPFunction().pumpDisplacement(
                              bottomHolePumpStroke,
                              pumpingSpeed,
                              plungerDiameter);

                          var polishedRodHorsepower = SRPFunction()
                              .polishedRodHorsepower(
                                  totalRodsWeightInFluidF3Skr!,
                                  loadToStretchTotalRodsSkr,
                                  strokeLength,
                                  pumpingSpeed);
                          var maximumStress = SRPFunction()
                              .maximumStress(peakPolishedRodLoad, metalArea);
                          var minimumStress = SRPFunction()
                              .minimumStress(minimumPolishedRodLoad, metalArea);
                          maximumAllowableStress =
                              (0.25 * suckerrodtensileStrength +
                                      0.5625 * minimumStress) *
                                  serviceFactor;
                          var primeMoverHPNemaC = SRPFunction()
                              .primeMoverHPNemaC(
                                  plungerDiameter,
                                  pumpingSpeed,
                                  strokeLength,
                                  fluidSG,
                                  resuldPd as double,
                                  totalRodsWeightInFluid);
                          var primeMoverHPNemaD = SRPFunction()
                              .primeMoverHPNemaD(
                                  plungerDiameter,
                                  pumpingSpeed,
                                  strokeLength,
                                  fluidSG,
                                  resuldPd as double,
                                  totalRodsWeightInFluid);
                          var brakeHPNemaC = SRPFunction().brakeHPNemaC(
                              pumpDisplacement,
                              resuldPd as double,
                              pumpingUnitGeometryValue);
                          var brakeHPNemaD = SRPFunction().brakeHPNemaD(
                              pumpDisplacement,
                              resuldPd as double,
                              pumpingUnitGeometryValue);

                          pumpCapacity = SRPFunction()
                              .pumpCapacity(pumpDisplacement, pumpEfficiency);
                          pumpingUnitTorque = SRPFunction().pumpingUnitTorque(
                                  peakCrankTorque, torqueRating) *
                              100;
                          pumpingUnitLoad = SRPFunction().pumpingUnitLoad(
                                  peakPolishedRodLoad, loadRating) *
                              100;
                          rodStress = SRPFunction().rodStress(
                                  maximumStress, maximumAllowableStress) *
                              100;
                          counterBalance = counterWeightRequired;

                          // Calculate the maximum power
                          power = max(max(primeMoverHPNemaC, primeMoverHPNemaD),
                              max(brakeHPNemaC, brakeHPNemaD));

                          isResultVisible = true;
                        });
                        _scrollToResult();
                      } catch (error) {
                        // Show a popup if an error occurs
                        print(error);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Error"),
                              content: Text("An error occurred: $error"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0), // Adjust padding for height
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      "Run",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Show the result only if isResultVisible is true
              if (isResultVisible)
                Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Makes the Column size minimal
                        children: [
                          const Text(
                            "R E S U L T",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(
                              height: 4), // Space between text and underline
                          Container(
                            height: 2, // Height of the underline
                            width:
                                100, // Width of the underline; adjust as needed
                            color: Colors.red, // Color of the underline
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15.0,
                                right: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Pump Displacement Capacity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${pumpCapacity.toStringAsFixed(2)} bbl/day",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 15.0,
                                left: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Pump Unit Torque Capacity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${pumpingUnitTorque.toStringAsFixed(2)} %",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15.0,
                                right: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Pump Unit Load Capacity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "${pumpingUnitLoad.toStringAsFixed(2)} %",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 15.0,
                                left: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Rod Stress Capacity",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${rodStress.toStringAsFixed(2)} %",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 15.0,
                                right: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Counter Balance",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${counterBalance.toStringAsFixed(0)} lbs",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 15.0,
                                left: 5,
                                top: 8.0), // Margin on left and right
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.image, size: 40),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Required Horse Power",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${power.toStringAsFixed(2)} hp",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0), // Vertical margin only
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // Set maximum width to 95% of screen width
                          decoration: BoxDecoration(
                            // Set background color
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
                          ),
                          child: Column(
                            children: [
                              // Title above the table
                              const Center(
                                child: Text(
                                  'Taper Rods',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // Table wrapped in SingleChildScrollView
                              Center(
                                child: DataTable(
                                  columnSpacing:
                                      10, // Minimize space between columns
                                  headingRowColor:
                                      MaterialStateColor.resolveWith(
                                          (states) => Colors.blueGrey[100]!),
                                  dataRowColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.white),
                                  columns: [
                                    const DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Size (in)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Quantity (jts)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Length (ft)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    const DataColumn(
                                      label: Center(
                                        child: Text(
                                          'Weight (lbs)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('1/2',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['1/2'] != null
                                                  ? rodValues['1/2'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['1/2'] != null
                                                  ? multipliedValues['1/2']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['1/2'] != null
                                                  ? weightValues['1/2']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('5/8',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['5/8'] != null
                                                  ? rodValues['5/8'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['5/8'] != null
                                                  ? multipliedValues['5/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['5/8'] != null
                                                  ? weightValues['5/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('3/4',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['3/4'] != null
                                                  ? rodValues['3/4'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['3/4'] != null
                                                  ? multipliedValues['3/4']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['3/4'] != null
                                                  ? weightValues['3/4']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('7/8',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['7/8'] != null
                                                  ? rodValues['7/8'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['7/8'] != null
                                                  ? multipliedValues['7/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['7/8'] != null
                                                  ? weightValues['7/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('1',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['1'] != null
                                                  ? rodValues['1'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['1'] != null
                                                  ? multipliedValues['1']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['1'] != null
                                                  ? weightValues['1'].toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('1 1/8',
                                              style: TextStyle(fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              rodValues['1 1/8'] != null
                                                  ? rodValues['1 1/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              multipliedValues['1 1/8'] != null
                                                  ? multipliedValues['1 1/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(
                                              weightValues['1 1/8'] != null
                                                  ? weightValues['1 1/8']
                                                      .toString()
                                                  : '0',
                                              style: const TextStyle(
                                                  fontSize: 14)))),
                                    ]),
                                    DataRow(cells: [
                                      const DataCell(Center(
                                          child: Text('Total',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(totalQuantity.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(totalLength.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)))),
                                      DataCell(Center(
                                          child: Text(totalWeight.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)))),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
