import 'package:chopper/chopper.dart';
import 'package:flutter_app_chopper/data/data_interceptor.dart';

part 'post_api_service.chopper.dart';

// This baseUrl is now changed to specify endpoints
@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-contro': 'no-cache'}),
        HttpLoggingInterceptor(),
        CurlInterceptor(),
        MobileDataInterceptor(),
            (Request request) async {
          if (request.method == HttpMethod.Post) {
            chopperLogger.info('POST request');
          }
          return request;
        },
            (Response response) async {
          if (response.statusCode == 404) {
            chopperLogger.info('404 not found');
          }
          return response;
        }
      ],
    );
    return _$PostApiService(client);
  }
}
