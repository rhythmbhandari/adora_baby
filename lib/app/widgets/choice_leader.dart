import 'package:chips_choice/chips_choice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/app_colors.dart';

class ChoiceLeader extends StatefulWidget {
  const ChoiceLeader({Key? key}) : super(key: key);

  @override
  ChoiceLeaderState createState() => ChoiceLeaderState();
}

class ChoiceLeaderState extends State<ChoiceLeader> {
// single choice value
  int tag = 3;

  // multiple choice value
  List<String> tags = [];

  // list of string options
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  List<String> optionsId = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  List<List<List<String>>> mainList = [
    [
      ['Allergy'],
      [
        'News',
        'Entertainment',
        'Politics',
        'Automotive',
        'Sports',
        'Education',
        'Fashion',
        'Travel',
        'Food',
        'Tech',
        'Science',
      ],
      [
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
      ]
    ],
    [
      ['Football'],
      [
        'Ronaldo',
        'Messi',
        'Ronaldinho',
        'Japan',
      ],
      [
        '0',
        '1',
        '2',
        '3',
      ]
    ],
  ];

  String? user;
  final usersMemoizer = C2ChoiceMemoizer<String>();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();
  List<String> formValue = [];

  Future<List<C2Choice<String>>> getUsers() async {
    try {
      String url =
          "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      return C2Choice.listFrom<String, dynamic>(
        source: res.data['results'],
        value: (index, item) => item['email'],
        label: (index, item) =>
            item['name']['first'] + ' ' + item['name']['last'],
        avatarImage: (index, item) =>
            NetworkImage(item['picture']['thumbnail']),
        meta: (index, item) => item,
      )..insert(0, const C2Choice<String>(value: 'all', label: 'All'));
    } on DioError catch (e) {
      throw ErrorDescription(e.message);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ChipsChoice'),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.primary500, // You can use this as well
          statusBarIconBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark
          statusBarBrightness: Brightness.light, // OR Vice Versa for ThemeMode.dark

        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _about(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
            itemCount: mainList.length,
            itemBuilder: (BuildContext context, int index) {
              return Content(
                title: mainList[index][0][0],
                child: ChipsChoice<String>.multiple(
                  value: tags,
                  onChanged: (val) {
                    setState(() => tags = val);
                    print('Tags is $tags');
                    print('Value is $val');
                  },
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: mainList[index][2],
                    value: (i, v) => v,
                    label: (i, optionsId) => mainList[index][1][i],
                    tooltip: (i, v) => v,
                  ),
                  choiceStyle: C2ChipStyle.toned(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),

                  ),

                  choiceCheckmark: true,
                  textDirection: TextDirection.ltr,
                  wrapped: true,
                ),
              );
            }),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final Function(bool selected) onSelect;

  const CustomChip({
    Key? key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              left: 9,
              right: 9,
              bottom: 7,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final String title;
  final Widget child;

  const Content({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            // color: Colors.blueGrey[50],
            child: Text(
              widget.title,
              style: const TextStyle(
                // color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Flexible(fit: FlexFit.loose, child: widget.child),
        ],
      ),
    );
  }
}

void _about(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              'chips_choice',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.black87),
            ),
            subtitle: const Text('by davigmacode'),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Easy way to provide a single or multiple choice chips.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black54),
                  ),
                  Container(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
