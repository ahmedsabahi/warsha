import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/cost_page.dart';
import 'package:warsha_app/ui/models/service.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';

class ServicesGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var servicesList = Provider.of<List<Service>>(context);
    var servicesProvider = Provider.of<ServicesProvider>(context);

    return Expanded(
      child: GridView.builder(
        itemCount: servicesList.length,
        padding: EdgeInsets.only(top: 8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 0.2,
        ),
        itemBuilder: (context, index) {
          var service = servicesList[index];
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (!servicesProvider.favList.contains(service)) {
                    servicesProvider.addToList(
                        service, service.price, service.name);
                  }
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CostPage()));
                },
                child: Column(
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Image.network(service.image),
                          ),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.amberAccent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7.0),
                      child: Text(
                        service.name,
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
