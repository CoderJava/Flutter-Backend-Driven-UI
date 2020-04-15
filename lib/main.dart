import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dynamic Widget'),
      ),
      body: FutureBuilder(
        future: _buildWidget(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('${snapshot.error}');
          }
          return snapshot.hasData
              ? SizedBox.expand(child: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<Widget> _buildWidget(context) async {
    var jsonHelloWorld = '''
    {
      "type": "Center",
      "child": {
        "type": "Text",
        "data": "Hello World Dynamic Widget"
      }
    }  
    ''';
    await Future.delayed(Duration(seconds: 2));
    return DynamicWidgetBuilder.build(jsonHelloWorld, context, DefaultClickListener());
  }
}

class DefaultClickListener extends ClickListener {
  @override
  void onClicked(String event) {
    // TODO: do something in here  
  }
}
