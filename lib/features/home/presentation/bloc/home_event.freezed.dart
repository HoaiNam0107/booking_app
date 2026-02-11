// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeLoadServices {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoadServices);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeLoadServices()';
}


}

/// @nodoc
class $HomeLoadServicesCopyWith<$Res>  {
$HomeLoadServicesCopyWith(HomeLoadServices _, $Res Function(HomeLoadServices) __);
}


/// Adds pattern-matching-related methods to [HomeLoadServices].
extension HomeLoadServicesPatterns on HomeLoadServices {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeLoadServices value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeLoadServices() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeLoadServices value)  $default,){
final _that = this;
switch (_that) {
case _HomeLoadServices():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeLoadServices value)?  $default,){
final _that = this;
switch (_that) {
case _HomeLoadServices() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function()?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeLoadServices() when $default != null:
return $default();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function()  $default,) {final _that = this;
switch (_that) {
case _HomeLoadServices():
return $default();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function()?  $default,) {final _that = this;
switch (_that) {
case _HomeLoadServices() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc


class _HomeLoadServices extends HomeLoadServices {
  const _HomeLoadServices(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeLoadServices);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeLoadServices()';
}


}




/// @nodoc
mixin _$HomeCreateService {

 ServiceEntity get service;
/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeCreateServiceCopyWith<HomeCreateService> get copyWith => _$HomeCreateServiceCopyWithImpl<HomeCreateService>(this as HomeCreateService, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCreateService&&(identical(other.service, service) || other.service == service));
}


@override
int get hashCode => Object.hash(runtimeType,service);

@override
String toString() {
  return 'HomeCreateService(service: $service)';
}


}

/// @nodoc
abstract mixin class $HomeCreateServiceCopyWith<$Res>  {
  factory $HomeCreateServiceCopyWith(HomeCreateService value, $Res Function(HomeCreateService) _then) = _$HomeCreateServiceCopyWithImpl;
@useResult
$Res call({
 ServiceEntity service
});


$ServiceEntityCopyWith<$Res> get service;

}
/// @nodoc
class _$HomeCreateServiceCopyWithImpl<$Res>
    implements $HomeCreateServiceCopyWith<$Res> {
  _$HomeCreateServiceCopyWithImpl(this._self, this._then);

  final HomeCreateService _self;
  final $Res Function(HomeCreateService) _then;

/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? service = null,}) {
  return _then(_self.copyWith(
service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceEntity,
  ));
}
/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceEntityCopyWith<$Res> get service {
  
  return $ServiceEntityCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}
}


/// Adds pattern-matching-related methods to [HomeCreateService].
extension HomeCreateServicePatterns on HomeCreateService {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeCreateService value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeCreateService() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeCreateService value)  $default,){
final _that = this;
switch (_that) {
case _HomeCreateService():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeCreateService value)?  $default,){
final _that = this;
switch (_that) {
case _HomeCreateService() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ServiceEntity service)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeCreateService() when $default != null:
return $default(_that.service);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ServiceEntity service)  $default,) {final _that = this;
switch (_that) {
case _HomeCreateService():
return $default(_that.service);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ServiceEntity service)?  $default,) {final _that = this;
switch (_that) {
case _HomeCreateService() when $default != null:
return $default(_that.service);case _:
  return null;

}
}

}

/// @nodoc


class _HomeCreateService extends HomeCreateService {
  const _HomeCreateService({required this.service}): super._();
  

@override final  ServiceEntity service;

/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeCreateServiceCopyWith<_HomeCreateService> get copyWith => __$HomeCreateServiceCopyWithImpl<_HomeCreateService>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeCreateService&&(identical(other.service, service) || other.service == service));
}


@override
int get hashCode => Object.hash(runtimeType,service);

@override
String toString() {
  return 'HomeCreateService(service: $service)';
}


}

/// @nodoc
abstract mixin class _$HomeCreateServiceCopyWith<$Res> implements $HomeCreateServiceCopyWith<$Res> {
  factory _$HomeCreateServiceCopyWith(_HomeCreateService value, $Res Function(_HomeCreateService) _then) = __$HomeCreateServiceCopyWithImpl;
@override @useResult
$Res call({
 ServiceEntity service
});


@override $ServiceEntityCopyWith<$Res> get service;

}
/// @nodoc
class __$HomeCreateServiceCopyWithImpl<$Res>
    implements _$HomeCreateServiceCopyWith<$Res> {
  __$HomeCreateServiceCopyWithImpl(this._self, this._then);

  final _HomeCreateService _self;
  final $Res Function(_HomeCreateService) _then;

/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? service = null,}) {
  return _then(_HomeCreateService(
service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceEntity,
  ));
}

/// Create a copy of HomeCreateService
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ServiceEntityCopyWith<$Res> get service {
  
  return $ServiceEntityCopyWith<$Res>(_self.service, (value) {
    return _then(_self.copyWith(service: value));
  });
}
}

// dart format on
