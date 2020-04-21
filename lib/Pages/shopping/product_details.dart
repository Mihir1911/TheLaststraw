import 'package:flutter/material.dart';
import 'package:palet/constants.dart';
class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_new_price;
  final product_detail_old_price;
  final product_detail_picture;

  ProductDetails({
   this.product_detail_name,
    this.product_detail_new_price,
    this.product_detail_old_price,
    this.product_detail_picture

});


  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text('ShoppApp'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},),
          //IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,),onPressed: (){},)

        ],

      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(widget.product_detail_name,style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 16.0
                  ),),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("\$${widget.product_detail_old_price}",style: TextStyle(
                          color: Colors.grey,decoration: TextDecoration.lineThrough
                        ),),

                      ),
                      Expanded(
                        child: Text("\$${widget.product_detail_new_price}",style: TextStyle(
                          color: Colors.red,fontWeight: FontWeight.bold
                        ),),

                      ),
                    ],
                  ),
                ),
              ),

            ),
          ),
          //============FIRST BUTTON=========
          Row(
            children: <Widget>[
              //========SIZE BUTTON========
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(context: context,builder:(context){
                      return new AlertDialog(
                        title: Text("Size"),
                        content: Text("choose the color"),
                        actions: <Widget>[
                          MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: Text("Close",style: TextStyle(
                              color: Colors.teal
                          ),),)
                        ],

                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Size",style: TextStyle(
                            color: Colors.black
                        ),),
                      ),

                      Expanded(
                        child:Icon(Icons.arrow_drop_down),
                      ),

                    ],
                  ),
                ),
              ),
              //=========COLOR BUTTON======
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(context: context,builder: (context){
                      return AlertDialog(
                        title: Text("Color"),
                        content: Text("choose color"),
                        actions: <Widget>[
                          MaterialButton(onPressed: (){
                            Navigator.of(context).pop(context);
                          },
                          child: Text("Close",style: TextStyle(
                              color: Colors.teal
                          ),),)
                        ],
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Color",style: TextStyle(
                          color: Colors.black
                        ),
                        ),
                      ),

                      Expanded(
                        child:Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),
              //=========QUANTITY BUTTON=========
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(context: context,builder: (context){
                      return AlertDialog(
                        title: Text("Qty"),
                        content: Text("choose"),
                        actions: <Widget>[
                          MaterialButton(
                            onPressed: (){
                              Navigator.of(context).pop(context);
                            },
                            child: Text("Close",style: TextStyle(
                              color: Colors.teal
                            ),
                            ),
                          )
                        ],
                      );
                    });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Qty",style: TextStyle(
                            color: Colors.black
                        ),),
                      ),
                      Expanded(
                        child:Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          //==========THE SECOND BUTTON========
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: (){},
                  color: Colors.red,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: Text("Buy now")
                ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.red,),onPressed: (){


              },),

              //IconButton(icon: Icon(Icons.favorite_border,color: Colors.red,),onPressed: (){},),



            ],
          ),
          Divider(),
          ListTile(
            title: Text("Product details"),
            subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
          ),
        ],
      ),
    );
  }
}
