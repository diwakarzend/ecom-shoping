// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginDetailsAdapter extends TypeAdapter<LoginDetails> {
  @override
  final int typeId = 1;

  @override
  LoginDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginDetails(
      isLoggedIn: fields[0] as bool,
      role: fields[1] as String,
      token: fields[2] as String,
      uId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.isLoggedIn)
      ..writeByte(1)
      ..write(obj.role)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.uId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
