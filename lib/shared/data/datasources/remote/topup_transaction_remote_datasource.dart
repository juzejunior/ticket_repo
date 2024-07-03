abstract interface class TopupTransactionRemoteDatasource {
  Future<void> addTopupTransaction({
    required int value,
    required String phoneNumber,
  });
}
