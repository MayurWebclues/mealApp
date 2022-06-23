import 'package:flutter/material.dart';
import 'package:meal_app/widget/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  final Function saveFilter;

  final Map<String, bool> currentFilter;
  FilterScreen(this.currentFilter,this.saveFilter);

  static const routeName = "/filter";

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutonFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override initState(){
  super.initState();
   _glutonFree = widget.currentFilter['gluten'] ?? false;
  _lactoseFree = widget.currentFilter['lactos'] ?? false;
  _vegan = widget.currentFilter['vegan'] ?? false;
  _lactoseFree = widget.currentFilter['vegiterian'] ?? false;
  }
  Widget _buildSwitchTile(
      String title, String subtitle, bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: updateValue,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Filters',
            style: Theme.of(context).textTheme.headline1,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutonFree,
                  "lactos": _lactoseFree,
                  "vegan": _vegan,
                  "vegiterian": _vegetarian
                };
                print("TRUE");

                widget.saveFilter(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Adjust your meal Selection',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: ListView(
                  children: [
                    SwitchListTile(
                      value: _glutonFree,
                      onChanged: (value) => {
                        setState(() {
                          print('_glutonFree');

                          _glutonFree = value;
                          print(_glutonFree);
                        })
                      },
                      title: Text('Gluten'),
                      subtitle: Text('subtitle'),
                    ),
                    _buildSwitchTile(
                        'Lactos-free',
                        "Only include lactose-free meals.!",
                        _lactoseFree, (newValue) {
                      setState(()  {
                        print(_lactoseFree);
                        _lactoseFree = newValue;
                      });
                    }),
                    _buildSwitchTile(
                        'Vegan-free', "only incluse Vegan meals.!", _vegan,
                        (newValue) {
                      setState(() {
                        print(_vegan);
                        _vegan = newValue;
                      });
                    }),
                    _buildSwitchTile(
                        'Vegiterian',
                        "Only include Vegiterian-free meals.!",
                        _vegetarian, (newValue) {
                      setState(() {
                        print(_vegetarian);
                        _vegetarian = newValue;
                      });
                    })
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
