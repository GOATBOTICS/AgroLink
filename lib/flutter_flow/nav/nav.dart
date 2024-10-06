import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? FiltroWidget() : SigninWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? FiltroWidget() : SigninWidget(),
        ),
        FFRoute(
          name: 'SIGNIN',
          path: '/signin',
          builder: (context, params) => SigninWidget(),
        ),
        FFRoute(
          name: 'FILTRO',
          path: '/filtro',
          builder: (context, params) => FiltroWidget(),
        ),
        FFRoute(
          name: 'ARTICULOSPAGE',
          path: '/articulospage',
          builder: (context, params) => ArticulospageWidget(),
        ),
        FFRoute(
          name: 'idea2',
          path: '/idea2',
          builder: (context, params) => Idea2Widget(),
        ),
        FFRoute(
          name: 'IDEAPANELPRINCIPAL',
          path: '/ideapanelprincipal',
          builder: (context, params) => IdeapanelprincipalWidget(),
        ),
        FFRoute(
          name: 'TRANSICION',
          path: '/transicion',
          builder: (context, params) => TransicionWidget(),
        ),
        FFRoute(
          name: 'BOCETOMENU3',
          path: '/bocetomenu3',
          builder: (context, params) => Bocetomenu3Widget(),
        ),
        FFRoute(
          name: 'PROFILEBOCETO1',
          path: '/profileboceto1',
          builder: (context, params) => Profileboceto1Widget(),
        ),
        FFRoute(
          name: 'CONTACTOS2',
          path: '/contactos2',
          builder: (context, params) => Contactos2Widget(),
        ),
        FFRoute(
          name: 'Editar_Info',
          path: '/editarInfo',
          builder: (context, params) => EditarInfoWidget(),
        ),
        FFRoute(
          name: 'messages',
          path: '/messages',
          builder: (context, params) => MessagesWidget(),
        ),
        FFRoute(
          name: 'boceto_analisis',
          path: '/bocetoAnalisis',
          builder: (context, params) => BocetoAnalisisWidget(),
        ),
        FFRoute(
          name: 'INFORME_1',
          path: '/informe1',
          builder: (context, params) => Informe1Widget(),
        ),
        FFRoute(
          name: 'Informe_2',
          path: '/informe2',
          builder: (context, params) => Informe2Widget(),
        ),
        FFRoute(
          name: 'Informe_3',
          path: '/informe3',
          builder: (context, params) => Informe3Widget(),
        ),
        FFRoute(
          name: 'Calendario_1',
          path: '/calendario1',
          builder: (context, params) => Calendario1Widget(),
        ),
        FFRoute(
          name: 'Inventario_1',
          path: '/inventario1',
          builder: (context, params) => Inventario1Widget(),
        ),
        FFRoute(
          name: 'inventario_2',
          path: '/inventario2',
          builder: (context, params) => Inventario2Widget(),
        ),
        FFRoute(
          name: 'Informe_Inventario_1',
          path: '/informeInventario1',
          builder: (context, params) => InformeInventario1Widget(),
        ),
        FFRoute(
          name: 'informe_inventario_2',
          path: '/informeInventario2',
          builder: (context, params) => InformeInventario2Widget(),
        ),
        FFRoute(
          name: 'Finanzas_1',
          path: '/finanzas1',
          builder: (context, params) => Finanzas1Widget(),
        ),
        FFRoute(
          name: 'Finanzas_2',
          path: '/finanzas2',
          builder: (context, params) => Finanzas2Widget(),
        ),
        FFRoute(
          name: 'Informe_Financiero_1',
          path: '/informeFinanciero1',
          builder: (context, params) => InformeFinanciero1Widget(),
        ),
        FFRoute(
          name: 'Informe_Financiero_2',
          path: '/informeFinanciero2',
          builder: (context, params) => InformeFinanciero2Widget(),
        ),
        FFRoute(
          name: 'Logistica_1',
          path: '/logistica1',
          builder: (context, params) => Logistica1Widget(),
        ),
        FFRoute(
          name: 'Logistica_2',
          path: '/logistica2',
          builder: (context, params) => Logistica2Widget(),
        ),
        FFRoute(
          name: 'Informes_1',
          path: '/informes1',
          builder: (context, params) => Informes1Widget(),
        ),
        FFRoute(
          name: 'Informes_2',
          path: '/informes2',
          builder: (context, params) => Informes2Widget(),
        ),
        FFRoute(
          name: 'Ajustes_Parametros_2',
          path: '/ajustesParametros2',
          builder: (context, params) => AjustesParametros2Widget(),
        ),
        FFRoute(
          name: 'Cultivos_1',
          path: '/cultivos1',
          builder: (context, params) => Cultivos1Widget(),
        ),
        FFRoute(
          name: 'Cultivos_2',
          path: '/cultivos2',
          builder: (context, params) => Cultivos2Widget(),
        ),
        FFRoute(
          name: 'Riego_1',
          path: '/riego1',
          builder: (context, params) => Riego1Widget(),
        ),
        FFRoute(
          name: 'Devices',
          path: '/devices',
          builder: (context, params) => DevicesWidget(),
        ),
        FFRoute(
          name: 'Devices_2',
          path: '/devices2',
          builder: (context, params) => Devices2Widget(),
        ),
        FFRoute(
          name: 'Devices_Panel_1',
          path: '/devicesPanel1',
          builder: (context, params) => DevicesPanel1Widget(),
        ),
        FFRoute(
          name: 'Introduccion_Sistemas',
          path: '/introduccionSistemas',
          builder: (context, params) => IntroduccionSistemasWidget(),
        ),
        FFRoute(
          name: 'Introduccion_Sistemas_3',
          path: '/introduccionSistemas3',
          builder: (context, params) => IntroduccionSistemas3Widget(),
        ),
        FFRoute(
          name: 'Introduccion_Sistemas_3Copy',
          path: '/introduccionSistemas3Copy',
          builder: (context, params) => IntroduccionSistemas3CopyWidget(),
        ),
        FFRoute(
          name: 'AgroVision_1',
          path: '/agroVision1',
          builder: (context, params) => AgroVision1Widget(),
        ),
        FFRoute(
          name: 'AgroVision_2',
          path: '/agroVision2',
          builder: (context, params) => AgroVision2Widget(),
        ),
        FFRoute(
          name: 'AgroVision_33',
          path: '/agroVision33',
          builder: (context, params) => AgroVision33Widget(),
        ),
        FFRoute(
          name: 'AgroSensor_1',
          path: '/agroSensor1',
          builder: (context, params) => AgroSensor1Widget(),
        ),
        FFRoute(
          name: 'AgroSensor_2',
          path: '/agroSensor2',
          builder: (context, params) => AgroSensor2Widget(),
        ),
        FFRoute(
          name: 'AgroSensor_33',
          path: '/agroSensor33',
          builder: (context, params) => AgroSensor33Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroSensor_1',
          path: '/datosAgroSensor1',
          builder: (context, params) => DatosAgroSensor1Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroSensor_2',
          path: '/datosAgroSensor2',
          builder: (context, params) => DatosAgroSensor2Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroVision_1',
          path: '/datosAgroVision1',
          builder: (context, params) => DatosAgroVision1Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroVision_2',
          path: '/datosAgroVision2',
          builder: (context, params) => DatosAgroVision2Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroVision_3',
          path: '/datosAgroVision3',
          builder: (context, params) => DatosAgroVision3Widget(),
        ),
        FFRoute(
          name: 'Datos_AgroVision_4',
          path: '/datosAgroVision4',
          builder: (context, params) => DatosAgroVision4Widget(),
        ),
        FFRoute(
          name: 'Historial_1',
          path: '/historial1',
          builder: (context, params) => Historial1Widget(),
        ),
        FFRoute(
          name: 'Historial_2',
          path: '/historial2',
          builder: (context, params) => Historial2Widget(),
        ),
        FFRoute(
          name: 'Manual_1',
          path: '/manual1',
          builder: (context, params) => Manual1Widget(),
        ),
        FFRoute(
          name: 'Manual_2',
          path: '/manual2',
          builder: (context, params) => Manual2Widget(),
        ),
        FFRoute(
          name: 'Manual_3',
          path: '/manual3',
          builder: (context, params) => Manual3Widget(),
        ),
        FFRoute(
          name: 'Manual_4',
          path: '/manual4',
          builder: (context, params) => Manual4Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_1',
          path: '/cosechaMaiz1',
          builder: (context, params) => CosechaMaiz1Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_2',
          path: '/cosechaMaiz2',
          builder: (context, params) => CosechaMaiz2Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_3',
          path: '/cosechaMaiz3',
          builder: (context, params) => CosechaMaiz3Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_4',
          path: '/cosechaMaiz4',
          builder: (context, params) => CosechaMaiz4Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_5',
          path: '/cosechaMaiz5',
          builder: (context, params) => CosechaMaiz5Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Maiz_6',
          path: '/cosechaMaiz6',
          builder: (context, params) => CosechaMaiz6Widget(),
        ),
        FFRoute(
          name: 'Cosecha_Trigo_1',
          path: '/cosechaTrigo1',
          builder: (context, params) => CosechaTrigo1Widget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/signin';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/Logo_Mini.png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
