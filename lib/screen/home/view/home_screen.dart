import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/network_component/view/network_screen.dart';
import 'package:weather_app/screen/home/model/home_model.dart';
import 'package:weather_app/screen/home/provider/home_provider.dart';
import '../../../network_component/provider/network_provider.dart';
import '../model/home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getWeatherAPI("surat");
    context.read<NetworkProvider>().checkConnection();
  }

  HomeProvider? providerR;
  HomeProvider? providerW;
  NetworkProvider? providerw;
  NetworkProvider? providerr;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    providerr = context.read<NetworkProvider>();
    providerw = context.watch<NetworkProvider>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              providerR!.isTheme == false ? Colors.blue : Colors.blue.shade900,
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
        body: providerw!.isNetwork
            ? Stack(
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SearchBar(
                                      controller: textEditingController,
                                      hintText: "Search City ",
                                      elevation:
                                          const WidgetStatePropertyAll(0),
                                      shape: const WidgetStatePropertyAll(
                                          BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                        left: Radius.circular(15),
                                        right: Radius.circular(15),
                                      ))),
                                      trailing: [
                                        IconButton(
                                          onPressed: () {
                                            context
                                                .read<HomeProvider>()
                                                .getWeatherAPI(
                                                    textEditingController.text);
                                          },
                                          icon: const Icon(Icons.search),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, 'detail',
                                            arguments: providerW!.model);
                                      },
                                      child: SingleChildScrollView(
                                        scrollDirection:Axis.vertical,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                      style: const TextStyle(
                                                          fontSize: 20,

                                                      ),
                                                    ),
                                                    Text(
                                                      "${DateTime.now().hour}:${DateTime.now().minute}",
                                                      style: const TextStyle(
                                                        fontSize: 30,

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  "⛅",
                                                  style: TextStyle(fontSize: 100),
                                                ),
                                                const SizedBox(width: 25),
                                                Text(
                                                  "${model.name}",
                                                  style: const TextStyle(
                                                      fontSize: 40),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${model.weatherList![0].main}"),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  " 🌡: ${model.mainModel!.temp!.toInt()}°C",
                                                  style: const TextStyle(
                                                      fontSize: 30),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xff5AB2FF),Color(0xff03AED2),
                                        ]
                                          //A0DEFF
                                    ),
                                      // color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Sunrise ☀️ :   ${DateTime.fromMillisecondsSinceEpoch(model.sysModel!.sunrise! * 1000)}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff03AED2),Color(0xff5AB2FF),
                                          ]
                                      ),
                                      //color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Sunset 🌤 :  ${DateTime.fromMillisecondsSinceEpoch(model.sysModel!.sunset! * 1000)}",
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   height: 50,
                                      //   width: 180,
                                      //   decoration: BoxDecoration(
                                      //     gradient: const LinearGradient(
                                      //         begin: Alignment.centerRight,
                                      //         end: Alignment.centerLeft,
                                      //         colors: [
                                      //           Color(0xff03AED2),Color(0xff5AB2FF),
                                      //         ]
                                      //     ),
                                      //     //color: Colors.white.withOpacity(0.2),
                                      //     borderRadius: BorderRadius.circular(10),
                                      //   ),
                                      //   child: Text(
                                      //     "Latitude:  ${model.coordModel!.lat}",
                                      //     style: const TextStyle(fontSize: 17),
                                      //   ),
                                      // ),
                                      // Container(
                                      //   alignment: Alignment.center,
                                      //   height: 50,
                                      //   width: 180,
                                      //   decoration: BoxDecoration(
                                      //     gradient: const LinearGradient(
                                      //         begin: Alignment.centerLeft,
                                      //         end: Alignment.centerRight,
                                      //         colors: [
                                      //           Color(0xff03AED2),Color(0xff5AB2FF),
                                      //         ]
                                      //     ),
                                      //     //color: Colors.white.withOpacity(0.2),
                                      //     borderRadius: BorderRadius.circular(10),
                                      //   ),
                                      //   child: Text(
                                      //     "Longitude:  ${model.coordModel!.lon}",
                                      //     style: const TextStyle(fontSize: 17),
                                      //   ),
                                      // ),
                                    //],
                                  //),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 100,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xff5AB2FF),Color(0xff03AED2),
                                                  ]
                                              ),
                                              //color: Colors.white.withOpacity(0.2),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: const Align(
                                              alignment:Alignment.center,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(" 25/07 \n Today"),
                                                  Text("☀️",style: TextStyle(fontSize: 20),),
                                                  Text("18/33"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                            alignment:Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("24/07 \n Wed"),
                                                Text("🌨️",style: TextStyle(fontSize: 20),),
                                                Text("17/33"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                            alignment:Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("23/07\n  Tue"),
                                                Text("🌤",style: TextStyle(fontSize: 20),),
                                                Text("18/31"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                              alignment:Alignment.center,
                                              child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                              Text(" 22/07 \n  Mon"),
                                              Text("🌤",style: TextStyle(fontSize: 20),),
                                              Text("14/33"),
                                              ],
                                              ),
                                              ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                            alignment:Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text("21/07\n  Sun"),
                                                Text("🌨️",style: TextStyle(fontSize: 20),),
                                                Text("16/33"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                            alignment:Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(" 21/07 \n   Sat"),
                                                Text("☀️",style: TextStyle(fontSize: 20),),
                                                Text("19/32"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          height: 100,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color(0xff5AB2FF),Color(0xff03AED2),
                                                ]
                                            ),
                                            //color: Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Align(
                                            alignment:Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(" 19/07 \n    Fri"),
                                                Text("🌨",style: TextStyle(fontSize: 20),),
                                                Text("15/33"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),

                                      ],
                                    ),
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
              )
            : const Network_Widget());
  }
}
