import 'package:flutter/material.dart';

// Custom Body Content Widget
class WellPIBody extends StatelessWidget {
  WellPIBody({super.key});
  final TextEditingController _ps = TextEditingController();
  final TextEditingController _pwf = TextEditingController();
  final TextEditingController _q = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Ps row
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Ps"),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(":"),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 280.0,
                    height: 40.0,
                    child: TextField(
                      controller: _ps,
                      keyboardType: TextInputType.number,
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
                        hintText: "e.g 500",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Pwf row
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Pwf"),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(":"),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 280.0,
                    height: 40.0,
                    child: TextField(
                      controller: _pwf,
                      keyboardType: TextInputType.number,
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
                        hintText: "e.g 500",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //q row
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Q"),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(":"),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 280.0,
                    height: 40.0,
                    child: TextField(
                      controller: _q,
                      keyboardType: TextInputType.number,
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
                        hintText: "e.g 500",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
