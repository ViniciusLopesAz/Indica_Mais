import 'package:flutter/material.dart';
import 'models/user.dart';
import 'screens/login.dart';
import 'screens/dashboard.dart';
import 'screens/clientes.dart';
import 'screens/empresa.dart';
import 'screens/cashback.dart';
import 'screens/cadastro_cashback.dart';
import 'screens/permission.dart';
import 'screens/cadastro_servico_screen.dart';

void main() {
  runApp(const IndicaFacilAdminApp());
}

class IndicaFacilAdminApp extends StatelessWidget {
  const IndicaFacilAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IndicaFácil Admin Web',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1976D2),
        brightness: Brightness.light,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/dashboard':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => DashboardScreen(user: user),
            );
          case '/clientes':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => ClientesScreen(user: user),
            );
          case '/empresas':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => EmpresasScreen(user: user),
            );
          case '/cashback':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => CashbackScreen(user: user),
            );
          case '/cadastro_cashback':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => CadastroCashbackScreen(user: user),
            );
          case '/permission':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => PermissionScreen(user: user),
            );
          case '/cadastro_servico':
            final user = args as User;
            return MaterialPageRoute(
              builder: (_) => CadastroServicoScreen(user: user),
            );
        }
        return null;
      },
    );
  }
}