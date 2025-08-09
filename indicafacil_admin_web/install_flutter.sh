#!/bin/bash

# Script para instalar Flutter no Linux
echo "🚀 Instalando Flutter..."

# Verificar se já existe
if command -v flutter &> /dev/null; then
    echo "✅ Flutter já está instalado:"
    flutter --version
    exit 0
fi

# Criar diretório temporário
cd /tmp

# Baixar Flutter
echo "📥 Baixando Flutter..."
wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.16.0-stable.tar.xz

# Extrair
echo "📦 Extraindo..."
tar xf flutter_linux_3.16.0-stable.tar.xz

# Mover para /opt
echo "📁 Movendo para /opt..."
sudo mv flutter /opt/

# Adicionar ao PATH
echo "🔧 Configurando PATH..."
export PATH="$PATH:/opt/flutter/bin"

# Adicionar ao bashrc permanentemente
if ! grep -q "flutter/bin" ~/.bashrc; then
    echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
    echo "✅ PATH adicionado ao ~/.bashrc"
fi

# Recarregar bashrc
source ~/.bashrc

# Verificar instalação
echo "🔍 Verificando instalação..."
flutter doctor

echo ""
echo "✅ Flutter instalado com sucesso!"
echo "💡 Execute: source ~/.bashrc ou abra um novo terminal"
echo "🚀 Para rodar o projeto: cd indicafacil_admin_web && flutter pub get && flutter run -d chrome"