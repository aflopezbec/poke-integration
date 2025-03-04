import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:poke_detail/domain/model/platform_channel_config.dart';

@injectable
class NotifyBackMethodUseCase {
  void call() {
    const platform = MethodChannel(PlatformChannelConfig.channel);
    platform.invokeMethod(PlatformChannelConfig.backMethod);
  }
}
