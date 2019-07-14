import 'dart:ui';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pizza_app/models/food.dart';
import 'package:pizza_app/view/details.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/api/service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodHome extends StatelessWidget {
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
              FutureTab(),
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
}

class FutureTab extends StatefulWidget {
  @override
  _FutureTabState createState() => _FutureTabState();
}

class _FutureTabState extends State<FutureTab> {
  FoodList foodList;

  @override
  void initState() {
    foodList = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return futureTabs();
  }

  Widget futureTabs() {
    return Container(
      constraints: BoxConstraints.expand(height: 580),
      child: FutureBuilder<FoodList>(
        future: Service.fetchData(),
        builder: (context, snapshot) {
          if (foodList == null) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                foodList = snapshot.data;
                return tabs(foodList);
              } else {
                return errorWidget(snapshot.error.toString());
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return errorWidget("some thing Wrong");
            }
          } else {
            return tabs(foodList);
          }

          // By default, show a loading spinner.
        },
      ),
    );
  }

  Widget tabs(FoodList foodList) {
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
              foodShowCase(foodList.foods, FoodType.Pizza),
              foodShowCase(foodList.foods, FoodType.Rolls),
              foodShowCase(foodList.foods, FoodType.Burgers),
              foodShowCase(foodList.foods, FoodType.Sandwiches),
            ],
          ),
        ),
      ),
    );
  }

  Widget foodShowCase(List<Food> foods, FoodType foodType) {

    List<Food> filteredFood =
        foods.where((food) => food.foodType == foodType).toList();

    if (filteredFood.length <= 0) {
      return Center(
        child: Text(
          "Data Not Found",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: filteredFood.length,
          itemBuilder: (BuildContext context, int index) {
            return ListOfFoods(
              name: filteredFood[index].name,
              image: filteredFood[index].image,
              price: filteredFood[index].price,
              background: Color(filteredFood[index].background),
              foreground: Color(filteredFood[index].foreground),
              foodObject: filteredFood[index],
            );
          },
        ),
      );
    }
  }

  Widget errorWidget(Object error) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.red, width: 1),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10, // has the effect of softening the shadow
              offset: Offset(
                0, // horizontal, move right 10
                8.0, // vertical, move down 10
              ),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              error.toString(),
              style: TextStyle(
                fontFamily: "arial",
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Text(
                "Try Again",
                style: TextStyle(fontSize: 18),
              ),
              color: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                  //
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class ListOfFoods extends StatelessWidget {
  final Color foreground;
  final Color background;
  final double price;
  final String name;
  final String image;
  final Food foodObject;

  ListOfFoods(
      {this.foreground,
      this.background,
      this.price,
      this.name,
      this.image,
      this.foodObject});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Details(foodObject)));
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
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                  errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.perm_scan_wifi, size: 48),
                      ),
                ),
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
                      text: "\ ${foodObject.foodType.toString()}",
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
            child: Icon(
              Icons.settings,
              size: 30,
            ),
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
