import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapplication/components/select_event_location.dart';
import 'package:mapplication/models/event_model.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/widgets/profile_button.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

DateTime _selectedStart = DateTime.now();
DateTime _selectedEnd = DateTime.now();
TextEditingController _titleController = TextEditingController();
TextEditingController _placeController = TextEditingController();
TextEditingController _interestsController = TextEditingController();
TextEditingController _numberOfPeopleController = TextEditingController();
var selectedPlace = "";
const tempUser = 9;
var posLat;
var posLng;

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    LatLng pos;

    changePlace(BuildContext context) async {
      pos = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectEventLocation()));
      setState(() {
        selectedPlace = 'Selected';
        posLat = pos.latitude;
        posLng = pos.longitude;

        print(selectedPlace);
      });
    }

    return Scaffold(
      backgroundColor: Colors.orange[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: const Alignment(0, 0.3),
                child: Container(
                  decoration: myProfileCustom,
                  child: SizedBox(
                    width: size.width * .8,
                    height: size.height * .6,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            decoration: myCreateEventCustom,
                            child: TextField(
                              controller: _titleController,
                              onSubmitted: (String value) => print(value),
                              decoration: const InputDecoration(
                                hintText: "Title",
                                prefixIcon: Icon(Icons.title),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Divider(height: 10),
                          Container(
                            height: 50,
                            decoration: myCreateEventCustom,
                            child: Row(children: <Widget>[
                              const Icon(Icons.place),
                              TextButton(
                                  onPressed: () => changePlace(context),
                                  child: selectedPlace == ""
                                      ? const Text(
                                          "Select place",
                                        )
                                      : Text(selectedPlace)),
                            ]),
                          ),
                          const Divider(height: 10),
                          Container(
                            decoration: myCreateEventCustom,
                            child: TextField(
                              controller: _interestsController,
                              onSubmitted: (String value) => print(value),
                              decoration: const InputDecoration(
                                hintText: "Interests",
                                prefixIcon: Icon(Icons.sports_cricket),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Divider(height: 10),
                          Container(
                            decoration: myCreateEventCustom,
                            child: TextField(
                              controller: _numberOfPeopleController,
                              onSubmitted: (String value) => print(value),
                              decoration: const InputDecoration(
                                hintText: "Number of people",
                                prefixIcon: Icon(Icons.people),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          const Divider(height: 10),
                          Container(
                            height: 50,
                            decoration: myCreateEventCustom,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Icon(Icons.date_range),
                                TextButton(
                                  onPressed: () => showDatePicker(
                                    context: context,
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2025),
                                  ).then(
                                    (value) =>
                                        setState(() => _selectedStart = value!),
                                  ),
                                  child: Text(
                                    "${_selectedStart.day}/${_selectedStart.month}/${_selectedStart.year}",
                                  ),
                                ),
                                const Icon(Icons.arrow_right_alt),
                                TextButton(
                                  onPressed: () => showDatePicker(
                                    context: context,
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2025),
                                  ).then(
                                    (value) =>
                                        setState(() => _selectedEnd = value!),
                                  ),
                                  child: Text(
                                    "${_selectedEnd.day}/${_selectedEnd.month}/${_selectedEnd.year}",
                                  ),
                                )
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              print('ONPRESS');
                              if (_titleController.text != "") {
                                print('ONTITLE');
                                print('ONINTERESTS');
                                if (_numberOfPeopleController.text != "") {
                                  if (posLat != 0 && posLng != 0) {
                                    print('CURRENTLY AT BUTTON');
                                    print(_selectedStart);
                                    createEvent(
                                        'description',
                                        _titleController.text,
                                        [0, 1],
                                        true,
                                        posLat,
                                        posLng,
                                        tempUser,
                                        4,
                                        2,
                                        "2022-05-16T09:12:46.042",
                                        false);
                                  }
                                }
                              }
                            },
                            child: const Text("Create event"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ProfileButton(
                icon: Icons.keyboard_return,
                press: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
