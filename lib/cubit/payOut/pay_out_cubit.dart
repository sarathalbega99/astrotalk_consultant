import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_handler.dart';

part 'pay_out_state.dart';

class PayOutCubit extends Cubit<PayOutState> {
  Repository? repository;
  PayOutCubit({required this.repository}) : super(PayOutInitial());
}
