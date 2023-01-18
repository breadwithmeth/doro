import 'package:doro/pages/error.dart';
import 'package:doro/pages/success.dart';
import 'package:doro/utils/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class BuyShoppingCart extends StatefulWidget {
  const BuyShoppingCart({super.key, required this.data});
  final Map<String, dynamic> data;
  @override
  State<BuyShoppingCart> createState() => _BuyShoppingCartState();
}

class _BuyShoppingCartState extends State<BuyShoppingCart> {
  bool isButtonEnabled = true;
  Map<String, dynamic> details = {};
  List<TableRow> goodsDetails = [];
  List? goodsDetailsArr = [];
  Future<void> getDetails() async {
    Map<String, dynamic> temp =
        await getShoppingCartDetails(widget.data['cart_id']!);
    List? tempDet = temp['goods'];
    List<TableRow> tempGoodsWidget = [];
    tempDet!.forEach(
      (element) {
        print(element);
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
                            element['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          Text("x"),
                          Text(element['amount'])
                        ],
                      ),
                      Row(
                        children: [
                          Text(element['price']),
                          Text("\u3012"),
                        ],
                      )
                    ],
                  ))),
          TableCell(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                element['price_total'],
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              )
            ],
          ))
        ]);
        tempGoodsWidget.add(tempItemCart);
      },
    );

    setState(() {
      details = temp;
      goodsDetails = tempGoodsWidget;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          padding: EdgeInsets.only(top: 300, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Корзина#",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.white),
              ),
              Text(
                details['cart_id'] ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF3EADCF), Color(0xFFABE9CD)])),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder(
                      horizontalInside:
                          BorderSide(color: Colors.black, width: 1)),
                  columnWidths: {0: FlexColumnWidth(3)},
                  children: goodsDetails,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Итого",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      details['summary'] ?? "",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                    )
                  ],
                )
              ],
            )),
        isButtonEnabled
            ? TextButton(
                onPressed: (() async {
                  int status = await buyShoppingCart(details['cart_id']);
                  setState(() {
                    isButtonEnabled = false;
                  });
                  if (status == 200) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => successPage(
                        successMessage: "Покупка удалась",
                      ),
                    ),
                  );
                  }else{
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => errorPage(
                      errorCode: status,
                      ),
                    ),
                  );
                  }
                }),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      border: Border.all(color: Colors.black, width: 4),
                      color: Colors.white),
                  child: Text(
                    "Подтвердить",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ))
            : Container()
      ],
    ));
  }
}
