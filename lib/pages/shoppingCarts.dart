import 'package:doro/pages/buyShoppingCart.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShoppingCarts extends StatefulWidget {
  const ShoppingCarts({super.key});

  @override
  State<ShoppingCarts> createState() => _ShoppingCartsState();
}

class _ShoppingCartsState extends State<ShoppingCarts> {
  Widget _shopping_carts = Container(
    child: Text("123"),
  );

  Future<void> getShoppingCarts() async {
    List? temp = await getShoppingCartsCustomer();
    List<Widget> tempWidgetList = [];
    temp!.forEach((element) {
      Map cartStatus = {"text": "", "color": Colors.amber};

      switch (element['status']) {
        case "0":
          cartStatus["text"] = "Подтвердите покупку";
          cartStatus["color"] = Colors.amber;
          break;
        case "1":
          cartStatus["text"] = "Куплено";
          cartStatus["color"] = Colors.lightGreen;
          break;
        case "2":
          cartStatus["text"] = "Отмена";
          cartStatus["color"] = Colors.red;
          break;
      }

      List? tempDet = element['goods'];
      List<TableRow> tempGoodsWidget = [];
      tempDet!.forEach(
        (elementDet) {
          print(elementDet);
          TableRow tempItemCart = TableRow(children: [
            TableCell(
                child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              elementDet['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Text(
                              "x",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: Colors.grey),
                            ),
                            Text(
                              elementDet['amount'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              elementDet['price'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Text(
                              "\u3012",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ))),
            TableCell(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  elementDet['price_total'],
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.grey),
                )
              ],
            ))
          ]);
          tempGoodsWidget.add(tempItemCart);
        },
      );

      Widget tempElement = TextButton(
        onPressed: (() {
          if (element['status'] == "0") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BuyShoppingCart(
                  data: {"cart_id":element['cart_id']},
                ),
              ),
            );
          }
        }),
        child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: cartStatus["color"],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Корзина#" + element['cart_id'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 25),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            cartStatus["text"],
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    )),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        border:
                            Border.all(color: cartStatus["color"], width: 2)),
                    child: Column(
                      children: [
                        Table(
                          border: TableBorder(
                              horizontalInside:
                                  BorderSide(color: Colors.grey, width: 0.5),
                              bottom: BorderSide(
                                  color: cartStatus["color"], width: 2)),
                          children: tempGoodsWidget,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.person_outline),
                                    Column(
                                      children: [
                                        Text(
                                          element['last_name'],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(element['first_name'],
                                            style:
                                                TextStyle(color: Colors.black))
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            Text(
                              (element['summary'] ?? "0") + "\u3012",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ))
              ],
            )),
      );
      tempWidgetList.add(tempElement);
    });
    Widget tempHandler = ListView(
      children: tempWidgetList,
    );
    setState(() {
      _shopping_carts = tempHandler;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoppingCarts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text("Корзины"),
        ),
        backgroundColor: Colors.white,
        body: _shopping_carts);
  }
}
