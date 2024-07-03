import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:top_up_ticket/core/network/connection_status.dart';
import 'package:top_up_ticket/core/secure_storage/secure_storage_manager.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/local/user_local_datasource_impl.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/topup_transaction_remote_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/topup_transaction_remote_datasource_impl.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:top_up_ticket/shared/data/repositories/beneficiary_repository_impl.dart';
import 'package:top_up_ticket/shared/data/repositories/topup_transaction_repository_impl.dart';
import 'package:top_up_ticket/shared/data/repositories/user_repository_impl.dart';
import 'package:top_up_ticket/shared/domain/repositories/beneficiary_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/topup_transaction_repository.dart';
import 'package:top_up_ticket/shared/domain/repositories/user_repository.dart';

class AppRepositoryProvider extends StatelessWidget {
  const AppRepositoryProvider({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ConnectionStatus(),
        ),
        RepositoryProvider<SecureStorageManager>(
          create: (context) => SecureStorageManager(
            const FlutterSecureStorage(),
          ),
        ),
        RepositoryProvider<UserRemoteDatasource>(
          create: (context) => UserRemoteDatasourceImpl(),
        ),
        RepositoryProvider<UserLocalDatasource>(
          create: (context) => UserLocalDatasourceImpl(
            context.read<SecureStorageManager>(),
          ),
        ),
        RepositoryProvider<TopupTransactionRemoteDatasource>(
          create: (context) => TopupTransactionRemoteDatasourceImpl(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepositoryImpl(
            context.read<UserRemoteDatasource>(),
            context.read<UserLocalDatasource>(),
            context.read<ConnectionStatus>(),
          ),
        ),
        RepositoryProvider<BeneficiaryRepository>(
          create: (context) => BeneficiaryRepositoryImpl(),
        ),
        RepositoryProvider<TopupTransactionRepository>(
          create: (context) => TopupTransactionRepositoryImpl(
            dataSource: context.read<TopupTransactionRemoteDatasource>(),
            connectionStatus: context.read<ConnectionStatus>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
