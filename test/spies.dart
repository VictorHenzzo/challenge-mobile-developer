import 'package:challenge_mobile_developer/core/data/datasources/http_data_source/http_data_source.dart';
import 'package:challenge_mobile_developer/core/domain/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class HttpDataSourceSpy extends Mock implements HttpDataSource {}

class AuthRepositorySpy extends Mock implements AuthRepository {}
