import 'package:flutter/material.dart';

class TweetNow extends StatefulWidget {
  const TweetNow({Key? key}) : super(key: key);

  @override
  State<TweetNow> createState() => _TweetNowState();
}

class _TweetNowState extends State<TweetNow> {
  String? _chosenValue = "Public";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(),actions: [Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: OutlinedButton(
            onPressed: () {},
            child: const Text("Tweet")),
      ),],
        backgroundColor: Colors.black87,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  minRadius: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        borderRadius: BorderRadius.circular(30),
                        value: _chosenValue,
                        //elevation: 5,
                        items: <String>[
                          'Public',
                          'Private',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 13),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenValue = value ?? "Public";
                          });
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(70, 0, 12, 0),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              style: const TextStyle(fontSize: 18),
              maxLines: 15,
              cursorHeight: 25,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's happening?",
                  hintStyle: TextStyle(fontSize: 20)),
            ),
          )),
        ],
      ),
    );
  }
}
