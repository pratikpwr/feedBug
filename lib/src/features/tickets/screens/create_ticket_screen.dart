import 'package:flutter/material.dart';
import 'package:setuback/src/core/enums/ticket_enums.dart';
import 'package:setuback/src/core/views/atomic/atoms/drop_down_item.dart';
import 'package:setuback/src/core/views/atomic/atoms/textfield_item.dart';

import '../../../core/views/atomic/atoms/padding.dart';

class CreateTicketScreen extends StatelessWidget {
  const CreateTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Ticket'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              LabelledTextFieldItem(
                title: 'Title',
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Description',
              ),
              padding16,
              DropdownItem<TicketType>(
                hint: 'Ticket Type',
                items: TicketType.values,
                value: TicketType.bug,
                onChanged: (value) {},
                itemToString: (type) {
                  return type.name;
                },
              ),
              padding16,
              DropdownItem<TicketPriority>(
                hint: 'Ticket Priority',
                items: TicketPriority.values,
                value: TicketPriority.high,
                onChanged: (value) {},
                itemToString: (type) {
                  return type.name;
                },
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Improvment / Expected',
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Occurrence Module',
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Occurrence Element',
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Device',
              ),
              padding16,
              LabelledTextFieldItem(
                title: 'Device Model',
              ),
              padding16,
            ],
          ),
        ),
      ),
    );
  }
}
