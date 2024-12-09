import 'package:flutter/material.dart';
import 'package:pearl/view/srp/srp_screen.dart';
import 'package:pearl/view/wellpi/well_pi_screen.dart';
import 'package:pearl/view/widgets/row_content.dart';

// Custom Body Content Widget
class CustomBody extends StatelessWidget {
  const CustomBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Use RowContent for each row in the body
            RowContent(
              leftTitle: "WELL PI",
              rightTitle: "SRP DESIGN",
              leftColor: const Color(0xFF106DB6),
              rightColor: const Color(0xFF70BBFF),
              leftIcon: "assets/img/icon_well_pi.png",
              rightIcon: "assets/img/icon_srp.png",
              onLeftTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WellPIScreen()));
              },
              onRightTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SRPScreen()));
              },
            ),
            RowContent(
              leftTitle: "SWAB",
              rightTitle: "ESP DESIGN",
              leftColor: const Color(0xFF70BBFF),
              rightColor: const Color(0xFF106DB6),
              leftIcon: "assets/img/icon_swab.png",
              rightIcon: "assets/img/icon_esp.png",
              onLeftTap: () {
                print("SWAB clicked");
              },
              onRightTap: () {
                print("ESP DESIGN clicked");
              },
            ),
            RowContent(
              leftTitle: "IPR SONOLOG",
              rightTitle: "HPU DESIGN",
              leftColor: const Color(0xFF106DB6),
              rightColor: const Color(0xFF70BBFF),
              leftIcon: "assets/img/icon_sonolog.png",
              rightIcon: "assets/img/icon_hpu.png",
              onLeftTap: () {
                print("IPR SONOLOG clicked");
              },
              onRightTap: () {
                print("HPU DESIGN clicked");
              },
            ),
            RowContent(
              leftTitle: "IPR 3 PHASE",
              rightTitle: "GAS LIFT DESIGN",
              leftColor: const Color(0xFF70BBFF),
              rightColor: const Color(0xFF106DB6),
              leftIcon: "assets/img/icon_3phase.png",
              rightIcon: "assets/img/icon_gas_lift.png",
              onLeftTap: () {
                print("IPR 3 PHASE clicked");
              },
              onRightTap: () {
                print("GAS LIFT DESIGN clicked");
              },
            ),
            RowContent(
              leftTitle: "INTERPOLATION",
              rightTitle: "",
              leftColor: const Color(0xFF106DB6),
              rightColor: const Color(0xFF70BBFF),
              leftIcon: "assets/img/icon_interpolation.png",
              rightIcon: "",
              onLeftTap: () {
                print("INTERPOLATION clicked");
              },
              onRightTap: () {
                print("EMPTY clicked");
              },
            ),
          ],
        ),
      ),
    );
  }
}
