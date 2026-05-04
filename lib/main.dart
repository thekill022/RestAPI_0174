import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapi0174/data/repositories/auth_repository.dart';
import 'package:restapi0174/data/repositories/hewan_repository.dart';
import 'package:restapi0174/logic/bloc/auth/auth_bloc.dart';
import 'package:restapi0174/logic/bloc/auth/auth_event.dart';
import 'package:restapi0174/logic/bloc/auth/auth_state.dart';
import 'package:restapi0174/logic/bloc/hewan/hewan_bloc.dart';
import 'package:restapi0174/logic/debug/bloc_observer.dart';
import 'package:restapi0174/ui/pages/dashboard_page.dart';
import 'package:restapi0174/ui/pages/login_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => HewanRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              repository: context.read<AuthRepository>(),
            )..add(AppStarted()),
          ),
          BlocProvider(
            create: (context) => HewanBloc(
              repository: context.read<HewanRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Rest API 0174',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const AuthWrapper(),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is Authenticated) {
          return const DashboardPage();
        }
        return const LoginPage();
      },
    );
  }
}
