// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_save.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsSaveAdapter extends TypeAdapter<PostsSave> {
  @override
  final int typeId = 6;

  @override
  PostsSave read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostsSave(
      userId: fields[0] as String?,
      posts: (fields[1] as List?)?.cast<PostModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostsSave obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.posts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsSaveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
