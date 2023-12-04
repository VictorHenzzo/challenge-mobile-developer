import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/datasources/local_data_source/local_data_source.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/user_repository.dart';
import 'package:mocktail/mocktail.dart';

class HttpDataSourceSpy extends Mock implements HttpDataSource {}

class UserRepositorySpy extends Mock implements UserRepository {}

class LocalDataSourceSpy extends Mock implements LocalDataSource {}
