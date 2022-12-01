import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();

  CollectionReference _products = FirebaseFirestore.instance.collection(
      'produtos');

  Future<void> _updateOrCreate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _productName.text = documentSnapshot['productName'];
      _productPrice.text = documentSnapshot['productPrice'];
    }

    await showModalBottomSheet(

        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _productName,
                  decoration: InputDecoration(labelText: 'Nome do produto : '),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _productPrice,
                  decoration: InputDecoration(labelText: 'Preço do produto : '),
                ),
                SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String productName = _productName.text;
                    final String productPrice = _productPrice.text;

                    if (productName != null &&
                        productPrice != null) {
                      if (action == 'create') {
                        await _products.add({
                          "productName": productName,
                          "productPrice": productPrice
                        });
                      }
                      if (action == 'update') {
                        await _products.doc(documentSnapshot?.id).update({
                          "productName": productName,
                          "productPrice": productPrice
                        });
                      }

                      _productName.text = '';
                      _productPrice.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        }

    );
  }

  Future<void> _deleteProduct(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto excluido !')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('cadastro de produtos'),
      ),
      body: StreamBuilder <QuerySnapshot>(
        stream: _products.snapshots(),
        builder: (context, dataReturn)
        {
          if(dataReturn.hasData)
            {
              return ListView.builder(
                itemCount: dataReturn.data?.docs.length,
                itemBuilder: (context, index) {
                  final QueryDocumentSnapshot<Object?>? documentSnapshot =
                  dataReturn.data?.docs[index];

                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot!['productName']),
                      subtitle: Text(documentSnapshot['productPrice']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              color: Colors.blue,
                              onPressed: () =>
                                _updateOrCreate(documentSnapshot),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id),
                            ),
                          ],
                        ),
                      ),

                    ),
                  );
                },
              );
            }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _updateOrCreate(),
        child: Icon(Icons.add),
      ),
    );
  }

}