import "dart:async";

import "package:flutter/material.dart";

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartingState();
  }
}

class _StartingState extends State<StartingScreen> {
  String startPause = "Start";

  int seconds = 0, minutes = 0, hours = 0;

  late Timer? timer;

  String digitalSeconds = "00";
  String digitalMinutes = "00";
  String digitalHours = "00";

  List<String> laps = [];

  Widget playIcon = const Icon(
    Icons.play_arrow,
    color: Color.fromARGB(132, 0, 0, 0),
    size: 24.0,
  );

  Widget pauseIcon = const Icon(
    Icons.pause,
    color: Color.fromARGB(132, 0, 0, 0),
    size: 24.0,
  );

  Widget resetIcon = const Icon(
    Icons.restart_alt_rounded,
    color: Color.fromARGB(132, 0, 0, 0),
    size: 24.0,
  );

  Widget recordIcon = const Icon(
    Icons.flag,
    color: Color.fromARGB(132, 0, 0, 0),
    size: 24.0,
  );

  void onStart() {
    //changing current condition
    startPause = "Pause";
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTimer();
    });
  }

  void onStop() {
    //changing condition for startPause

    timer!.cancel();
    setState(() {
      startPause = "Start";
    });
  }

  void onReset() {
    timer!.cancel();

    setState(() {
      startPause = "Start";
      seconds = 0;
      minutes = 0;
      hours = 0;

      laps.clear();

      digitalSeconds = "00";
      digitalMinutes = "00";
      digitalHours = "00";
    });
  }

  void onRecord() {
    setState(() {
      // digitalSeconds = seconds < 10 ? "0$seconds" : "$seconds";
      // digitalMinutes = minutes < 10 ? "0$minutes" : "$minutes";
      // digitalHours = hours < 10 ? "0$hours" : "$hours";
      laps.add("$digitalHours $digitalMinutes $digitalSeconds");
    });
  }

  void updateTimer() {
    setState(() {
      seconds++;
      if (seconds > 59) {
        seconds = 0;
        minutes++;
        if (minutes > 59) {
          minutes = 0;
          hours++;
        }
      }

      digitalSeconds = seconds < 10 ? "0$seconds" : "$seconds";
      digitalMinutes = minutes < 10 ? "0$minutes" : "$minutes";
      digitalHours = hours < 10 ? "0$hours" : "$hours";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            "STOPWATCH",
            style: TextStyle(color: Color.fromARGB(132, 0, 0, 0), fontSize: 24),
          ),

          Container(
            margin: const EdgeInsets.all(20),
            alignment: Alignment.center,
            height: 300,
            decoration: const  BoxDecoration(
              shape: BoxShape.circle,
              color:  Color.fromARGB(255, 156, 184, 249),

            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$digitalHours :  $digitalMinutes :  $digitalSeconds",
                  style: const TextStyle(
                      fontSize: 40, color: Color.fromARGB(132, 0, 0, 0)),
                ),
              ],
            ),
          ),

         

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: startPause == "Start" ? onStart : onStop,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 156, 184, 249)),
                    child: startPause == "Start" ? playIcon : pauseIcon,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: onReset,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 156, 184, 249)),
                    child: resetIcon,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: onRecord,
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 156, 184, 249)),
                    child: recordIcon,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "LAPS",
            style: TextStyle(fontSize: 24, color: Color.fromARGB(132, 0, 0, 0)),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: laps.map((element) {
                return Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 156, 184, 249),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(element),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
