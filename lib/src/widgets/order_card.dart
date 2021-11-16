import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OrderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 0, top: 10, left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 75.0,
            width: 45.0,
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: Color(0xFFD3D3D3)),
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              children: <Widget>[
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Color(0xFFD3D3D3),
                    )),
                Text(
                  "0",
                  style: TextStyle(fontSize: 18),
                ),
                InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0xFFD3D3D3),
                    )),
              ],
            ),
          ),
          SizedBox(width: 20.0),
          Container(
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("pizza.png"), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0),
                    )
                  ])),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Cheese Pizza",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "\u20A8 3.0",
                style: TextStyle(color: Colors.orangeAccent, fontSize: 16.0),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 30.0,
                width: 120.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Row(
                        children: [
                          Text(
                            "Chicken",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              "x",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.cancel,
                color: Colors.grey,
              ))
        ],
      ),
    ));
  }
}
