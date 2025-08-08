part of 'permission_bloc.dart';

@immutable
sealed class PermissionEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestPermission extends PermissionEvent {
  final PermissionType permissionType;

  RequestPermission(this.permissionType);

  @override
  List<Object?> get props => [permissionType];
}

class OpenAppSettings extends PermissionEvent {
  final PermissionType permissionType;

  OpenAppSettings(this.permissionType);

  @override
  List<Object?> get props => [permissionType];
}

class ClearImageSelection extends PermissionEvent {}
