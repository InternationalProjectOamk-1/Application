import 'package:flutter/material.dart';
import 'package:mapplication/styles/home_style.dart';
import 'package:mapplication/widgets/profile_button.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

DateTime _selectedStart = DateTime.now();
DateTime _selectedEnd = DateTime.now();

class _CreateEventScreenState extends State<CreateEventScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController _titleController = TextEditingController();
    TextEditingController _placeController = TextEditingController();
    TextEditingController _interestsController = TextEditingController();
    TextEditingController _numberOfPeopleController = TextEditingController();

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
                            decoration: myCreateEventCustom,
                            child: TextField(
                              controller: _placeController,
                              onSubmitted: (String value) => print(value),
                              decoration: const InputDecoration(
                                hintText: "Place",
                                prefixIcon: Icon(Icons.map),
                                border: InputBorder.none,
                              ),
                            ),
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
                              if (_titleController.text != "") {
                                if (_placeController.text != "") {
                                  if (_interestsController.text != "") {
                                    if (_numberOfPeopleController.text != "") {
                                      print("Works!");
                                    }
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