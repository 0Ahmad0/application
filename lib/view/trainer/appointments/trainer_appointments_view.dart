import 'package:flutter/material.dart';

import 'widgets/trainer_appointments_view_body.dart';

class TrainerAppointmentsView extends StatelessWidget {
  const TrainerAppointmentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: (){},
      ),
      body: TrainerAppointmentsViewBody(),
    );
  }
}
