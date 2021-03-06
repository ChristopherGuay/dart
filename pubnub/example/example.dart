import 'package:pubnub/pubnub.dart';

void main() async {
  // Create PubNub instance with default keyset.
  var pubnub = PubNub(
      defaultKeyset:
          Keyset(subscribeKey: 'demo', publishKey: 'demo', uuid: UUID('demo')));

  // Subscribe to a channel
  var subscription = await pubnub.subscribe(channels: {'test'});

  subscription.messages.take(1).listen((message) {
    print(message);
  });

  // Publish a message
  await pubnub.publish('test', {'message': 'My message!'});

  // Unsubscribe
  await subscription.dispose();

  // Channel abstraction for easier usage
  var channel = pubnub.channel('test');

  await channel.publish({'message': 'Another message'});

  // Work with channel History API
  var history = channel.messages();
  var count = await history.count();

  print('Messages on test channel: $count');
}
