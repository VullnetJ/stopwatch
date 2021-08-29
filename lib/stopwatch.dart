import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {

  static const route = '/stopwatch';
  
  final String name;
  final String email;
  const StopWatch({ required this.name, required this.email});


  @override

  StopWatchState createState() => StopWatchState();
}

class StopWatchState extends State<StopWatch> {

  final itemHeight = 60.0;
  final scrollController = ScrollController();
  bool isTicking = true;
  late int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];

  void _onTick(Timer time) {
    
    setState(() {
    milliseconds += 100;
    });
  }
 void startTimer() {

   timer = Timer.periodic(Duration(seconds: 1), _onTick);
  setState(() {
    isTicking = true;
    laps.clear();
  });
}

void stopTimer() {
  timer.cancel();
  setState(() {
    isTicking = false;
  });
  final totalRuntime = laps.fold(milliseconds, (total, lap) => "$total! + $lap");
  
}
String _secondstext(int milliseconds) {
  final seconds = milliseconds /1000;
  return '$seconds seconds';
}

void _lap() {
  setState(() {
    laps.add(milliseconds);
    milliseconds = 0;
  });
  scrollController.animateTo(
    itemHeight*laps.length, 
    duration: Duration(milliseconds: 500), 
    curve: Curves.easeIn);
}

  
  @override
  Widget build(BuildContext context) {
    

    String _secondsText() => milliseconds ==1 ? 'millisecond' : 'milliseconds';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(child: _buildCounter(_secondsText, context)),
          Expanded(child: _buildLapDisplay(),),
        ],
      ),
    );
  }

  Widget _buildCounter(String _secondsText(), BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
            .textTheme
            .subtitle1         
          ),
          Text(
            _secondstext(milliseconds),
            style: Theme.of(context)
            .textTheme.headline5,
          ),
          SizedBox(height: 20,),
          _buildControls(),
          SizedBox(height: 20,),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            ),
            child: Text('Lap'),
            onPressed: isTicking? _lap: null),
            SizedBox(width: 20,),
           ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty
                  .all<Color>(Colors.orangeAccent),
                  foregroundColor: MaterialStateProperty
                  .all<Color>(Colors.white),
                  ),
                child: Text('Stop'),
                onPressed: isTicking ? stopTimer : null,
              ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ElevatedButton(
              child: Text('Start'),
              onPressed: isTicking
                  ? null
                  : () {
                    milliseconds = 1;
                      timer = Timer.periodic(Duration(seconds: 1), _onTick);
  
                      setState(() {
                        
                        isTicking = true;
                      });
                    },
            ),
          ],
        );
  }
  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
        final milliseconds = laps[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 50 ),
          title: Text('Lap ${index + 1}'),
          trailing: Text(_secondstext(milliseconds)),
        );
        },
        
      ),
    );
  }
  @override 
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
