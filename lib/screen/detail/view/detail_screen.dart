import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/model/home_model.dart';
import '../../home/provider/home_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getWeatherAPI("surat");
  }

  TextEditingController textEditingController = TextEditingController();
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              providerR!.isTheme == false ? Colors.blue.shade400 : Colors.blue.shade900,
          title: const Text("Today's Weather "),
          actions: [
            IconButton(
              onPressed: () {
                providerR!.setThemeData();
              },
              icon: Icon(
                providerW!.isTheme == false
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      colors: providerR!.isTheme == false
                          ? [Colors.white, Colors.blue]
                          : [Colors.grey, Colors.blue.shade900],
                      end: Alignment.topRight)),
            ),
            // Image.asset("assets/image/c3.jpg",
            //   height: MediaQuery.sizeOf(context).height-20,fit: BoxFit.cover,),
            FutureBuilder(
                future: context.watch<HomeProvider>().model,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    HomeModel? model = snapshot.data;
                    if (model == null) {
                      const Text("Not Available");
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: SearchBar(
                            //     controller: textEditingController,
                            //     hintText: "Search City ",
                            //     elevation: const WidgetStatePropertyAll(0),
                            //     shape: const WidgetStatePropertyAll(
                            //         BeveledRectangleBorder(
                            //             borderRadius: BorderRadius.horizontal(
                            //               left: Radius.circular(15),
                            //               right: Radius.circular(15),
                            //             ))),
                            //     trailing: [
                            //       IconButton(
                            //         onPressed: () {
                            //           context
                            //               .read<HomeProvider>()
                            //               .getWeatherAPI(
                            //               textEditingController.text);
                            //         },
                            //         icon: const Icon(Icons.search),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
                                  Text(
                                    "${model.name}",
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                  const Text("Clouds",style: TextStyle(fontSize: 16),)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "latitude: ${model.coordModel!.lat}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "longitude: ${model.coordModel!.lon}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Pressure: ${model.mainModel!.pressure}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text("Wind Speed: ${model.mainModel!.pressure}",
                                      style: const TextStyle(fontSize: 17),)
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Max Temp: ${model.mainModel!.temp_max}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "Min Temp: ${model.mainModel!.temp_min}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Feels like: ${model.mainModel!.feels_like}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      "Humidity: ${model.mainModel!.humidity}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("25/07 Today"),
                                      Text("☀️"),
                                      Text("18/33"),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("24/07 Wed"),
                                    Text("   🌨️"),
                                    Text("17/33"),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("23/07 Tue"),
                                    Text("    🌤"),
                                    Text("18/31"),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("22/07 Mon"),
                                    Text("   🌤️"),
                                    Text("14/33"),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("21/07 Sun"),
                                    Text("    🌨"),
                                    Text("16/36"),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("21/07 Sat"),
                                    Text("      ☀️"),
                                    Text("20/33"),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("19/07 Fri"),
                                    Text("       ☀️"),
                                    Text("19/30"),
                                  ],
                                ),
                              ],
                            ),
                            //Image.asset("assets/image/dummyc2.jpg"),
                          ],
                        ),
                      );
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ],
        ));
  }
}
/*
*
* "25/Today', '☀️', '20/33'\n"
                                        "26/07 Wed', '🌨️', '18/33'\n"
                                        "23/07 Tue', '🌤️', '17/31'\n"
                                        "22/07 Mon', '🌤️', '14/30'\n"
                                        "21/07 Sun', '🌨️', '16/35'\n"
                                        "20/07 Sat', '☀️', '20/30'\n"
                                        "19/07 Fri', '🌤️', '17/31'\n"*/
