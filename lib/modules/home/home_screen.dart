import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stop_watch_app/modules/constants/constants.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int seconds=0;      String digitSecond='00';

  int minutes=0;     String digitMinutes='00';

  int hours=0;       String digitHours='00';

  Timer? timer;      bool started=false;    List laps=[];


void stopTimer() {
  timer!.cancel();
  setState(() {
    started = false;

  });
}       void resetTimer(){
  timer!.cancel();
  setState(() {
     seconds=0;       digitSecond='00';

     minutes=0;      digitMinutes='00';

     hours=0;        digitHours='00';

     started=false;
  });
}
void addLapsnum(){
  String lap = '$digitHours : $digitMinutes : $digitSecond';
  setState(() {
    laps.add(lap);
  });
}       void startTimer(){
  started=true;
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    int localSeconds = seconds+1;
    int localMinutes = minutes;
    int localHours = hours;

    if(localSeconds > 59)
      {
        if(localMinutes >  59)
          {
            localHours++;   localMinutes=0;
          }
        else
          {
            localMinutes++;
            localSeconds=0;
          }
      }
           setState(() {
             seconds=localSeconds;
             minutes=localMinutes;
             hours=localHours;
             digitSecond=(seconds >= 10) ? '$seconds' : '0$seconds';
             digitHours=(hours >= 10) ? '$hours' : '0$hours';
             digitMinutes=(minutes >= 10) ? '$minutes' : '0$minutes';

           });

  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Center(
                  child: Text(
                    'StopWatch App',
                    style: TextStyle(
                    fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: MainColor,
                    ),
                  ),
                ),
              SizedBox(height: 20.0,),
              Center(
                  child: Text(
                      '$digitHours:$digitMinutes:$digitSecond',
                    style: TextStyle(
                      fontSize: 82.0,
                      fontWeight: FontWeight.w600,
                      color: MainColor,
                    ),
                  ),
              ),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color:  Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context , index)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:
                          [
                            Text(
                              'Lab_Number_${index+1}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: MainColor,
                              ),
                            ),
                            Text(
                              '${laps[index]}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: MainColor,
                              ),
                            ),

                          ],
                        ),
                      );
                    },
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Expanded(
                     child: RawMaterialButton(
                         onPressed: ()
                         {

                           (!started) ? startTimer() : stopTimer();

                         },
                       shape: StadiumBorder(
                         side: BorderSide(color: MainColor2,),
                       ),
                       child: Text(
                         (!started) ? 'Start' : 'Pause',
                         style: TextStyle(
                           color: MainColor,
                         ),
                       ),
                     ),
                   ),
                  SizedBox(width: 8.0,),
                  IconButton(
                      onPressed: ()
                      {
                         addLapsnum();
                      },
                      icon: Icon(
                          Icons.flag,
                        color: MainColor,

                      ),
                  ),
                  SizedBox(width: 8.0,),
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: ()
                      {
                        resetTimer();

                      },
                      fillColor: MainColor2,
                      shape: StadiumBorder(

                      ),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: MainColor,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
