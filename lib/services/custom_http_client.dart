import 'package:http/http.dart' as http;
import 'custom_http_client_web.dart'
    if (dart.library.io) 'custom_http_client_vm.dart' as impl;

http.Client getCustomHttpClient() => impl.createHttpClient();
