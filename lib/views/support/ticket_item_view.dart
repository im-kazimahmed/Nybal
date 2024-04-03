import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nybal/Widgets/theme_data.dart';
import 'package:nybal/models/ticket_model.dart';
import 'package:nybal/views/support/ticket_details.dart';

import '../../controllers/user_controller.dart';

class TicketView extends StatefulWidget {
  final TicketModel ticket;
  const TicketView({Key? key, required this.ticket}) : super(key: key);

  @override
  _TicketViewState createState() => _TicketViewState();
}

class _TicketViewState extends State<TicketView> {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    TicketModel ticket = widget.ticket;
    Color? color;
    switch (ticket.status) {
      case 'Pending':
        color = Colors.blue.shade100;
        break;
      case 'Opened':
        color = Colors.yellow.shade100;
        break;
      case 'Closed':
        color = Colors.greenAccent.shade100;
        break;
      case 'Re-open':
        color = Colors.blue.shade50;
        break;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TicketDetails(
                  ticket: ticket,
                )));
      },
      child: Card(
        color: color,
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: ListTile(
                title: Text(
                  ticket.title,
                  style: const TextStyle(fontSize: 20.0),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     ticket.type,
                        //     textAlign: TextAlign.start,
                        //     style: const TextStyle(
                        //         color: Colors.black87, fontSize: 16.0),
                        //   ),
                        // ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Time: ${ticket.createdAt?.substring(0, 5)}\nDate: ${ticket.createdAt}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     ticket.title.length > 200
                        //         ? '${ticket.title.substring(0, 196)} ..'
                        //         : ticket.title,
                        //     style: const TextStyle(
                        //       fontSize: 16.0, color: Colors.black87,
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Status : ${ticket.status}",
                              style: const TextStyle(
                                fontSize: 16.0, color: Colors.black87,
                              ),
                            ),
                            const Icon(
                              Icons.navigate_next,
                              size: 36.0,
                              color: Colors.green,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}