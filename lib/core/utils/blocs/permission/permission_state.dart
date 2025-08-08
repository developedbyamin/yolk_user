part of 'permission_bloc.dart';

enum PermissionType { camera, gallery, location, notification }

@immutable
sealed class PermissionState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PermissionInitial extends PermissionState {}

class PermissionLoading extends PermissionState {}

class PermissionGranted extends PermissionState {
  final PermissionType permissionType;

  PermissionGranted(this.permissionType);

  @override
  List<Object?> get props => [permissionType];
}

class ImageSelected extends PermissionState {
  final XFile image;

  ImageSelected(this.image);

  @override
  List<Object?> get props => [image];
}

class PhotoNotSelected extends PermissionState {
  final String message;

  PhotoNotSelected({this.message = 'Şəkil seçilmədi'});

  @override
  List<Object?> get props => [message];
}

class PermissionDenied extends PermissionState {
  final String message;
  final PermissionType permissionType;

  PermissionDenied({required this.message, required this.permissionType});

  @override
  List<Object?> get props => [message, permissionType];
}

class PermissionPermanentlyDenied extends PermissionState {
  final String message;
  final PermissionType permissionType;

  PermissionPermanentlyDenied({required this.message, required this.permissionType});

  @override
  List<Object?> get props => [message, permissionType];
}

class PermissionFailure extends PermissionState {
  final String errorMessage;
  final PermissionType type;

  PermissionFailure(this.errorMessage, this.type);

  @override
  List<Object?> get props => [errorMessage];
}
