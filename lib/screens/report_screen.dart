import 'package:dgha/components/appbar.dart';
import 'package:dgha/components/dgha_icon.dart';
import 'package:dgha/components/dgha_text_btn.dart';
import 'package:dgha/misc/dgha_api.dart';
import 'package:dgha/misc/styles.dart';
import 'package:dgha/models/place.dart';
import 'package:dgha/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

class ReportScreen extends StatefulWidget {
  static const id = "Report Screen";
  final PlaceData placeData;

  ReportScreen(this.placeData);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _txtController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: Styles.spacing),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: Styles.heightFromAppBar,
                  ),

                  //---------- NOTE: Place Name
                  Container(
                    child: Text(
                      widget.placeData.name ?? '',
                      style: Styles.h2Style,
                    ),
                  ),

                  // --------- NOTE: Address
                  Container(
                    child: Text(
                      widget.placeData.address ?? '',
                      style: Styles.pStyle,
                    ),
                  ),

                  SizedBox(height: Styles.spacing),

                  // --------- NOTE: Comment
                  Container(
                    child: Text(
                      "Comment",
                      style: Styles.h3Style,
                    ),
                  ),
                  Semantics(
                    label: "Comment",
                    hint:
                        "Double tap to give more information on why you're reporting ${widget.placeData.name ?? ''}",
                    excludeSemantics: true,
                    child: TextField(
                      controller: _txtController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 7,
                      maxLength: 140,
                      style: Styles.pStyle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // --------- NOTE: Submit Button
                  Container(
                    child: DghaTextButton(
                      minWidth: MediaQuery.of(context).size.width * 0.45,
                      text: isLoading ? "Sending..." : "Submit",
                      textStyle: Styles.yellowTxtBtnStyle,
                      colour: isLoading ? Styles.grey : Styles.midnightBlue,
                      onTap: () async {
                        setState(() {
                          this.isLoading = true;
                        });

                        final response = await DghaApi.postComplaint(
                          widget.placeData.placeId ?? '',
                          _txtController.text,
                        );

                        if (response?.statusCode == 201) {
                          Navigator.of(context).pop();
                          setState(() {
                            this.isLoading = false;
                          });
                          print("Report Sent!");
                        } else {
                          setState(() {
                            this.isLoading = false;
                          });
                          print("Error: ${response?.statusCode}");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ---- NOTE: App Bar
            DghaAppBar(
              text: "Report",
              isMenu: true,
              semanticLabel: "Report ${widget.placeData.name}",
              childOne: Semantics(
                button: true,
                label: "Menu",
                hint: "Double tap to go back and cancel the report",
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(PlaceDetailsScreen.id,
                        arguments: widget.placeData);
                  },
                  child: DghaIcon(
                    icon: FontAwesomeIcons.arrowLeft,
                    backgroundColor: Styles.midnightBlue,
                    iconColor: Styles.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
