import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/all_cubits.dart';

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({super.key});

  @override
  State<PayoutsScreen> createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayOutCubit, PayOutState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(body: Container());
      },
    );
    
  }
}
