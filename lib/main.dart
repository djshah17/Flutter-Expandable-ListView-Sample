import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Expandable List Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<League> data = <League>[
    League(
      'Premier League',
      <Club>[
        Club(
          'Liverpool',
          <Player>[
            Player('Virgil van Dijk'),
            Player('Mohamed Salah'),
            Player('Sadio Mané'),
          ],
        ),
        Club(
          'Manchester City',
          <Player>[
            Player('Kevin De Bruyne'),
            Player('Sergio Aguero'),
          ],
        ),
      ],
    ),
    League(
      'La Liga',
      <Club>[
        Club(
          'Real Madrid',
          <Player>[
            Player('Sergio Ramos'),
            Player('Karim Benzema'),
          ],
        ),
        Club(
          'Barcelona',
          <Player>[
            Player('Lionel Messi'),
          ],
        ),
      ],
    ),
    League(
      'Ligue One',
      <Club>[
        Club(
          'Paris Saint-Germain',
          <Player>[
            Player('Neymar Jr.'),
            Player('Kylian Mbappé'),
          ],
        ),
      ],
    ),
    League(
      'Bundeshliga',
      <Club>[
        Club(
          'Bayern Munich',
          <Player>[
            Player('Robert Lewandowski'),
            Player('Manuel Neuer'),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            MyExpandableWidget(data[index]),
        itemCount: data.length,
      ),
    );
  }
}

class MyExpandableWidget extends StatelessWidget {
  final League league;

  MyExpandableWidget(this.league);

  @override
  Widget build(BuildContext context) {
    if (league.listClubs.isEmpty)
      return ListTile(title: Text(league.leagueName));
    return ExpansionTile(
      key: PageStorageKey<League>(league),
      title: Text(league.leagueName, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
      children: league.listClubs
          .map<Widget>((club) => showClubs(club))
          .toList(),
    );
  }
}

showClubs(Club club) {
  return new ExpansionTile(
    key: PageStorageKey<Club>(club),
    title: Text(club.clubName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.purpleAccent),),
    children: club.listPlayers.map<Widget>((player) => showPlayers(player)).toList(),
  );
}

showPlayers(Player player) {
  return new ListTile(
    title: new Text(
      player.playerName,
      style: new TextStyle(fontSize: 20),
    ),
  );
}

class League {
  String leagueName;
  List<Club> listClubs;

  League(this.leagueName, this.listClubs);
}

class Club {
  String clubName;
  List<Player> listPlayers;

  Club(this.clubName, this.listPlayers);
}

class Player {
  String playerName;

  Player(this.playerName);
}
