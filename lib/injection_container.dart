import 'package:flutter_adviser/0_data/data_sources/advice_remote_data_source.dart';
import 'package:flutter_adviser/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_adviser/1_domain/repositories/advice_repo.dart';
import 'package:flutter_adviser/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_adviser/2_application/pages/advice/cubit/adviser_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I; // sl -> Service Locator; I -> shortcut of 'instance'

Future<void> init() async {
  //! application layer
  // Factory -> every time a new/fresh instance of that class
  sl.registerFactory(() => AdviserCubit(adviceUseCases: sl()));

  //! domain layer
  sl.registerFactory(() => AdviceUseCases(adviceRepo: sl()));

  //! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  //! externs
  sl.registerFactory(() => http.Client());
}
