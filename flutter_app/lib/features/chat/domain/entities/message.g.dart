// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 1;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      text: fields[2] as String,
      timestamp: fields[3] as DateTime,
      sender: fields[4] as MessageSender,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.timestamp)
      ..writeByte(4)
      ..write(obj.sender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MessageSenderAdapter extends TypeAdapter<MessageSender> {
  @override
  final int typeId = 0;

  @override
  MessageSender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MessageSender.user;
      case 1:
        return MessageSender.agent;
      default:
        return MessageSender.user;
    }
  }

  @override
  void write(BinaryWriter writer, MessageSender obj) {
    switch (obj) {
      case MessageSender.user:
        writer.writeByte(0);
        break;
      case MessageSender.agent:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageSenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
