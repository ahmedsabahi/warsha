import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warsha_app/ui/models/service.dart';
import 'package:warsha_app/ui/providers/service_provider.dart';

class ServicesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var servicesList = Provider.of<List<Service>>(context);
    var servicesProvider = Provider.of<ServicesProvider>(context);
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      scrollDirection: Axis.horizontal,
      itemCount: servicesList.length,
      itemBuilder: (context, index) {
        var service = servicesList[index];
        return Padding(
          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
          child: GestureDetector(
            onTap: () {
              if (!servicesProvider.favList.contains(service)) {
                servicesProvider.addToList(
                    service, service.price, service.name);
              } else {
                servicesProvider.removeFromList(
                    service, service.price, service.name);
              }
            },
            child: Column(
              children: [
                Container(
                  width: 50.0,
                  height: 46.0,
                  child: CircleAvatar(
                    backgroundColor: servicesProvider.favList.contains(service)
                        ? Colors.amberAccent
                        : Colors.white,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(50.0),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Image.network(service.image),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.amberAccent,
                      width: 2.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    service.name,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
