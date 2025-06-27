import 'package:flutter/material.dart';
import 'package:kanektme/screens/add_event_screen.dart';
import 'package:kanektme/services/event_service.dart';
import 'package:kanektme/utils/textstyle.dart';
import 'package:kanektme/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/custom_loader.dart';

class Homepage extends StatefulWidget {

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  late final Future myFuture;

  Future getData() async {
    final eventService = Provider.of<EventService>(context,listen: false);
    final data = await eventService.fetchItems();
    return true;
  }

  @override
  void initState() {
    myFuture = getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Home",style: CustomTextStyle.tittleText,),actions: [
        IconButton(onPressed:(){
          final authService = Provider.of<AuthService>(context,listen: false);
          authService.signOut();
        }, icon: Icon(Icons.logout))
      ],),
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (context, asyncSnapshot) {
            if(!asyncSnapshot.hasData){
              return CustomLoader();
            }
            else{
              return Consumer<EventService>(
                builder: (context, eventService, _) {
                  return SingleChildScrollView(child: Column(
                    children: [
                      SizedBox(
                        height: size.height*.7,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12.0),
                          shrinkWrap: true,
                          itemCount: eventService.events.length,
                          itemBuilder: (context, index) {
                            final event = eventService.events[index];
                            print(eventService.events.length);
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                leading: const Icon(Icons.event, color: Colors.blueAccent),
                                title: Text(
                                  event.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('Address: ${event.address}'),
                                    Text('Contact: ${event.contact}'),
                                    Text('Time: ${event.time}'),
                                  ],
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  // Optional: handle tap
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      CustomButton(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddWifiScreen()),);
                      }, label: "Add Event"),
                    ],
                  ),
                  );},
              );
            }
          }
        ),
    ));
  }
}
