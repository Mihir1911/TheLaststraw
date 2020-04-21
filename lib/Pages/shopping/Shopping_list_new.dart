import 'package:flutter/material.dart';
import 'package:palet/Pages/shopping/Shopping_cart_new.dart';
import 'package:palet/constants.dart';
import 'package:palet/components/New_products.dart';

 List<ProductModel> _cart=[];
class Shopping_list extends StatefulWidget {

  List<ProductModel> cart_send()
  {
    return _cart;
  }


  @override
  _Shopping_listState createState() => _Shopping_listState();
}

class _Shopping_listState extends State<Shopping_list> {

  List<ProductModel> products=[
    ProductModel("Blazer",80,0),
    ProductModel("Red dress",50,0)
  ];
   Color Listcolor=Colors.white;
  void Cart_add(ProductModel p){
    if(_cart.contains(p))
      {

      }
    else{
      _cart.add(p);
    }


  }
  int s=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,),onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>new Newcart()));

          },)
        ],

        title: Text('Product List'),),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context,index){
          return Card(
            color: kMainColor,
            child: ListTile(
              onTap: (){

                Cart_add(products[index]);

              },
              title: Text(products[index].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              trailing: Text("\$${products[index].price}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              //subtitle: Text("${products[index].quantity}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

            ),
          );

      },),



    );
  }
}
