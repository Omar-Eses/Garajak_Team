import 'package:flutter/material.dart';
import 'garages.dart';
import 'add.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('garages information')),
      body: Column(
        children: [
          const Image(
            image: AssetImage('images/logo.png'),
            height: 100,
          ),
          Expanded(
            child: Container(
              child: GaragesList(
                data: Garages.generateData(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.blue[120],
                    onPressed: () {
                      Navigator.pushNamed(context, '/add');
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GaragesList extends StatefulWidget {
  late final List<Garages> garages;

  GaragesList({Key? key, required List<Garages> data}) : super(key: key) {
    garages = data;
  }

  @override
  State<GaragesList> createState() => _GaragesListState();
}

class _GaragesListState extends State<GaragesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.garages.length,
        itemExtent: 150,
        itemBuilder: _garagesItemsList);
  }

  Widget _garagesItemsList(BuildContext context, int index) {
    return Dismissible(
      key: UniqueKey(),
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.blue[100],
            child: const Icon(Icons.delete, size: 70),
          )
        ],
      ),
      onDismissed: (direction) {
        direction == DismissDirection.startToEnd;
        if (direction == DismissDirection.startToEnd) {
          showDialog(
              context: context,
              builder: ((BuildContext context) => AlertDialog(
                      title: const Text(
                          'are you sure you want to delete this item?'),
                      actions: [
                        TextButton(
                            onPressed: (() {
                              Navigator.pop(context, true);
                            }),
                            child: Text('delete')),
                        TextButton(
                            onPressed: (() {
                              Navigator.pop(context, false);
                            }),
                            child: Text('cancel'))
                      ])));
        }
      },
      child: _getItemCard(context, widget.garages[index]),
    );

    //_getItemCard(context, widget.garages[index]);
    /* Dismissible(
      key: UniqueKey(),
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.red[100],
            child: const Icon(
              Icons.delete,
              size: 75,
            ),
          ),
        ],
      ),
      secondaryBackground: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            color: Colors.blue[100],
            child: const Icon(
              Icons.sort,
              size: 75,
            ),
          ),
        ],
      ),
      onDismissed: (direction) {
        Student student = widget.students[index];
        setState(() {
          if (direction == DismissDirection.startToEnd) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${student.name} was dismissed :('),
            ));
            widget.students.removeAt(index);
          } else {
            Student temp = student;
            if (index != 0) {
              widget.students.removeAt(index);
              widget.students.insert(index - 1, temp);
            }
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('direction is: ${direction.name}'),
            ));
          }
        });
      },
      child: _getItemCard(context, widget.garages[index]),
    );*/

    /*return Dismissible(
      key: UniqueKey(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey,
            child: const Icon(
              Icons.delete_sweep_outlined,
              size: 75,
            ),
          ),
        ],
      ),
    );
  }*/
  }

  double newScale = 0;
  _getItemCard(BuildContext context, Garages garage) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 10),
        alignment: Alignment.center,
        child: GestureDetector(
          onScaleEnd: (s) {
            setState(() {
              if (newScale > 1) {
                _addNewGarage(widget.garages.indexOf(garage));
                newScale = 0;
              }
            });
          },
          onLongPress: () {
            Navigator.pushNamed(context, '/edit');
          },
          child: Card(
            elevation: 12,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        garage.garageName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        garage.garageId.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        garage.startingPrices.toString(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(garage.isOpened.toString(),
                          style: Theme.of(context).textTheme.headline6
                          //TextStyle(color: Colors.black, fontSize: 30),
                          ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  }

  _editPage(BuildContext context, Garages garage) {
    Navigator.pushNamed(context, '/edit');
  }

  void _addNewGarage(int i) {
    widget.garages.insert(i, Garages.getNew());
  }
}
