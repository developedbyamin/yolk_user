import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  XFile? pickedImage;
  final ImagePicker imagePicker;

  PermissionBloc() : imagePicker = ImagePicker(), super(PermissionInitial()) {
    on<RequestPermission>(_onRequestPermission);
    on<OpenAppSettings>(_onOpenAppSettings);
    on<ClearImageSelection>(_onClearImageSelection);
  }

  Future<void> _onRequestPermission(RequestPermission event, Emitter<PermissionState> emit) async {
    emit(PermissionLoading());
    try {
      switch (event.permissionType) {
        case PermissionType.camera:
          await _handleCameraPermission(emit);
          break;
        case PermissionType.gallery:
          await _handleGalleryPermission(emit);
          break;
        case PermissionType.location:
          await _handleLocationPermission(emit);
          break;
        case PermissionType.notification:
          await _handleNotificationPermission(emit);
          break;
      }
    } catch (e) {
      emit(PermissionFailure('Xəta baş verdi: ${e.toString()}', event.permissionType));
    }
  }

  Future<void> _handleCameraPermission(Emitter<PermissionState> emit) async {
    final permissionStatus = await Permission.camera.status;
    await _handlePermissionStatus(
      permissionStatus,
      Permission.camera,
      () => _pickImageFromCamera(emit),
      'Kamera',
      PermissionType.camera,
      emit,
    );
  }

  Future<void> _handleGalleryPermission(Emitter<PermissionState> emit) async {
    final permissionStatus = await Permission.photos.status;
    await _handlePermissionStatus(
      permissionStatus,
      Permission.photos,
      () => _pickImageFromGallery(emit),
      'Qalereya',
      PermissionType.gallery,
      emit,
    );
  }

  Future<void> _handleLocationPermission(Emitter<PermissionState> emit) async {
    final permissionStatus = await Permission.location.status;
    await _handlePermissionStatus(
      permissionStatus,
      Permission.location,
      () async => emit(PermissionGranted(PermissionType.location)),
      'Məkan',
      PermissionType.location,
      emit,
    );
  }

  Future<void> _handleNotificationPermission(Emitter<PermissionState> emit) async {
    final permissionStatus = await Permission.notification.status;
    await _handlePermissionStatus(
      permissionStatus,
      Permission.notification,
      () async => emit(PermissionGranted(PermissionType.notification)),
      'Bildiriş',
      PermissionType.notification,
      emit,
    );
  }

  Future<void> _handlePermissionStatus(
    PermissionStatus status,
    Permission permission,
    Future<void> Function() onGranted,
    String permissionName,
    PermissionType type,
    Emitter<PermissionState> emit,
  ) async {
    if (status.isGranted) {
      await onGranted();
    } else if (status.isDenied) {
      final request = await permission.request();
      if (request.isGranted) {
        await onGranted();
      } else {
        emit(PermissionDenied(message: '$permissionName icazəsi rədd edildi', permissionType: type));
      }
    } else if (status.isPermanentlyDenied || status.isRestricted) {
      emit(
        PermissionPermanentlyDenied(
          message: '$permissionName icazəsi daimi olaraq rədd edildi. Tənzimləmələrdən icazə verin',
          permissionType: type,
        ),
      );
    } else {
      emit(PermissionFailure('$permissionName icazəsi alınarkən xəta baş verdi', type));
    }
  }

  Future<void> _pickImageFromGallery(Emitter<PermissionState> emit) async {
    try {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);

      if (image != null) {
        pickedImage = image;

        emit(ImageSelected(image));
      } else {
        emit(PhotoNotSelected(message: 'Şəkil seçilmədi'));
      }
    } catch (e) {
      emit(PermissionFailure('Şəkil seçilərkən xəta baş verdi: ${e.toString()}', PermissionType.gallery));
    }
  }

  Future<void> _pickImageFromCamera(Emitter<PermissionState> emit) async {
    try {
      final XFile? image = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 80);
      if (image != null) {
        pickedImage = image;
        emit(ImageSelected(image));
      } else {
        emit(PhotoNotSelected(message: 'Şəkil çəkilmədi'));
      }
    } catch (e) {
      emit(PermissionFailure('Şəkil çəkilərkən xəta baş verdi: ${e.toString()}', PermissionType.camera));
    }
  }

  Future<void> _onOpenAppSettings(OpenAppSettings event, Emitter<PermissionState> emit) async {
    try {
      final bool isOpened = await openAppSettings();
      switch (event.permissionType) {
        case PermissionType.notification:
          final permissionStatus = await Permission.notification.status;
          if (!isOpened && permissionStatus.isPermanentlyDenied) {
            emit(PermissionFailure('Bildirişlərə icazə verilmədi', event.permissionType));
          }
          break;

        case PermissionType.camera:
          final permissionStatus = await Permission.camera.status;
          if (!isOpened && permissionStatus.isPermanentlyDenied) {
            emit(PermissionFailure('Kameraya icazə verilmədi', event.permissionType));
          }
          break;

        case PermissionType.gallery:
          final permissionStatus = await Permission.photos.status;
          if (!isOpened && permissionStatus.isPermanentlyDenied) {
            emit(PermissionFailure('Qalereyaya icazə verilmədi', event.permissionType));
          }
          break;

        case PermissionType.location:
          final permissionStatus = await Permission.location.status;
          if (!isOpened && permissionStatus.isPermanentlyDenied) {
            emit(PermissionFailure('Lokasiyaya icazə verilmədi', event.permissionType));
          }
          break;
      }
    } catch (e) {
      emit(PermissionFailure('Xəta baş verdi: ${e.toString()}', event.permissionType));
    }
  }

  void _onClearImageSelection(ClearImageSelection event, Emitter<PermissionState> emit) {
    pickedImage = null;
    emit(PermissionInitial());
  }
}
