import 'package:top_up_ticket/shared/data/datasources/remote/topup_transaction_remote_datasource.dart';

class TopupTransactionRemoteDatasourceImpl
    implements TopupTransactionRemoteDatasource {
  @override
  Future<void> addTopupTransaction({
    required int value,
    required String phoneNumber,
  }) async {
    // call api to add transaction
    await Future.delayed(const Duration(seconds: 1));
  }
}
