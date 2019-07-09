import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:pizza_app/models/pizza.dart';
import 'dart:ui';

class Details extends StatelessWidget {
  Details(this.pizzaObject);

  final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(pizzaObject.background);
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                BackgroundArc(pizzaObject.background),
                ForegroundContent(pizzaObject: pizzaObject)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ForegroundContent extends StatelessWidget {
  const ForegroundContent({this.pizzaObject});

  final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 30, left: 30),
            child: Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 36,
                ),
              ),
            ),
          ),
        ),
        PizzaImage(pizzaObject.image),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(left: 85, right: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(pizzaObject.name),
              SizedBox(height: 25),
              StarRating(pizzaObject.starRating, color:pizzaObject.background),
              SizedBox(height: 15),
              Description(pizzaObject.desc),
              SizedBox(height: 15),
              Price(pizzaObject.price),
              SizedBox(height: 30),
              BottomButtons(pizzaObject.background),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PizzaImage extends StatelessWidget {
  final String pizzaImage;

  PizzaImage(this.pizzaImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: Image.asset(pizzaImage),
    );
  }
}

class TitleText extends StatelessWidget {
  final String pizzaName;
  final double _fontSize = 40;

  TitleText(this.pizzaName);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: pizzaName,
          style: TextStyle(
              color: Colors.black,
              fontSize: _fontSize,
              fontWeight: FontWeight.w100,
              fontFamily: "slabo"),
        ),
        TextSpan(
          text: " Pizza",
          style: TextStyle(
              color: Colors.black,
              fontSize: _fontSize,
              fontWeight: FontWeight.w600,
              fontFamily: "slabo"),
        ),
      ]),
    );
  }
}

class StarRating extends StatelessWidget {
  final double rating;
  final Color color;

  StarRating(this.rating,{this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          rating.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 5,
        ),
        Icon(
          Icons.star,
          size: 25,
          color: color,
        ),
      ],
    );
  }
}

class Description extends StatelessWidget {
  final String description;

  Description(this.description);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      softWrap: true,
      style: TextStyle(
          fontSize: 17,
          color: Colors.black,
          letterSpacing: 1.3,
          textBaseline: TextBaseline.alphabetic),
    );
  }
}

class Price extends StatelessWidget {
  final double price;

  Price(this.price);

  @override
  Widget build(BuildContext context) {
    return Align(

      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          "\$$price",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class BottomButtons extends StatefulWidget {

  final Color _color;


  BottomButtons(this._color);

  @override
  _BottomButtonsState createState() => _BottomButtonsState(_color);
}

class _BottomButtonsState extends State<BottomButtons> {
  bool isFav = false;
  bool isCart = false;

  final Color color;


  _BottomButtonsState(this.color);

  @override
  void initState() {
    isFav = false;
    isCart = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 5, color: color)),
          ),
          child: FlatButton(
            onPressed: () {
              setState(() {
                isCart = !isCart;
              });
            },
            child: Text(
              isCart ? "Remove from cart" : "Add to cart",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
            ),
          ),
        ),
        IconButton(
          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
          onPressed: () {
            setState(() {
              isFav = !isFav;
            });
          },
        )
      ],
    );
  }
}

class BackgroundArc extends StatelessWidget {
  final Color _color;

  BackgroundArc(this._color);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: BackgroundPainter(_color),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Color _color;

  final Path _path = Path();

  BackgroundPainter(this._color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = _color;

    _path.moveTo(250, 0);

    _path.quadraticBezierTo(150, 125, 240, 270);
    _path.quadraticBezierTo(300, 345, 450, 350);

    _path.lineTo(500, 0);

    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
