import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pizza_app/models/pizza.dart';
import 'package:pizza_app/details.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pizza App",
      home: PizzaHome(),
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: "slabo"),
    );
  }
}

class PizzaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey);
    return Scaffold(

      body: MainApp(),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(left: 50, right: 30),
      child: ListView(
        children: <Widget>[
          Column(

            children: <Widget>[
              titleBar(),
              tabs(),
            ],
          )
        ],
      ),
    );
  }

  Widget titleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              "Featured",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 50),
            ),
            Text("Food", style: TextStyle(fontSize: 50)),
          ],
        ),
      ],
    );
  }

  Widget tabs() {
    return Container(
      constraints: BoxConstraints.expand(height: 580),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(

            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: SafeArea(
                child: TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.only(top: 15),
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      fontFamily: "slabo"),
                  unselectedLabelColor: Colors.black54,
                  unselectedLabelStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w200,
                      fontFamily: "slabo"),
                  tabs: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text("Pizza"),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text("Rolls"),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text("Burgers"),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text("Sandwiches"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              pizzaShowCase(),
              Center(
                child: Text(
                  "Rolls Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Burgers Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  "Sandwiches Tab",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pizzaShowCase() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pizzaList.pizzas.length,
        itemBuilder: (BuildContext context, int index) {
          return ListOfPizzas(
            name: pizzaList.pizzas[index].name,
            image: pizzaList.pizzas[index].image,
            price: pizzaList.pizzas[index].price,
            background: pizzaList.pizzas[index].background,
            foreground: pizzaList.pizzas[index].foreground,
            pizzaObject: pizzaList.pizzas[index],
          );
        },
      ),
    );
  }
}

class ListOfPizzas extends StatelessWidget {
  final Color foreground;
  final Color background;
  final double price;
  final String name;
  final String image;
  final Pizza pizzaObject;

  ListOfPizzas(
      {this.foreground,
      this.background,
      this.price,
      this.name,
      this.image,
      this.pizzaObject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Details(pizzaObject)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          width: 225,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Image.asset(image),
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                softWrap: true,
                text: TextSpan(
                  style: TextStyle(
                      color: foreground, fontSize: 25, fontFamily: "slabo"),
                  children: [
                    TextSpan(text: name),
                    TextSpan(
                      text: "\nPizza",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "\$$price",
                      style: TextStyle(
                        fontFamily: "arial",
                        fontSize: 20,
                        color: foreground,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  StatefulFavIcon(
                    foreground: foreground,
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

class StatefulFavIcon extends StatefulWidget {
  const StatefulFavIcon({@required this.foreground});

  final Color foreground;

  @override
  _StatefulFavIconState createState() => _StatefulFavIconState();
}

class _StatefulFavIconState extends State<StatefulFavIcon> {
  bool isFav;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },

      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: widget.foreground,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final double _size = 60;
  final double _padding = 17;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
//      color: Colors.transparent,
      elevation: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: _size + 15,
            width: _size + 15,
            padding: EdgeInsets.all(_padding),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: Icon(Icons.control_point,size: 30,),
          ),
          Container(
            height: _size,
            width: _size,
            padding: EdgeInsets.all(_padding),
            child: Image.asset(
              "assets/home_icon.png",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            height: _size,
            width: _size,
            padding: EdgeInsets.all(_padding),
            child: Image.asset(
              "assets/search_icon.png",
              fit: BoxFit.contain,
            ),
          ),
          Container(
            height: _size,
            width: _size,
            padding: EdgeInsets.all(_padding),
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              "assets/bag_icon.png",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
