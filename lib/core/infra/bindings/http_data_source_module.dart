import 'package:challenge_mobile_developer/core/data/datasources/http_data_source.dart';
import 'package:challenge_mobile_developer/core/data/datasources/http_data_source_adapter.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart';

@module
abstract class HttpDataSourceModule {
  Client get client => Client();

  HttpDataSource httpDataSource() => HttpDataSourceAdapter(client);
}
