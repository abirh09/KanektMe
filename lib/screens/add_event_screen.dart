import 'package:flutter/material.dart';
import 'package:kanektme/helpers/date_formatter.dart';
import 'package:kanektme/utils/textstyle.dart';
import 'package:kanektme/widgets/snackbar.dart';
import 'package:kanektme/models/event_details.dart';
import 'package:kanektme/utils/validators.dart';
import 'package:kanektme/widgets/custom_button.dart';
import 'package:kanektme/widgets/custom_loader.dart';
import 'package:kanektme/widgets/custom_textbox.dart';
import 'package:provider/provider.dart';
import '../services/event_service.dart';
import '../utils/colors.dart';

class AddWifiScreen extends StatefulWidget {
  const AddWifiScreen({super.key});

  @override
  State<AddWifiScreen> createState() => _AddWifiScreenState();
}

class _AddWifiScreenState extends State<AddWifiScreen> {

  final TextEditingController _address = TextEditingController();
  final TextEditingController _contact = TextEditingController();
  final TextEditingController _dateTime = TextEditingController();
  final TextEditingController _name  = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColors.primary,
              onPrimary: CustomColors.white,
              onSurface: CustomColors.tertiary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.primary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: CustomColors.primary,
                onPrimary: CustomColors.white,
                onSurface: CustomColors.tertiary,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: CustomColors.primary,
                ),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _dateTime.text = formatDateTime(_selectedDate!);
        });
      } else {
        setState(() {
          _selectedDate = pickedDate;
          _dateTime.text = formatDateTime(_selectedDate!);
        });
      }
    }
  }


  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _contact.dispose();
    _dateTime.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text("Add Event", style: CustomTextStyle.tittleText,),
      ),
      body: Consumer<EventService>(
        builder: (context, eventService, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextbox(controller: _name, hintText: "Enter Name", needValidation: true, errorMessage: "", fieldTitle: "Name",viewOnly: false,validatorClass: ValidatorClass().validateEmpty,),
              CustomTextbox(controller: _address, hintText: "Enter Address", needValidation: true, errorMessage: "", fieldTitle: "Address",viewOnly: false,validatorClass: ValidatorClass().validateEmpty,),
              CustomTextbox(controller: _contact, hintText: "Enter Contact", needValidation: true, errorMessage: "", fieldTitle: "Contact",viewOnly: false,validatorClass: ValidatorClass().validatePhoneNumber,),
              CustomTextbox(
                onTap: (){
                  _selectDate(context);
                },
                controller: _dateTime, hintText: "", needValidation: true, errorMessage: "", fieldTitle: "DateTime",viewOnly: true,),
              eventService.isLoading?CustomLoader():CustomButton(onTap: () async {

                if(_formKey.currentState!.validate()){
                  final EventDetails event = EventDetails(name: _name.text, address: _address.text, contact: _contact.text, time: formatDateTime(_selectedDate!));
                  await eventService.addEvent(event);
                  if(eventService.errorMessage==null){
                    showSnackBar(context: context, title: "Successfully Added", failureMessage: false);
                  }
                  else{
                    showSnackBar(context: context, title: eventService.errorMessage.toString(), failureMessage: true);
                  }
                }

              }, label: "Add Event"),
            ],
          ),
        ),
      );},
    ),);
  }
}
