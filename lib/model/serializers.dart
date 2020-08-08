import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_app_chopper/model/post_class.dart';

import 'built_post.dart';

part 'serializers.g.dart';

@SerializersFor(const [BuiltPost])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
