import 'dart:convert';
import 'package:bds_services_pvt_ltd/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _pickDateController = TextEditingController();

  String apiUrl = "https://www.whenisthenextmcufilm.com/api";
  late Map apiData;
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData({
    int days = 0,
  }) async {
    setState(() {
      isLoading = true;
    });

    DateTime pickedDate = DateTime.now().add(Duration(days: days));
    String api = apiUrl + "?date=" + pickedDate.toString().split(" ")[0];
    http.Response response = await http.get(Uri.parse(api));
    apiData = jsonDecode(response.body);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder datePickerfieldBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.orange,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuthMethods(FirebaseAuth.instance).signOut();
            },
            icon: Icon(Icons.logout),
            tooltip: "SignOut",
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Color.fromARGB(255, 2, 1, 0),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      apiData["title"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: "Releasing in "),
                        TextSpan(
                            text: apiData["days_until"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23)),
                        TextSpan(text: " days"),
                      ]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5 + 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        child: Image.network(
                          apiData["poster_url"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Type: ", style: TextStyle(fontSize: 17)),
                        TextSpan(
                            text: apiData["type"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17)),
                      ]),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      apiData["overview"],
                      style: TextStyle(),
                      textAlign: TextAlign.justify,
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Comming Next"),
                      ],
                    ),
                    ListTile(
                      leading: Image.network(
                          apiData["following_production"]["poster_url"]),
                      title: Text(apiData["following_production"]["title"]),
                      subtitle: Text(
                        apiData["following_production"]["overview"],
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        children: [
                          Text(
                              "Type: ${apiData["following_production"]["type"]}"),
                          Text(
                              "Releasing in \n${apiData["following_production"]["days_until"]} Days"),
                        ],
                      ),
                      onTap: () {
                        getData(
                            days: apiData["following_production"]
                                    ["days_until"] -
                                1);
                      },
                    ),
                    TextField(
                      controller: _pickDateController,
                      cursorColor: Colors.orange,
                      readOnly: true,
                      decoration: InputDecoration(
                        label: Text("Pick a Date"),
                        focusedBorder: datePickerfieldBorder,
                        border: datePickerfieldBorder,
                        enabledBorder: datePickerfieldBorder,
                        icon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2025, 02, 11),
                        );
                        if (pickedDate == null) {
                          _pickDateController.text = "";
                        } else {
                          _pickDateController.text =
                              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          getData(
                              days:
                                  pickedDate.difference(DateTime.now()).inDays);

                          // getData(days: Duration())
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
