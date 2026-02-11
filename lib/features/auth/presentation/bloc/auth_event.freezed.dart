// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthLogin {

 String get email; String get password;
/// Create a copy of AuthLogin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthLoginCopyWith<AuthLogin> get copyWith => _$AuthLoginCopyWithImpl<AuthLogin>(this as AuthLogin, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthLogin(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $AuthLoginCopyWith<$Res>  {
  factory $AuthLoginCopyWith(AuthLogin value, $Res Function(AuthLogin) _then) = _$AuthLoginCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$AuthLoginCopyWithImpl<$Res>
    implements $AuthLoginCopyWith<$Res> {
  _$AuthLoginCopyWithImpl(this._self, this._then);

  final AuthLogin _self;
  final $Res Function(AuthLogin) _then;

/// Create a copy of AuthLogin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthLogin].
extension AuthLoginPatterns on AuthLogin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthLogin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthLogin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthLogin value)  $default,){
final _that = this;
switch (_that) {
case _AuthLogin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthLogin value)?  $default,){
final _that = this;
switch (_that) {
case _AuthLogin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthLogin() when $default != null:
return $default(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _AuthLogin():
return $default(_that.email,_that.password);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _AuthLogin() when $default != null:
return $default(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _AuthLogin extends AuthLogin {
  const _AuthLogin({required this.email, required this.password}): super._();
  

@override final  String email;
@override final  String password;

/// Create a copy of AuthLogin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthLoginCopyWith<_AuthLogin> get copyWith => __$AuthLoginCopyWithImpl<_AuthLogin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthLogin&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthLogin(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$AuthLoginCopyWith<$Res> implements $AuthLoginCopyWith<$Res> {
  factory _$AuthLoginCopyWith(_AuthLogin value, $Res Function(_AuthLogin) _then) = __$AuthLoginCopyWithImpl;
@override @useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$AuthLoginCopyWithImpl<$Res>
    implements _$AuthLoginCopyWith<$Res> {
  __$AuthLoginCopyWithImpl(this._self, this._then);

  final _AuthLogin _self;
  final $Res Function(_AuthLogin) _then;

/// Create a copy of AuthLogin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_AuthLogin(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AuthSignUp {

 String get email; String get password; String get name; UserRole get role;
/// Create a copy of AuthSignUp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSignUpCopyWith<AuthSignUp> get copyWith => _$AuthSignUpCopyWithImpl<AuthSignUp>(this as AuthSignUp, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSignUp&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,name,role);

@override
String toString() {
  return 'AuthSignUp(email: $email, password: $password, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class $AuthSignUpCopyWith<$Res>  {
  factory $AuthSignUpCopyWith(AuthSignUp value, $Res Function(AuthSignUp) _then) = _$AuthSignUpCopyWithImpl;
@useResult
$Res call({
 String email, String password, String name, UserRole role
});




}
/// @nodoc
class _$AuthSignUpCopyWithImpl<$Res>
    implements $AuthSignUpCopyWith<$Res> {
  _$AuthSignUpCopyWithImpl(this._self, this._then);

  final AuthSignUp _self;
  final $Res Function(AuthSignUp) _then;

/// Create a copy of AuthSignUp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? name = null,Object? role = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthSignUp].
extension AuthSignUpPatterns on AuthSignUp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSignUp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSignUp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSignUp value)  $default,){
final _that = this;
switch (_that) {
case _AuthSignUp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSignUp value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSignUp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  String name,  UserRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSignUp() when $default != null:
return $default(_that.email,_that.password,_that.name,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  String name,  UserRole role)  $default,) {final _that = this;
switch (_that) {
case _AuthSignUp():
return $default(_that.email,_that.password,_that.name,_that.role);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  String name,  UserRole role)?  $default,) {final _that = this;
switch (_that) {
case _AuthSignUp() when $default != null:
return $default(_that.email,_that.password,_that.name,_that.role);case _:
  return null;

}
}

}

/// @nodoc


class _AuthSignUp extends AuthSignUp {
  const _AuthSignUp({required this.email, required this.password, required this.name, required this.role}): super._();
  

@override final  String email;
@override final  String password;
@override final  String name;
@override final  UserRole role;

/// Create a copy of AuthSignUp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSignUpCopyWith<_AuthSignUp> get copyWith => __$AuthSignUpCopyWithImpl<_AuthSignUp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSignUp&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,name,role);

@override
String toString() {
  return 'AuthSignUp(email: $email, password: $password, name: $name, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AuthSignUpCopyWith<$Res> implements $AuthSignUpCopyWith<$Res> {
  factory _$AuthSignUpCopyWith(_AuthSignUp value, $Res Function(_AuthSignUp) _then) = __$AuthSignUpCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, String name, UserRole role
});




}
/// @nodoc
class __$AuthSignUpCopyWithImpl<$Res>
    implements _$AuthSignUpCopyWith<$Res> {
  __$AuthSignUpCopyWithImpl(this._self, this._then);

  final _AuthSignUp _self;
  final $Res Function(_AuthSignUp) _then;

/// Create a copy of AuthSignUp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? name = null,Object? role = null,}) {
  return _then(_AuthSignUp(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

/// @nodoc
mixin _$AuthCheckCurrentUser {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCheckCurrentUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthCheckCurrentUser()';
}


}

/// @nodoc
class $AuthCheckCurrentUserCopyWith<$Res>  {
$AuthCheckCurrentUserCopyWith(AuthCheckCurrentUser _, $Res Function(AuthCheckCurrentUser) __);
}


/// Adds pattern-matching-related methods to [AuthCheckCurrentUser].
extension AuthCheckCurrentUserPatterns on AuthCheckCurrentUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthCheckCurrentUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthCheckCurrentUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthCheckCurrentUser value)  $default,){
final _that = this;
switch (_that) {
case _AuthCheckCurrentUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthCheckCurrentUser value)?  $default,){
final _that = this;
switch (_that) {
case _AuthCheckCurrentUser() when $default != null:
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
case _AuthCheckCurrentUser() when $default != null:
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
case _AuthCheckCurrentUser():
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
case _AuthCheckCurrentUser() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc


class _AuthCheckCurrentUser extends AuthCheckCurrentUser {
  const _AuthCheckCurrentUser(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthCheckCurrentUser);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthCheckCurrentUser()';
}


}




/// @nodoc
mixin _$AuthLogout {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthLogout()';
}


}

/// @nodoc
class $AuthLogoutCopyWith<$Res>  {
$AuthLogoutCopyWith(AuthLogout _, $Res Function(AuthLogout) __);
}


/// Adds pattern-matching-related methods to [AuthLogout].
extension AuthLogoutPatterns on AuthLogout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthLogout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthLogout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthLogout value)  $default,){
final _that = this;
switch (_that) {
case _AuthLogout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthLogout value)?  $default,){
final _that = this;
switch (_that) {
case _AuthLogout() when $default != null:
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
case _AuthLogout() when $default != null:
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
case _AuthLogout():
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
case _AuthLogout() when $default != null:
return $default();case _:
  return null;

}
}

}

/// @nodoc


class _AuthLogout extends AuthLogout {
  const _AuthLogout(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthLogout);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthLogout()';
}


}




// dart format on
