// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class LocalUser extends _LocalUser with RealmEntity, RealmObject {
  LocalUser(
    String email,
    String userPassword,
  ) {
    RealmObject.set(this, 'email', email);
    RealmObject.set(this, 'userPassword', userPassword);
  }

  LocalUser._();

  @override
  String get email => RealmObject.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObject.set(this, 'email', value);

  @override
  String get userPassword =>
      RealmObject.get<String>(this, 'userPassword') as String;
  @override
  set userPassword(String value) =>
      RealmObject.set(this, 'userPassword', value);

  @override
  Stream<RealmObjectChanges<LocalUser>> get changes =>
      RealmObject.getChanges<LocalUser>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(LocalUser._);
    return const SchemaObject(LocalUser, 'LocalUser', [
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('userPassword', RealmPropertyType.string),
    ]);
  }
}
