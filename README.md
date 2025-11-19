# 🎮 Unreal Tournament 2003 - Linux Automatic Installer

<div align="center">

![Unreal Tournament 2003](https://img.shields.io/badge/UT2003-Installer-orange?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Linux-blue?style=for-the-badge&logo=linux)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Languages](https://img.shields.io/badge/Languages-PT%20|%20EN-yellow?style=for-the-badge)

**Automated installation script for Unreal Tournament 2003 on Linux**

*Script de instalação automática do Unreal Tournament 2003 para Linux*

[English](#english) | [Português](#português)

</div>

---

## English

### 📋 Description

This script automates the complete installation process of **Unreal Tournament 2003** on Linux systems (Ubuntu/Debian and derivatives). It handles downloading, extracting, patching, and configuring the game for optimal Linux compatibility.

### ✨ Features

- 🌍 **Bilingual**: Automatically detects system language (Portuguese/English)
- 📦 **Fully Automated**: Downloads game files from Archive.org (~2.0 GB)
- 🔧 **Auto-patching**: Applies patch 2225.3 automatically
- 🎨 **Desktop Integration**: Creates menu entry with icon
- 🔑 **CD Key Setup**: Automatically configures CD key
- 🎵 **Sound Configuration**: Sets up SDL and OpenAL libraries
- 🖼️ **OpenGL Rendering**: Configures for native Linux graphics
- ✅ **Dependency Management**: Checks and installs required packages

### 🖥️ System Requirements

- **OS**: Ubuntu, Debian, Linux Mint, or derivatives
- **Architecture**: 64-bit with 32-bit libraries support
- **Disk Space**: ~10 GB (3.0 GB download + installation)
- **RAM**: 512 MB minimum
- **Graphics**: OpenGL-compatible GPU

### 📦 Dependencies

The script will automatically check and offer to install:

- `wget` - Download manager
- `p7zip-full` - 7z extraction
- `util-linux` - 32-bit support
- `expect` - Automated patching
- `imagemagick` - Icon conversion
- `libstdc++5:i386` - 32-bit C++ library
- `libsdl1.2debian:i386` - SDL library
- `libopenal1:i386` - OpenAL library

### 🚀 Installation

#### Quick Install (One Command)

```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/ut2003-installer/main/UT2003_installer_Online_Linux.sh && chmod +x UT2003_installer_Online_Linux.sh && ./UT2003_installer_Online_Linux.sh
```

#### Manual Installation

1. **Download the script:**
```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/ut2003-installer/main/UT2003_installer_Online_Linux.sh
```

2. **Make it executable:**
```bash
chmod +x UT2003_installer_Online_Linux.sh
```

3. **Run the installer:**
```bash
./UT2003_installer_Online_Linux.sh
```

4. **Follow the on-screen instructions** - The script will guide you through each step!

### 📂 Installation Locations

| Item | Location |
|------|----------|
| Game Files | `~/Games/ut2003/` |
| User Config | `~/.ut2003/System/` |
| Desktop Entry | `~/.local/share/applications/ut2003.desktop` |
| Icon | `~/.local/share/icons/ut2003.png` |
| Launcher | `~/Games/ut2003/ut2003_launch.sh` |

### 🎮 How to Play

After installation, you can launch the game in three ways:

1. **From Applications Menu**: Look for "Unreal Tournament 2003"
2. **Using the launcher**:
   ```bash
   ~/Games/ut2003/ut2003_launch.sh
   ```
3. **Direct execution**:
   ```bash
   cd ~/Games/ut2003/System && ./ut2003-bin
   ```

### 🔧 Configuration

The script automatically configures:
- ✅ OpenGL rendering device
- ✅ SDL viewport manager
- ✅ Sound libraries (SDL + OpenAL)
- ✅ CD Key (default included)
- ✅ 32-bit compatibility

#### Custom CD Key

If you want to use your own CD key, edit:
```bash
nano ~/Games/ut2003/System/cdkey
```

Format: `XXXXX-XXXXX-XXXXX-XXXXX`

### ⚠️ Known Issues

#### VirtualBox/VM Environments
- **Issue**: `libglc` or OpenGL errors may occur
- **Cause**: Limited 3D acceleration in virtual machines
- **Solution**: Install on physical hardware for best experience

#### Missing Dependencies
If you encounter missing library errors:
```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libstdc++5:i386 libsdl1.2debian:i386 libopenal1:i386
```

### 🛠️ Troubleshooting

| Problem | Solution |
|---------|----------|
| No sound | Run `sudo apt-get install libsdl1.2debian:i386 libopenal1:i386` |
| Graphics issues | Check OpenGL drivers: `glxinfo \| grep OpenGL` |
| Game won't start | Check permissions: `chmod +x ~/Games/ut2003/System/ut2003-bin` |
| Icon not showing | Run `update-desktop-database ~/.local/share/applications` |

### 🗑️ Uninstallation

To completely remove UT2003:

```bash
# Remove game files
rm -rf ~/Games/ut2003

# Remove user configuration
rm -rf ~/.ut2003

# Remove desktop entry
rm ~/.local/share/applications/ut2003.desktop

# Remove icon
rm ~/.local/share/icons/ut2003.png
sudo rm /usr/share/icons/hicolor/128x128/apps/ut2003.png 2>/dev/null

# Update icon cache
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ 2>/dev/null
```

### 📝 Script Workflow

1. ✅ Detect system language
2. ✅ Check and install dependencies
3. ✅ Download UT2003 from Archive.org
4. ✅ Extract 7z and ISO files
5. ✅ Mount ISO and copy game files
6. ✅ Apply patch 2225.3
7. ✅ Configure CD key
8. ✅ Decompress .uz2 files
9. ✅ Configure OpenGL/SDL
10. ✅ Setup sound libraries
11. ✅ Create user configuration
12. ✅ Create desktop entry and icon
13. ✅ Create launcher script
14. ✅ Cleanup temporary files

### 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### ⚖️ Legal Notice

- This script downloads game files from Archive.org
- Unreal Tournament 2003 is owned by Epic Games
- This is an unofficial community installer
- Users are responsible for owning a legitimate copy of the game
- The included CD key is for demonstration purposes only

### 🙏 Credits

- **Epic Games** - Original game developers
- **Archive.org** - Game preservation
- **joshbarrass** - Patch hosting and Linux guides
- **Community** - Various Linux compatibility fixes

### 🔗 Useful Links

- [UT2003 on Archive.org](https://archive.org/details/unreal-tournament-2003-dvd.-7z)
- [Linux Gaming on Reddit](https://www.reddit.com/r/linux_gaming/)
- [ProtonDB](https://www.protondb.com/)

### 📧 Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Check existing issues before creating new ones

---

## Português

### 📋 Descrição

Este script automatiza o processo completo de instalação do **Unreal Tournament 2003** em sistemas Linux (Ubuntu/Debian e derivados). Ele cuida do download, extração, aplicação de patch e configuração do jogo para compatibilidade ideal com Linux.

### ✨ Funcionalidades

- 🌍 **Bilíngue**: Detecta automaticamente o idioma do sistema (Português/Inglês)
- 📦 **Totalmente Automatizado**: Baixa arquivos do jogo do Archive.org (~2.0 GB)
- 🔧 **Patch Automático**: Aplica o patch 2225.3 automaticamente
- 🎨 **Integração com Desktop**: Cria entrada no menu com ícone
- 🔑 **Configuração de CD Key**: Configura CD key automaticamente
- 🎵 **Configuração de Som**: Configura bibliotecas SDL e OpenAL
- 🖼️ **Renderização OpenGL**: Configura para gráficos nativos do Linux
- ✅ **Gerenciamento de Dependências**: Verifica e instala pacotes necessários

### 🖥️ Requisitos do Sistema

- **SO**: Ubuntu, Debian, Linux Mint ou derivados
- **Arquitetura**: 64-bit com suporte a bibliotecas 32-bit
- **Espaço em Disco**: ~10 GB (3.0 GB download + instalação)
- **RAM**: 512 MB mínimo
- **Gráficos**: GPU compatível com OpenGL

### 📦 Dependências

O script verificará e oferecerá instalação automática de:

- `wget` - Gerenciador de downloads
- `p7zip-full` - Extração de arquivos 7z
- `util-linux` - Suporte 32-bit
- `expect` - Automação do patch
- `imagemagick` - Conversão de ícones
- `libstdc++5:i386` - Biblioteca C++ 32-bit
- `libsdl1.2debian:i386` - Biblioteca SDL
- `libopenal1:i386` - Biblioteca OpenAL

### 🚀 Instalação

#### Instalação Rápida (Um Comando)

```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/ut2003-installer/main/UT2003_installer_Online_Linux.sh && chmod +x UT2003_installer_Online_Linux.sh && ./UT2003_installer_Online_Linux.sh
```

#### Instalação Manual

1. **Baixe o script:**
```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/ut2003-installer/main/UT2003_installer_Online_Linux.sh
```

2. **Torne-o executável:**
```bash
chmod +x UT2003_installer_Online_Linux.sh
```

3. **Execute o instalador:**
```bash
./UT2003_installer_Online_Linux.sh
```

4. **Siga as instruções na tela** - O script te guiará por cada etapa!

### 📂 Locais de Instalação

| Item | Localização |
|------|-------------|
| Arquivos do Jogo | `~/Games/ut2003/` |
| Configuração | `~/.ut2003/System/` |
| Atalho Desktop | `~/.local/share/applications/ut2003.desktop` |
| Ícone | `~/.local/share/icons/ut2003.png` |
| Launcher | `~/Games/ut2003/ut2003_launch.sh` |

### 🎮 Como Jogar

Após a instalação, você pode iniciar o jogo de três formas:

1. **Pelo Menu de Aplicativos**: Procure por "Unreal Tournament 2003"
2. **Usando o launcher**:
   ```bash
   ~/Games/ut2003/ut2003_launch.sh
   ```
3. **Execução direta**:
   ```bash
   cd ~/Games/ut2003/System && ./ut2003-bin
   ```

### 🔧 Configuração

O script configura automaticamente:
- ✅ Dispositivo de renderização OpenGL
- ✅ Gerenciador de viewport SDL
- ✅ Bibliotecas de som (SDL + OpenAL)
- ✅ CD Key (padrão incluída)
- ✅ Compatibilidade 32-bit

#### CD Key Personalizada

Se quiser usar sua própria CD key, edite:
```bash
nano ~/Games/ut2003/System/cdkey
```

Formato: `XXXXX-XXXXX-XXXXX-XXXXX`

### ⚠️ Problemas Conhecidos

#### Ambientes VirtualBox/VM
- **Problema**: Podem ocorrer erros de `libglc` ou OpenGL
- **Causa**: Aceleração 3D limitada em máquinas virtuais
- **Solução**: Instale em hardware físico para melhor experiência

#### Dependências Ausentes
Se encontrar erros de bibliotecas faltando:
```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install libstdc++5:i386 libsdl1.2debian:i386 libopenal1:i386
```

### 🛠️ Solução de Problemas

| Problema | Solução |
|----------|---------|
| Sem som | Execute `sudo apt-get install libsdl1.2debian:i386 libopenal1:i386` |
| Problemas gráficos | Verifique drivers OpenGL: `glxinfo \| grep OpenGL` |
| Jogo não inicia | Verifique permissões: `chmod +x ~/Games/ut2003/System/ut2003-bin` |
| Ícone não aparece | Execute `update-desktop-database ~/.local/share/applications` |

### 🗑️ Desinstalação

Para remover completamente o UT2003:

```bash
# Remover arquivos do jogo
rm -rf ~/Games/ut2003

# Remover configuração do usuário
rm -rf ~/.ut2003

# Remover atalho do desktop
rm ~/.local/share/applications/ut2003.desktop

# Remover ícone
rm ~/.local/share/icons/ut2003.png
sudo rm /usr/share/icons/hicolor/128x128/apps/ut2003.png 2>/dev/null

# Atualizar cache de ícones
sudo gtk-update-icon-cache /usr/share/icons/hicolor/ 2>/dev/null
```

### 📝 Fluxo do Script

1. ✅ Detectar idioma do sistema
2. ✅ Verificar e instalar dependências
3. ✅ Baixar UT2003 do Archive.org
4. ✅ Extrair arquivos 7z e ISO
5. ✅ Montar ISO e copiar arquivos do jogo
6. ✅ Aplicar patch 2225.3
7. ✅ Configurar CD key
8. ✅ Descomprimir arquivos .uz2
9. ✅ Configurar OpenGL/SDL
10. ✅ Configurar bibliotecas de som
11. ✅ Criar configuração do usuário
12. ✅ Criar entrada no desktop e ícone
13. ✅ Criar script launcher
14. ✅ Limpar arquivos temporários

### 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para enviar um Pull Request.

1. Faça um Fork do repositório
2. Crie sua branch de feature (`git checkout -b feature/NovaFuncionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/NovaFuncionalidade`)
5. Abra um Pull Request

### 📜 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

### ⚖️ Aviso Legal

- Este script baixa arquivos do jogo do Archive.org
- Unreal Tournament 2003 pertence à Epic Games
- Este é um instalador não-oficial da comunidade
- Usuários são responsáveis por possuir uma cópia legítima do jogo
- A CD key incluída é apenas para fins de demonstração

### 🙏 Créditos

- **Epic Games** - Desenvolvedores originais do jogo
- **Archive.org** - Preservação do jogo
- **joshbarrass** - Hospedagem de patches e guias Linux
- **Comunidade** - Várias correções de compatibilidade com Linux

### 🔗 Links Úteis

- [UT2003 no Archive.org](https://archive.org/details/unreal-tournament-2003-dvd.-7z)
- [Linux Gaming no Reddit](https://www.reddit.com/r/linux_gaming/)
- [ProtonDB](https://www.protondb.com/)

### 📧 Suporte

Para problemas, questões ou sugestões:
- Abra uma issue no GitHub
- Verifique issues existentes antes de criar novas

---

<div align="center">

**Made with ❤️ for the Linux Gaming Community**

**Feito com ❤️ para a Comunidade Linux Gaming**

⭐ **Se este projeto foi útil, deixe uma estrela!** ⭐

</div>
