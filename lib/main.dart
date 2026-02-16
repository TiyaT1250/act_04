import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
const MyApp({super.key});
// This widget is the root of your application.
@override
Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
// Application name
title: 'Stateful Widget',
theme: ThemeData(
primarySwatch: Colors.blue,
),
// A widget that will be started on the application startup
home: CounterWidget(),
);
}
}
class CounterWidget extends StatefulWidget {
@override
_CounterWidgetState createState() => _CounterWidgetState();
}
class _CounterWidgetState extends State<CounterWidget> {
//initial couter value
int _counter = 0;
 final List _lastCounters = [];
 

void _decrementCounter(){
  setState((){
  _lastCounters.add(_counter);
  _counter--;});
}
void _resetCounter(){
  setState((){ 
    _lastCounters.add(_counter);
    _counter = 0;
  
  });
}
void _displayPrevCounters() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Past Counters"),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: _lastCounters.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Value: ${_lastCounters[index]}"),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      );
    },
  );
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Interactive Counter'),
),

body: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Center(
child: Container(
color: _counter ==0? Colors.red: _counter>50? Colors.green: Colors.blue,
child: Text(
//displays the current number
'$_counter',
style: TextStyle(fontSize: 50.0),

),
),
),
Slider(
min: 0,
max: 100,
value: _counter.toDouble(),
onChanged: (double value) {
setState(() {
_lastCounters.add(_counter);
_counter = value.toInt();

});},
activeColor: Colors.blue,
inactiveColor: Colors.red,),

ElevatedButton(onPressed: _counter > 0? _decrementCounter: null, child: const Text("Decrement"),),
ElevatedButton(onPressed: _counter> 0?  _resetCounter: null, child: const Text("Reset")),
TextField(decoration: InputDecoration(helperText: 'Enter in a valid step value [0-100]'),),
ElevatedButton(onPressed: _displayPrevCounters, child: Text( "View past counters")),


],
),
);
}
}

