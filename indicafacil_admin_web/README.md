# IndicaFácil Admin Web

Painel administrativo desenvolvido em Flutter Web para gestão de clientes, empresas, serviços e sistema de cashback.

## Pré-requisitos

### Instalar Flutter

**Ubuntu/Linux:**
```bash
# Baixar Flutter
cd /tmp
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz
tar xf flutter_linux_3.16.0-stable.tar.xz

# Mover para local permanente
sudo mv flutter /opt/
export PATH="$PATH:/opt/flutter/bin"
echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc

# Verificar instalação
flutter doctor
```

**Windows:**
1. Baixe Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Extraia para `C:\flutter`
3. Adicione `C:\flutter\bin` ao PATH

**macOS:**
```bash
# Via Homebrew
brew install flutter

# Ou download manual
cd /tmp
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.16.0-stable.zip
unzip flutter_macos_3.16.0-stable.zip
sudo mv flutter /usr/local/
export PATH="$PATH:/usr/local/flutter/bin"
```

## Como executar

1. **Navegar para o diretório do projeto:**
   ```bash
   cd indicafacil_admin_web
   ```

2. **Instalar dependências:**
   ```bash
   flutter pub get
   ```

3. **Executar no navegador:**
   ```bash
   flutter run -d chrome
   ```

## Credenciais de teste

- **Admin:** usuário `admin`, senha `admin123`
- **Usuário:** usuário `user`, senha `user123`

## Funcionalidades

- ✅ Login com autenticação por perfil
- ✅ Dashboard responsivo
- ✅ Cadastro de clientes com validação e máscaras
- ✅ Cadastro de empresas
- ✅ Sistema de cashback
- ✅ Cadastro de serviços com UX aprimorada
- ✅ Controle de permissões
- ✅ Interface responsiva

## Estrutura do projeto

```
lib/
├── models/           # Modelos de dados
├── services/         # Serviços (in-memory)
├── screens/          # Telas da aplicação
└── main.dart        # Ponto de entrada
```

## Tecnologias

- Flutter Web
- Material Design 3
- mask_text_input_formatter
- intl (formatação)

## Próximos passos

- [ ] Integração com API/Backend
- [ ] Autenticação JWT
- [ ] Persistência em banco de dados
- [ ] Relatórios exportáveis
- [ ] Temas personalizáveis