import 'package:flutter/material.dart';
import 'package:palet/components/New_products.dart';
import 'package:palet/constants.dart';
import 'package:palet/Pages/shopping/Shopping_list_new.dart';

Shopping_list obj = new Shopping_list();

class Newcart extends StatefulWidget {
//  final int sum;
//  Newcart({
//    this.sum,
//  });

  @override
  _NewcartState createState() => _NewcartState();
}

class _NewcartState extends State<Newcart> {
  int s = 0;

  List<ProductModel> cart = obj.cart_send();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return Card(
            color: kMainColor,
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (cart[index].quantity == 0) {
                          cart[index].quantity = 0;
                        } else {
                          cart[index].quantity--;
                          s = s - cart[index].price;
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        cart[index].quantity++;
                        s = s + cart[index].price;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        s = s - (cart[index].quantity * cart[index].price);
                        cart[index].quantity = 0;
                        cart.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
              title: Text(
                cart[index].name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                "\$${cart[index].price}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "${cart[index].quantity}",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text("Total"),
                subtitle: Text("\$$s"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {},
                child: Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                ),
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
