import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/network_component/view/network_screen.dart';
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
        body: providerw!.isNetwork?
        Stack(
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
                                elevation: const WidgetStatePropertyAll(0),
                                shape: const WidgetStatePropertyAll(
                                    BeveledRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
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
                              padding: const EdgeInsets.only(top:30),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'detail',
                                      arguments: providerW!.model);
                                },
                                child: Text(
                                  "${model.name}",
                                  style: const TextStyle(fontSize: 50),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "latitude of city: \n${model.coordModel!.lat}",
                                  style: const TextStyle(fontSize: 17),
                                ),
                                Text(
                                  "longitude of city: \n${model.coordModel!.lon}",
                                  style: const TextStyle(fontSize: 17),
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
        ):Network_Widget());
  }
}
