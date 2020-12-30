import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:streakers_journal_beta/screens/reviews_screen.dart';
import 'package:streakers_journal_beta/screens/welcome_screen.dart';
import 'package:streakers_journal_beta/models/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

// BEGIN code from material_tag_editor
import 'package:material_tag_editor/tag_editor.dart';
import 'package:material_tag_editor/tag_editor_layout_delegate.dart';
import 'package:material_tag_editor/tag_layout.dart';
import 'package:material_tag_editor/tag_render_layout_box.dart';
// END code from material_tag_editor

//import 'dart:html';
//import 'dart:convert';

// This is the stateful widget that the main application instantiates, per https://api.flutter.dev/flutter/widgets/Form-class.html
class SandboxWriteReviewScreen extends StatefulWidget {
  // BEGIN code from material_tag_editor
  final String title = 'Material Tag Editor Demo';
// END code from material_tag_editor

  @override
  _SandboxWriteReviewScreenState createState() =>
      _SandboxWriteReviewScreenState();
}

// This is the private State class that goes with WriteReviewScreen
class _SandboxWriteReviewScreenState extends State<SandboxWriteReviewScreen> {
  var data;
  AutovalidateMode autovalidateMode = AutovalidateMode.always;
  bool readOnly = false;
  bool showSegmentedControl = true;
  //final _newFormbuilderKey = GlobalKey<FormState>();
  final _newnewFormbuilderKey = GlobalKey<FormBuilderState>();

  // above "GlobalKey" lets us generate a unique, app-wide ID that we can associate with our form, per https://fluttercrashcourse.com/blog/realistic-forms-part1
  final ValueChanged _onChanged = (val) => print(val);

  // BEGIN  related to FormBuilderTextField in form below
  final _ageController = TextEditingController(text: '45');
  bool _ageHasError = false;
  // END related to FormBuilderTextField in form below

  String qEleven;
  String qTwelve;

  // BEGIN code from material_tag_editor
  List<String> qOne = [];
  final FocusNode _focusNode = FocusNode();

  onDelete(index) {
    setState(() {
      qOne.removeAt(index);
    });
  }

  // below = reiteration for cons

  List<String> qThree = [];
  //final FocusNode _focusNode = FocusNode();

  uponDelete(index) {
    // NOTE: "uponDelete" for cons vs. "onDelete" for pros
    setState(() {
      qThree.removeAt(index);
    });
  }

// END code from material_tag_editor

  //final _user = User();

  List<bool> isSelected;

  int starIconColor =
      0xffFFB900; // was 0xffFFB900;  0xffD49428 is from this image: https://images.liveauctioneers.com/houses/logos/lg/bartonsauction550_large.jpg?auto=webp&format=pjpg&width=140

  @override
  void initState() {
    //isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'back',
                  style: TextStyle(
                    fontSize: 7,
                  ),
                ),
              ],
            ),
          ),
        ],

        leading: Icon(
          Icons.rate_review,
          color: Colors.black54,
        ),
        title: Column(
          children: [
            Text(
              'SANDBOX Write a Review',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              'flutter_form_builder ^4.0.2',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
          ],
        ),
        // BEGIN appBar gradient code, per https://medium.com/flutter-community/how-to-improve-your-flutter-application-with-gradient-designs-63180ba96124
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter, // Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [
                Color(0xff00c6fb),
                Color(0xff005bea),
              ],
            ),
          ),
        ),
        // END appBar gradient code, per https://medium.com/flutter-community/how-to-improve-your-flutter-application-with-gradient-designs-63180ba96124
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Builder(
            builder: (context) => FormBuilder(
              // was "builder: (context) => Form("
              key: _newnewFormbuilderKey,
              initialValue: {
                'date': DateTime.now(),
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q1 via TagEditor', // was 'What are 3 good or positive things about the house, property or neighborhood?', //  [ 1 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    // BEGIN code from material_tag_editor
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TagEditor(
                        length: qOne.length,
                        delimiters: [
                          ','
                        ], // was delimiters: [',', ' '],  Also tried "return" ('\u2386',) and '\u{2386}'
                        hasAddButton: true,
                        textInputAction: TextInputAction
                            .next, // moves user from one field to the next!!!!
                        autofocus: false,
                        maxLines: 1,

                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.lightBlue),
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        inputDecoration: const InputDecoration(
                          // below was "border: InputBorder.none,"
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            // above is per https://github.com/flutter/flutter/issues/5191
                          ),
                          labelText: 'separate,  with,  commas',
                          labelStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            backgroundColor:
                                Color(0x65dffd02), // was Color(0xffDDFDFC),
                            color: Colors.black87, // was Color(0xffD82E6D),
                            fontSize: 14,
                          ),
                        ),
                        onTagChanged: (value) {
                          setState(() {
                            qOne.add(value);
                          });
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: qOne[index],
                          onDeleted: onDelete,
                        ),
                      ),
                    ),
                    // END code from material_tag_editor

                    // BEGIN mgav custom tag form field
                    // END mgav custom tag form field

                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q2 via FormBuilder\'s FormBuilderChipsInput', // was 'What are 3 good or positive things about the house, property or neighborhood?', //  [ 1 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    // BEGIN Chips Input
                    FormBuilderChipsInput(
                        name: 'qTwo',
                        chipBuilder: null,
                        suggestionBuilder: null,
                        findSuggestions: null),

                    SuperDivider(),
                    // END Chips Input
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '​​Q3 via TagEditor', //  [ 2 ​]  was '​​List up to 3 negatives, or things you don’t like, about the house, property or neighborhood:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '(optional)', //  was text: '\n(optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              backgroundColor:
                                  Color(0x70DDFDFC), // was Color(0x30F8A0A2),
                              color: Colors.black54, // was Color(0xffD82E6D),
                              //color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    // BEGIN code from material_tag_editor
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TagEditor(
                        length: qThree.length,
                        delimiters: [','], // was delimiters: [',', ' '],
                        hasAddButton: true,
                        textInputAction: TextInputAction
                            .next, // moves user from one field to the next!!!!
                        autofocus: false,
                        maxLines: 1,
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: Colors.lightBlue),
                        //   borderRadius: BorderRadius.circular(20.0),
                        // ),
                        inputDecoration: const InputDecoration(
                          // below was "border: InputBorder.none,"
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            ),
                            // above is per https://github.com/flutter/flutter/issues/5191
                          ),
                          labelText: 'separate,  with,  commas',
                          labelStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            backgroundColor:
                                Color(0x65dffd02), // was Color(0xffDDFDFC),
                            color: Colors.black87, // was Color(0xffD82E6D),
                            fontSize: 14,
                          ),
                          // helperText: 'separate items,  with,  commas',
                          // helperStyle: TextStyle(
                          //   fontStyle: FontStyle.italic,
                          //   backgroundColor:
                          //       Color(0xffDDFDFC), // was (light red/pink) Color(0x30F8A0A2),
                          //   color: Colors.black87, // was Color(0xffD82E6D),
                          //   fontSize: 12.8,
                          // ),
                        ),
                        onTagChanged: (value) {
                          setState(() {
                            qThree.add(value);
                          });
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: qThree[index],
                          onDeleted: uponDelete,
                        ),
                      ),
                    ),
                    // END code from material_tag_editor
                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '​​Q4 - via FormBuilder\'s FormBuilderRadioGroup', //  [ 3 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (required)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.red[700],
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    FormBuilderRadioGroup(
                      name: 'qFour',
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelStyle: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      wrapVerticalDirection: VerticalDirection.down,
                      // orientation: GroupedRadioOrientation.vertical,
                      orientation: OptionsOrientation.vertical,
                      onChanged: _onChanged,
                      options: [
                        FormBuilderFieldOption(
                            value: '0', child: Text('Never')),
                        FormBuilderFieldOption(
                            value: '30', child: Text('Within the last month')),
                        FormBuilderFieldOption(
                            value: '180',
                            child: Text('Within the last 6 months')),
                        FormBuilderFieldOption(
                            value: '181',
                            child: Text('More than 6 months ago')),
                      ],
                    ),
                    SuperDivider(),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'Q5 - via FormBuilder\'s FormBuilderTextField', //  [ 4 ​]
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            TextSpan(
                              text: '  (optional)',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontSize: 14.0,
                                color: Colors.black54,
                              ), // was 'misleading or inaccurate?',
                            ),
                          ],
                        ),
                      ),
                    ),
                    GavTextField(
                      maxCharLength: 200,
                      fieldAttribute: 'qFive',
                      fieldLabelText: '',
                    ),
                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q6 - via FormBuilder\'s FormBuilderTextField', //  ​​[ 5 ​]  was 'Any "red flags" or severe drawbacks about the house, property or location?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    GavTextField(
                      maxCharLength: 200,
                      fieldAttribute: 'qSix',
                      fieldLabelText: '',
                    ),
                    SuperDivider(),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q7 - via FormBuilder\'s FormBuilderTextField', //  [ 6 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)', // was '\n(optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    GavTextField(
                      maxCharLength: 500,
                      fieldAttribute: 'qSeven',
                      fieldLabelText: '',
                    ),
                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q8 - via FormBuilder\'s FormBuilderRating ', // [ 7 ​]   AND clipped " for this house"
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text:
                                '  (all are optional)', // put 2 spaces instead of "\n (line break)
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    FormBuilderRating(
                      name: 'qEightA',
                      decoration: const InputDecoration(
                        //contentPadding: EdgeInsets.only(left: 16.0),
                        border: InputBorder.none,
                        //prefixStyle: ,
                        prefix: Text(
                          'qEightA',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(16, -7),
                              )
                            ],
                          ),
                        ),
                      ),
                      initialValue: 0,
                      onChanged: _onChanged,
                      filledColor:
                          Color(0xffFFB900), // later: use starIconColor
                      emptyIcon: Icons.star_border_outlined,
                      emptyColor: Color(0xffFFB900), // later: use starIconColor
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      halfFilledColor:
                          Color(0xffFFB900), // later: use starIconColor
                      iconSize: 32.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 67.0),
                      child: FormBuilderRating(
                        name: 'qEightB',
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefix: Text(
                            'qEightB',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    offset: Offset(16, -7))
                              ],
                            ),
                          ),
                        ),
                        initialValue: 0,
                        onChanged: _onChanged,
                        filledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        emptyIcon: Icons.star_border_outlined,
                        emptyColor:
                            Color(0xffFFB900), // later: use starIconColor
                        isHalfAllowed: true,
                        halfFilledIcon: Icons.star_half,
                        halfFilledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        iconSize: 32.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: FormBuilderRating(
                        name: 'qEightC',
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefix: Text(
                            'qEightC',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    offset: Offset(16, -7))
                              ],
                            ),
                          ),
                        ),
                        initialValue: 0,
                        onChanged: _onChanged,
                        filledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        emptyIcon: Icons.star_border_outlined,
                        emptyColor:
                            Color(0xffFFB900), // later: use starIconColor
                        isHalfAllowed: true,
                        halfFilledIcon: Icons.star_half,
                        halfFilledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        iconSize: 32.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 56.0),
                      child: FormBuilderRating(
                        name: 'qEightD',
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefix: Text(
                            'qEightD',
                            // style: TextStyle(
                            //   fontSize: 16,
                            // ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    color: Colors.black54,
                                    offset: Offset(16, -7))
                              ],
                            ),
                          ),
                        ),
                        initialValue: 0,
                        onChanged: _onChanged,
                        filledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        emptyIcon: Icons.star_border_outlined,
                        emptyColor:
                            Color(0xffFFB900), // later: use starIconColor
                        isHalfAllowed: true,
                        halfFilledIcon: Icons.star_half,
                        halfFilledColor:
                            Color(0xffFFB900), // later: use starIconColor
                        iconSize: 32.0,
                      ),
                    ),
                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q9 - via FormBuilder\'s FormBuilderImagePicker', // [ 8 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    FormBuilderImagePicker(
                      name: 'qNine',
                      onChanged: _onChanged,
                      decoration: const InputDecoration(
                        labelText:
                            'Images really help people', // was 'People find images really helpful',
                        labelStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                        // helperText: 'People find images really helpful',
                        // helperStyle: TextStyle(
                        //   fontStyle: FontStyle.italic,
                        // ),
                      ),
                    ),
                    SuperDivider(),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Q10 - via FormBuilder\'s FormBuilderTextField', // [ 9 ​]
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          TextSpan(
                            text: '  (optional)',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: 14.0,
                              color: Colors.black54,
                            ), // was 'misleading or inaccurate?',
                          ),
                        ],
                      ),
                    ),
                    GavTextField(
                      maxCharLength: 1200,
                      fieldAttribute: 'qTen',
                      fieldLabelText:
                          'Be honest & kind.', // was 'Be honest, but kind.',
                    ),
                    SuperDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Alert(
                                context: context,
                                style: alertStyle,
                                title: 'Two quick things...',
                                desc: ' ',
                                content: Column(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                'Q11 - via FormBuilder\'s FormBuilderRadioGroup', // [ 10 ​]
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FormBuilderRadioGroup(
                                      name: 'qEleven',
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      orientation: OptionsOrientation.vertical,
                                      onChanged: _onChanged,
                                      options: [
                                        FormBuilderFieldOption(
                                          value: 'N',
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'No', // [ 10 ​]
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        FormBuilderFieldOption(
                                          value: 'YesSometimes',
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      'Yes, sometimes', // [ 10 ​]
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        FormBuilderFieldOption(
                                          value: 'YesDaily',
                                          child: RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text: 'Yes, daily', // [ 10 ​]
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    onPressed: () {
                                      Alert(
                                          context: context,
                                          style: alertStyle,
                                          title: 'And lastly:',
                                          desc: '',
                                          content: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              ' Q12 - via FormBuilder\'s', // [ 10 ​]
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'FormBuilderRadioGroup', // [ 10 ​]
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              FormBuilderRadioGroup(
                                                name: 'qTwelve',
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                                orientation:
                                                    OptionsOrientation.vertical,
                                                onChanged: _onChanged,
                                                options: [
                                                  FormBuilderFieldOption(
                                                    value: 'postFullPublic',
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.person,
                                                          // color:
                                                          //     Colors.blue,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    ' Public', // [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    '  (real name)', // was "'  (my real name)',"  [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FormBuilderFieldOption(
                                                    value: 'postAnonPublic',
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.person_outline,
                                                          // color:
                                                          //     Colors.blue,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    ' Incognito', // [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    '  (username)', // [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      14.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FormBuilderFieldOption(
                                                    value: 'keepFullyPrivate',
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .minimize, // or Icons.block,
                                                          // color:
                                                          //     Colors.blue,
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text:
                                                                    ' Private', // [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    '  (only me +)', // [ 10 ​]
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .help_outlined,
                                                              size: 18,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                            onPressed: () {
                                                              print(
                                                                  'icon button pressed');
                                                              Alert(
                                                                context:
                                                                    context,
                                                                //type: AlertType.error,
                                                                style:
                                                                    alertStyle,
                                                                //title: " ",
                                                                //desc: ".",
                                                                content: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        children: <
                                                                            TextSpan>[
                                                                          TextSpan(
                                                                            text:
                                                                                'What Does \'Private\' Mean?', // [ 10 ​]
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18.0,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                '\n\nsome text here.', // [ 10 ​]
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16.0,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  //
                                                                ),
                                                                title: " ",
                                                                buttons: [
                                                                  DialogButton(
                                                                    child: Text(
                                                                      "Okay, Got It",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                    onPressed: () =>
                                                                        Navigator.pop(
                                                                            context),
                                                                    width: 150,
                                                                  )
                                                                ],
                                                              ).show();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black87),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          'More text here', // [ 10 ​]
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              // BEGIN submit form when button pressed per 4.0.2 Readme and video https://www.youtube.com/watch?v=7FBELQq808M
                                              onPressed: () {
                                                _newnewFormbuilderKey
                                                    .currentState
                                                    .save();
                                                if (_newnewFormbuilderKey
                                                    .currentState
                                                    .validate()) {
                                                  print(_newnewFormbuilderKey
                                                      .currentState.value);
                                                  print(
                                                    '  >>> Q1\'s value via separate print: {$qOne}',
                                                  );
                                                  print(
                                                    '  >>> Q3\'s value via separate print: {$qThree}',
                                                  );
                                                  print(
                                                    '   >>> Q11\'s value via separate print: {$qEleven}',
                                                  );
                                                  print(
                                                    '   >>> Q12\'s value via separate print: {$qTwelve}',
                                                  );
                                                  //print(_newFormbuilderKey.currentState.privacyChoice.value);
                                                } else {
                                                  print("validation failed");
                                                }
                                              },

                                              // END submit form when button pressed per 4.0.2 Readme and video https://www.youtube.com/watch?v=7FBELQq808M

                                              child: Text(
                                                "Finish Posting",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            )
                                          ]).show();
                                    },
                                    child: Text(
                                      "Next >",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                ],
                              ).show();
                            },
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GavTextField extends StatelessWidget {
  GavTextField(
      {@required this.maxCharLength,
      @required this.fieldAttribute,
      @required this.fieldLabelText});

  int maxCharLength;
  String fieldAttribute;
  String fieldLabelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FormBuilderTextField(
        name: '$fieldAttribute',
        // BEGIN countdown to max number of characters, per https://stackoverflow.com/a/64035861/1459653
        maxLength: maxCharLength,
        maxLines: null,
        buildCounter: (
          BuildContext context, {
          int currentLength,
          int maxLength,
          bool isFocused,
        }) {
          return Text(
            '${maxLength - currentLength}',
          );
        },
        // END countdown to max number of characters, per https://stackoverflow.com/a/64035861/1459653
        decoration: InputDecoration(
          labelText:
              '$fieldLabelText', // was "  Separate items,  with,  commas",
          //counterText: _textController.text.length.toString(),
          labelStyle: TextStyle(
            fontSize: 12.5,
            fontStyle: FontStyle.italic,
          ),
          //helperText: 'Separate, with, commas',
          //floatingLabelBehavior: ,

          // filled: true,
          // fillColor: Colors.lightBlue.withOpacity(0.05),

          // BEGIN change border if focus
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue),
            borderRadius: BorderRadius.circular(20.0),
          ),
          // END change border if focus

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(),
          ),
        ),
        textInputAction:
            TextInputAction.next, // moves user from one field to the next!!!!
        autofocus:
            false, // on screen load, first text field is already active - user can just start typing
      ),
    );
  }
} //</formstate>`

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: true,
  isOverlayTapDismiss: true,
  descTextAlign: TextAlign.start,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    color: Colors.black54,
  ),
  alertAlignment: Alignment.topCenter,
);

// BEGIN code from material_tag_editor
class _Chip extends StatelessWidget {
  const _Chip({
    @required this.label,
    @required this.onDeleted,
    @required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.blueGrey.shade100,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: Icon(
        Icons.cancel_rounded, // was "Icons.close,"
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
// END code from material_tag_editor

class SuperDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        bottom: 4.0,
      ),
      child: const Divider(
        color: Colors.white70,
        height: 30,
        thickness: 0.1,
        indent: 0,
        endIndent: 0,
      ),
    );
  }
}
