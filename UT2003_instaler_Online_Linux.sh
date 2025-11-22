#!/bin/bash

# Bilingual Automatic Installation Script for Unreal Tournament 2003 on Linux
# Script de Instalacao Automatica do Unreal Tournament 2003 para Linux
# Author/Autor: Script automatizado
# Date/Data: 2025

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration variables
INSTALL_DIR="$HOME/Games/ut2003"
TEMP_DIR="/tmp/ut2003_install"
GAME_URL="https://archive.org/download/unreal-tournament-2003-dvd.-7z/Unreal%20Tournament%202003%20DVD.7z"
PATCH_URL="https://github.com/joshbarrass/ut2003-on-linux/raw/master/archive/ut2003_2225beta3-multilanguage.update.run"
GAME_7Z="$TEMP_DIR/ut2003.7z"
GAME_ISO="$TEMP_DIR/ut2003.iso"
MOUNT_POINT="$TEMP_DIR/mount"

# Default CD Key
DEFAULT_CDKEY="LYR22-RZ743-A9D7T-CNNEN"

# Detect system language
detect_language() {
    if [[ "$LANG" =~ ^pt ]]; then
        SCRIPT_LANG="pt"
    else
        SCRIPT_LANG="en"
    fi
}

# Language strings
declare -A MSG

# Portuguese messages
MSG[pt_info]="INFO"
MSG[pt_warning]="AVISO"
MSG[pt_error]="ERRO"
MSG[pt_checking_deps]="Verificando dependencias"
MSG[pt_deps_missing]="Dependencias faltando"
MSG[pt_install_with]="Instale com"
MSG[pt_install_deps_now]="Deseja instalar as dependencias agora? (s/n): "
MSG[pt_cannot_continue]="Nao e possivel continuar sem as dependencias."
MSG[pt_deps_ok]="Todas as dependencias estao OK!"
MSG[pt_creating_dirs]="Criando diretorios"
MSG[pt_dirs_created]="Diretorios criados:"
MSG[pt_installation]="Instalacao"
MSG[pt_temporary]="Temporario"
MSG[pt_downloading_game]="Baixando Unreal Tournament 2003 (2.0 GB)"
MSG[pt_may_take_long]="Isso pode demorar bastante dependendo da sua conexao..."
MSG[pt_file_exists]="Arquivo 7z ja existe. Pulando download."
MSG[pt_download_failed]="Falha ao baixar o jogo"
MSG[pt_download_complete]="Download concluido!"
MSG[pt_extracting_7z]="Extraindo arquivo 7z"
MSG[pt_iso_exists]="ISO ja existe. Pulando extracao."
MSG[pt_extract_failed]="Falha ao extrair o arquivo 7z"
MSG[pt_iso_not_found]="ISO nao encontrada apos extracao"
MSG[pt_iso_extracted]="ISO extraida com sucesso!"
MSG[pt_mounting_iso]="Montando ISO e copiando arquivos"
MSG[pt_mount_failed]="Falha ao montar a ISO"
MSG[pt_iso_mounted]="ISO montada em"
MSG[pt_copying_files]="Copiando arquivos para"
MSG[pt_copy_failed]="Falha ao copiar arquivos"
MSG[pt_iso_unmounted]="ISO desmontada"
MSG[pt_fixing_perms]="Corrigindo permissoes..."
MSG[pt_files_copied]="Arquivos copiados e permissoes corrigidas!"
MSG[pt_downloading_patch]="Baixando e aplicando patch 2225.3 (nao-interativo)"
MSG[pt_downloading]="Baixando patch..."
MSG[pt_patch_failed]="Falha ao baixar o patch"
MSG[pt_applying_patch]="Aplicando patch automaticamente..."
MSG[pt_patch_apply_failed]="Falha ao aplicar o patch"
MSG[pt_trying_manual]="Tentando aplicacao manual..."
MSG[pt_patch_success]="Patch aplicado com sucesso!"
MSG[pt_configuring_cdkey]="Configurando CD Key automaticamente"
MSG[pt_inserting_cdkey]="Inserindo CD Key padrao"
MSG[pt_cdkey_configured]="CD Key configurado automaticamente!"
MSG[pt_change_cdkey]="Se precisar alterar, edite"
MSG[pt_decompressing_uz2]="Descomprimindo arquivos .uz2"
MSG[pt_may_take_minutes]="Isso pode demorar alguns minutos..."
MSG[pt_found_uz2]="Encontrados"
MSG[pt_uz2_files]="arquivos .uz2 para descomprimir"
MSG[pt_uz2_failed]="Falha ao descomprimir arquivos .uz2"
MSG[pt_uz2_complete]="Arquivos .uz2 descomprimidos e removidos!"
MSG[pt_configuring_render]="Configurando dispositivo de renderizacao"
MSG[pt_configuring_file]="Configurando"
MSG[pt_render_configured]="Dispositivo de renderizacao configurado para OpenGL!"
MSG[pt_configuring_sound]="Configurando bibliotecas de som"
MSG[pt_creating_symlink]="Criando link simbolico para"
MSG[pt_link_created]="Link criado"
MSG[pt_lib_not_found]="nao encontrada no sistema"
MSG[pt_sound_configured]="Bibliotecas de som configuradas!"
MSG[pt_configuring_user]="Configurando diretorio do usuario"
MSG[pt_creating_dir]="Criando diretorio"
MSG[pt_copying_config]="Copiando arquivos de configuracao..."
MSG[pt_config_complete]="Configuracao do usuario concluida!"
MSG[pt_config_files_in]="Arquivos de config em"
MSG[pt_creating_shortcut]="Criando atalho no menu do sistema"
MSG[pt_converting_icon]="Convertendo icone .ico para .png..."
MSG[pt_convert_failed]="Falha ao converter icone, usando icone do sistema"
MSG[pt_icon_converted]="Icone convertido e salvo em"
MSG[pt_copying_icon_sys]="Copiando icone para diretorio do sistema..."
MSG[pt_icon_copied_sys]="Icone copiado para"
MSG[pt_cannot_copy_sys]="Nao foi possivel copiar para diretorio do sistema (requer sudo)"
MSG[pt_icon_not_found]="Icone nao encontrado em"
MSG[pt_cache_updated]="Cache do menu atualizado"
MSG[pt_shortcut_created]="Atalho criado no menu do sistema"
MSG[pt_file]="Arquivo"
MSG[pt_creating_launcher]="Criando launcher"
MSG[pt_launcher_created]="Launcher criado"
MSG[pt_cleanup]="Limpeza"
MSG[pt_remove_temp]="Deseja remover os arquivos temporarios? (s/n): "
MSG[pt_removing_temp]="Removendo arquivos temporarios..."
MSG[pt_cleanup_complete]="Limpeza concluida!"
MSG[pt_temp_kept]="Arquivos temporarios mantidos em"
MSG[pt_install_complete]="INSTALACAO CONCLUIDA!"
MSG[pt_success_msg]="Unreal Tournament 2003 instalado com sucesso!"
MSG[pt_install_dir]="Diretorio de instalacao"
MSG[pt_to_play]="Para jogar, execute:"
MSG[pt_or_launcher]="Ou use o launcher:"
MSG[pt_menu_available]="O jogo tambem esta disponivel no menu de aplicativos!"
MSG[pt_important_notes]="NOTAS IMPORTANTES:"
MSG[pt_cdkey_inserted]="CD Key inserido automaticamente"
MSG[pt_user_config]="As configuracoes de usuario ficam em"
MSG[pt_config_files]="Arquivos de config ja configurados com OpenGL e SDL"
MSG[pt_multiplayer]="Para servidores multiplayer, configure as portas necessarias"
MSG[pt_sound_links]="O som esta configurado com links simbolicos para SDL e OpenAL"
MSG[pt_shortcut_in]="Atalho criado em"
MSG[pt_icon_installed]="Icone instalado em"
MSG[pt_enjoy]="Divirta-se!"
MSG[pt_installer_title]="INSTALADOR AUTOMATICO - UNREAL TOURNAMENT 2003"
MSG[pt_for_linux]="para Linux (Ubuntu/Debian)"
MSG[pt_script_will]="Este script ira:"
MSG[pt_step1]="1. Baixar UT2003 (~2.0 GB)"
MSG[pt_step2]="2. Extrair e instalar o jogo"
MSG[pt_step3]="3. Aplicar patch 2225.3"
MSG[pt_step4]="4. Configurar para Linux"
MSG[pt_step5]="5. Inserir CD Key automaticamente"
MSG[pt_continue_q]="Deseja continuar? (s/n): "
MSG[pt_install_cancelled]="Instalacao cancelada."
MSG[pt_lib_missing]="nao esta instalado."
MSG[pt_install_q]="Deseja instalar? (s/n): "
MSG[pt_sound_libs_missing]="Bibliotecas de som faltando"

# English messages
MSG[en_info]="INFO"
MSG[en_warning]="WARNING"
MSG[en_error]="ERROR"
MSG[en_checking_deps]="Checking dependencies"
MSG[en_deps_missing]="Missing dependencies"
MSG[en_install_with]="Install with"
MSG[en_install_deps_now]="Do you want to install the dependencies now? (y/n): "
MSG[en_cannot_continue]="Cannot continue without dependencies."
MSG[en_deps_ok]="All dependencies are OK!"
MSG[en_creating_dirs]="Creating directories"
MSG[en_dirs_created]="Directories created:"
MSG[en_installation]="Installation"
MSG[en_temporary]="Temporary"
MSG[en_downloading_game]="Downloading Unreal Tournament 2003 (2.0 GB)"
MSG[en_may_take_long]="This may take a while depending on your connection..."
MSG[en_file_exists]="7z file already exists. Skipping download."
MSG[en_download_failed]="Failed to download the game"
MSG[en_download_complete]="Download complete!"
MSG[en_extracting_7z]="Extracting 7z file"
MSG[en_iso_exists]="ISO already exists. Skipping extraction."
MSG[en_extract_failed]="Failed to extract 7z file"
MSG[en_iso_not_found]="ISO not found after extraction"
MSG[en_iso_extracted]="ISO extracted successfully!"
MSG[en_mounting_iso]="Mounting ISO and copying files"
MSG[en_mount_failed]="Failed to mount ISO"
MSG[en_iso_mounted]="ISO mounted at"
MSG[en_copying_files]="Copying files to"
MSG[en_copy_failed]="Failed to copy files"
MSG[en_iso_unmounted]="ISO unmounted"
MSG[en_fixing_perms]="Fixing permissions..."
MSG[en_files_copied]="Files copied and permissions fixed!"
MSG[en_downloading_patch]="Downloading and applying patch 2225.3 (non-interactive)"
MSG[en_downloading]="Downloading patch..."
MSG[en_patch_failed]="Failed to download patch"
MSG[en_applying_patch]="Applying patch automatically..."
MSG[en_patch_apply_failed]="Failed to apply patch"
MSG[en_trying_manual]="Trying manual application..."
MSG[en_patch_success]="Patch applied successfully!"
MSG[en_configuring_cdkey]="Configuring CD Key automatically"
MSG[en_inserting_cdkey]="Inserting default CD Key"
MSG[en_cdkey_configured]="CD Key configured automatically!"
MSG[en_change_cdkey]="If you need to change it, edit"
MSG[en_decompressing_uz2]="Decompressing .uz2 files"
MSG[en_may_take_minutes]="This may take a few minutes..."
MSG[en_found_uz2]="Found"
MSG[en_uz2_files]=".uz2 files to decompress"
MSG[en_uz2_failed]="Failed to decompress .uz2 files"
MSG[en_uz2_complete]=".uz2 files decompressed and removed!"
MSG[en_configuring_render]="Configuring render device"
MSG[en_configuring_file]="Configuring"
MSG[en_render_configured]="Render device configured for OpenGL!"
MSG[en_configuring_sound]="Configuring sound libraries"
MSG[en_creating_symlink]="Creating symbolic link for"
MSG[en_link_created]="Link created"
MSG[en_lib_not_found]="not found on system"
MSG[en_sound_configured]="Sound libraries configured!"
MSG[en_configuring_user]="Configuring user directory"
MSG[en_creating_dir]="Creating directory"
MSG[en_copying_config]="Copying configuration files..."
MSG[en_config_complete]="User configuration complete!"
MSG[en_config_files_in]="Config files in"
MSG[en_creating_shortcut]="Creating system menu shortcut"
MSG[en_converting_icon]="Converting .ico icon to .png..."
MSG[en_convert_failed]="Failed to convert icon, using system icon"
MSG[en_icon_converted]="Icon converted and saved to"
MSG[en_copying_icon_sys]="Copying icon to system directory..."
MSG[en_icon_copied_sys]="Icon copied to"
MSG[en_cannot_copy_sys]="Could not copy to system directory (requires sudo)"
MSG[en_icon_not_found]="Icon not found at"
MSG[en_cache_updated]="Menu cache updated"
MSG[en_shortcut_created]="Shortcut created in system menu"
MSG[en_file]="File"
MSG[en_creating_launcher]="Creating launcher"
MSG[en_launcher_created]="Launcher created"
MSG[en_cleanup]="Cleanup"
MSG[en_remove_temp]="Do you want to remove temporary files? (y/n): "
MSG[en_removing_temp]="Removing temporary files..."
MSG[en_cleanup_complete]="Cleanup complete!"
MSG[en_temp_kept]="Temporary files kept in"
MSG[en_install_complete]="INSTALLATION COMPLETE!"
MSG[en_success_msg]="Unreal Tournament 2003 installed successfully!"
MSG[en_install_dir]="Installation directory"
MSG[en_to_play]="To play, run:"
MSG[en_or_launcher]="Or use the launcher:"
MSG[en_menu_available]="The game is also available in the applications menu!"
MSG[en_important_notes]="IMPORTANT NOTES:"
MSG[en_cdkey_inserted]="CD Key inserted automatically"
MSG[en_user_config]="User configuration is in"
MSG[en_config_files]="Config files already configured with OpenGL and SDL"
MSG[en_multiplayer]="For multiplayer servers, configure necessary ports"
MSG[en_sound_links]="Sound is configured with symbolic links to SDL and OpenAL"
MSG[en_shortcut_in]="Shortcut created at"
MSG[en_icon_installed]="Icon installed at"
MSG[en_enjoy]="Enjoy!"
MSG[en_installer_title]="AUTOMATIC INSTALLER - UNREAL TOURNAMENT 2003"
MSG[en_for_linux]="for Linux (Ubuntu/Debian)"
MSG[en_script_will]="This script will:"
MSG[en_step1]="1. Download UT2003 (~2.0 GB)"
MSG[en_step2]="2. Extract and install the game"
MSG[en_step3]="3. Apply patch 2225.3"
MSG[en_step4]="4. Configure for Linux"
MSG[en_step5]="5. Insert CD Key automatically"
MSG[en_continue_q]="Do you want to continue? (y/n): "
MSG[en_install_cancelled]="Installation cancelled."
MSG[en_lib_missing]="is not installed."
MSG[en_install_q]="Do you want to install it? (y/n): "
MSG[en_sound_libs_missing]="Missing sound libraries"

# Get message in current language
get_msg() {
    local key="${SCRIPT_LANG}_$1"
    echo "${MSG[$key]}"
}

# Check yes/no answer in both languages
check_yes() {
    local answer="$1"
    if [[ "$answer" =~ ^[SsYy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Auxiliary functions
print_info() {
    echo -e "${GREEN}[$(get_msg info)]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[$(get_msg warning)]${NC} $1"
}

print_error() {
    echo -e "${RED}[$(get_msg error)]${NC} $1"
}

print_step() {
    echo -e "\n${GREEN}===================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}===================================${NC}\n"
}

check_dependencies() {
    print_step "$(get_msg checking_deps)"
    
    local missing_deps=()
    
    command -v wget >/dev/null 2>&1 || missing_deps+=("wget")
    command -v 7z >/dev/null 2>&1 || missing_deps+=("p7zip-full")
    command -v linux32 >/dev/null 2>&1 || missing_deps+=("util-linux")
    command -v expect >/dev/null 2>&1 || missing_deps+=("expect")
    command -v convert >/dev/null 2>&1 || missing_deps+=("imagemagick")
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "$(get_msg deps_missing): ${missing_deps[*]}"
        print_info "$(get_msg install_with): sudo apt-get install ${missing_deps[*]}"
        
        read -p "$(get_msg install_deps_now)" install_deps
        if check_yes "$install_deps"; then
            sudo apt-get update
            sudo apt-get install -y "${missing_deps[@]}"
        else
            print_error "$(get_msg cannot_continue)"
            exit 1
        fi
    fi
    
    if ! dpkg -l 2>/dev/null | grep -q "libstdc++5:i386"; then
        print_warning "libstdc++5:i386 $(get_msg lib_missing)"
        read -p "$(get_msg install_q)" install_lib
        if check_yes "$install_lib"; then
            sudo dpkg --add-architecture i386 2>/dev/null || true
            sudo apt-get update
            sudo apt-get install -y libstdc++5:i386
        fi
    fi
    
    local sound_libs_missing=()
    
    if ! dpkg -l 2>/dev/null | grep -q "libsdl1.2debian:i386"; then
        sound_libs_missing+=("libsdl1.2debian:i386")
    fi
    
    if ! dpkg -l 2>/dev/null | grep -q "libopenal1:i386"; then
        sound_libs_missing+=("libopenal1:i386")
    fi
    
    if [ ${#sound_libs_missing[@]} -ne 0 ]; then
        print_warning "$(get_msg sound_libs_missing): ${sound_libs_missing[*]}"
        read -p "$(get_msg install_q)" install_sound
        if check_yes "$install_sound"; then
            sudo dpkg --add-architecture i386 2>/dev/null || true
            sudo apt-get update
            sudo apt-get install -y "${sound_libs_missing[@]}"
        fi
    fi
    
    print_info "$(get_msg deps_ok)"
}

create_directories() {
    print_step "$(get_msg creating_dirs)"
    
    mkdir -p "$TEMP_DIR"
    mkdir -p "$MOUNT_POINT"
    mkdir -p "$INSTALL_DIR"
    
    print_info "$(get_msg dirs_created)"
    print_info "  - $(get_msg installation): $INSTALL_DIR"
    print_info "  - $(get_msg temporary): $TEMP_DIR"
}

download_game() {
    print_step "$(get_msg downloading_game)"
    print_warning "$(get_msg may_take_long)"
    
    if [ -f "$GAME_7Z" ]; then
        print_info "$(get_msg file_exists)"
    else
        wget --continue --progress=bar:force:noscroll \
             -O "$GAME_7Z" "$GAME_URL" || {
            print_error "$(get_msg download_failed)"
            exit 1
        }
        print_info "$(get_msg download_complete)"
    fi
}

extract_7z() {
    print_step "$(get_msg extracting_7z)"
    
    if [ -f "$GAME_ISO" ]; then
        print_info "$(get_msg iso_exists)"
    else
        7z x "$GAME_7Z" -o"$TEMP_DIR" || {
            print_error "$(get_msg extract_failed)"
            exit 1
        }
        
        ISO_FILE=$(find "$TEMP_DIR" -name "*.iso" | head -n 1)
        if [ -z "$ISO_FILE" ]; then
            print_error "$(get_msg iso_not_found)"
            exit 1
        fi
        mv "$ISO_FILE" "$GAME_ISO"
        print_info "$(get_msg iso_extracted)"
    fi
}

mount_and_copy() {
    print_step "$(get_msg mounting_iso)"
    
    sudo mount -o loop "$GAME_ISO" "$MOUNT_POINT" || {
        print_error "$(get_msg mount_failed)"
        exit 1
    }
    
    print_info "$(get_msg iso_mounted) $MOUNT_POINT"
    print_info "$(get_msg copying_files) $INSTALL_DIR..."
    
    sudo cp -R "$MOUNT_POINT"/* "$INSTALL_DIR/" || {
        print_error "$(get_msg copy_failed)"
        sudo umount "$MOUNT_POINT"
        exit 1
    }
    
    sudo umount "$MOUNT_POINT"
    print_info "$(get_msg iso_unmounted)"
    
    print_info "$(get_msg fixing_perms)"
    sudo chown --recursive "$USER:$USER" "$INSTALL_DIR"
    find "$INSTALL_DIR" -type d -print0 | xargs -0 chmod 0775
    find "$INSTALL_DIR" -type f -print0 | xargs -0 chmod 0664
    
    print_info "$(get_msg files_copied)"
}

download_and_apply_patch() {
    print_step "$(get_msg downloading_patch)"
    
    PATCH_FILE="$TEMP_DIR/ut2003_patch.run"
    
    if [ ! -f "$PATCH_FILE" ]; then
        print_info "$(get_msg downloading)"
        wget -O "$PATCH_FILE" "$PATCH_URL" || {
            print_error "$(get_msg patch_failed)"
            exit 1
        }
    fi
    
    chmod +x "$PATCH_FILE"
    
    print_info "$(get_msg applying_patch)"
    
    EXPECT_SCRIPT="$TEMP_DIR/patch_expect.exp"
    
    cat > "$EXPECT_SCRIPT" << 'EOFEXP'
#!/usr/bin/expect -f

set timeout 300
set install_dir [lindex $argv 0]

spawn linux32 [lindex $argv 1] --target $install_dir

expect {
    "Please enter" {
        send "n\r"
        exp_continue
    }
    "Do you want to*README*" {
        send "n\r"
        exp_continue
    }
    "*README*" {
        send "n\r"
        exp_continue
    }
    "Do you want*apply*update*" {
        send "y\r"
        exp_continue
    }
    "*apply*update*" {
        send "y\r"
        exp_continue
    }
    "Please enter the installation path*" {
        send "$install_dir\r"
        exp_continue
    }
    "*installation path*" {
        send "$install_dir\r"
        exp_continue
    }
    eof
}

catch wait result
exit [lindex $result 3]
EOFEXP

    chmod +x "$EXPECT_SCRIPT"
    
    "$EXPECT_SCRIPT" "$INSTALL_DIR" "$PATCH_FILE" || {
        print_error "$(get_msg patch_apply_failed)"
        print_warning "$(get_msg trying_manual)"
        
        (echo "n"; echo "y"; echo "$INSTALL_DIR") | linux32 "$PATCH_FILE" --target "$INSTALL_DIR" || {
            print_error "$(get_msg patch_apply_failed)"
            exit 1
        }
    }
    
    rm -f "$EXPECT_SCRIPT"
    print_info "$(get_msg patch_success)"
}

setup_cdkey() {
    print_step "$(get_msg configuring_cdkey)"
    
    print_info "$(get_msg inserting_cdkey): $DEFAULT_CDKEY"
    
    echo "$DEFAULT_CDKEY" > "$INSTALL_DIR/System/cdkey"
    chmod 664 "$INSTALL_DIR/System/cdkey"
    
    print_info "[OK] $(get_msg cdkey_configured)"
    print_warning "$(get_msg change_cdkey): $INSTALL_DIR/System/cdkey"
}

decompress_uz2() {
    print_step "$(get_msg decompressing_uz2)"
    print_warning "$(get_msg may_take_minutes)"
    
    cd "$INSTALL_DIR/System"
    
    uz2_count=$(find .. -type f -name "*.uz2" 2>/dev/null | wc -l)
    print_info "$(get_msg found_uz2) $uz2_count $(get_msg uz2_files)"
    
    find .. -type f -name "*.uz2" -exec ./ucc-bin decompress "{}" -nohomedir \; -exec rm "{}" \; || {
        print_error "$(get_msg uz2_failed)"
        exit 1
    }
    
    cd - > /dev/null
    print_info "$(get_msg uz2_complete)"
}

configure_render_device() {
    print_step "$(get_msg configuring_render)"
    
    for config_file in "$INSTALL_DIR/System/UT2003.ini" "$INSTALL_DIR/System/User.ini"; do
        if [ -f "$config_file" ]; then
            print_info "$(get_msg configuring_file) $config_file"
            
            cp "$config_file" "$config_file.bak"
            
            sed -i 's/^RenderDevice=D3DDrv.D3DRenderDevice/;RenderDevice=D3DDrv.D3DRenderDevice/' "$config_file"
            sed -i 's/^;RenderDevice=OpenGLDrv.OpenGLRenderDevice/RenderDevice=OpenGLDrv.OpenGLRenderDevice/' "$config_file"
            
            sed -i 's/^ViewportManager=WinDrv.WindowsClient/;ViewportManager=WinDrv.WindowsClient/' "$config_file"
            sed -i 's/^;ViewportManager=SDLDrv.SDLClient/ViewportManager=SDLDrv.SDLClient/' "$config_file"
        fi
    done
    
    print_info "$(get_msg render_configured)"
}

fix_sound_libraries() {
    print_step "$(get_msg configuring_sound)"
    
    cd "$INSTALL_DIR/System"
    
    print_info "$(get_msg creating_symlink) libSDL-1.2.so.0..."
    if [ -f "/usr/lib/i386-linux-gnu/libSDL-1.2.so.0" ]; then
        ln -sf /usr/lib/i386-linux-gnu/libSDL-1.2.so.0 libSDL-1.2.so.0
        print_info "[OK] $(get_msg link_created) libSDL-1.2.so.0"
    elif [ -f "/usr/lib/libSDL-1.2.so.0" ]; then
        ln -sf /usr/lib/libSDL-1.2.so.0 libSDL-1.2.so.0
        print_info "[OK] $(get_msg link_created) libSDL-1.2.so.0"
    else
        print_warning "libSDL-1.2.so.0 $(get_msg lib_not_found)"
        print_info "Install with: sudo apt-get install libsdl1.2debian:i386"
    fi
    
    print_info "$(get_msg creating_symlink) openal.so..."
    if [ -f "/usr/lib/i386-linux-gnu/libopenal.so.1" ]; then
        ln -sf /usr/lib/i386-linux-gnu/libopenal.so.1 openal.so
        print_info "[OK] $(get_msg link_created) openal.so"
    elif [ -f "/usr/lib/libopenal.so.1" ]; then
        ln -sf /usr/lib/libopenal.so.1 openal.so
        print_info "[OK] $(get_msg link_created) openal.so"
    else
        print_warning "libopenal.so.1 $(get_msg lib_not_found)"
        print_info "Install with: sudo apt-get install libopenal1:i386"
    fi
    
    cd - > /dev/null
    print_info "$(get_msg sound_configured)"
}

setup_user_config() {
    print_step "$(get_msg configuring_user)"
    
    USER_CONFIG_DIR="$HOME/.ut2003/System"
    
    print_info "$(get_msg creating_dir): $USER_CONFIG_DIR"
    mkdir -p "$USER_CONFIG_DIR"
    
    print_info "$(get_msg copying_config)"
    
    if [ -f "$INSTALL_DIR/System/UT2003.ini" ]; then
        cp "$INSTALL_DIR/System/UT2003.ini" "$USER_CONFIG_DIR/"
        print_info "[OK] UT2003.ini"
    fi
    
    if [ -f "$INSTALL_DIR/System/User.ini" ]; then
        cp "$INSTALL_DIR/System/User.ini" "$USER_CONFIG_DIR/"
        print_info "[OK] User.ini"
    fi
    
    chmod -R 775 "$HOME/.ut2003"
    
    print_info "$(get_msg config_complete)"
    print_info "$(get_msg config_files_in): $USER_CONFIG_DIR"
}

create_desktop_entry() {
    print_step "$(get_msg creating_shortcut)"
    
    DESKTOP_FILE="$HOME/.local/share/applications/ut2003.desktop"
    ICON_SOURCE="$INSTALL_DIR/Help/unreal.ico"
    ICON_PNG="$HOME/.local/share/icons/ut2003.png"
    
    mkdir -p "$HOME/.local/share/applications"
    mkdir -p "$HOME/.local/share/icons"
    
    if [ -f "$ICON_SOURCE" ]; then
        print_info "$(get_msg converting_icon)"
        
        if command -v convert &> /dev/null; then
            convert "$ICON_SOURCE" -resize 128x128 "$ICON_PNG" 2>/dev/null || {
                print_warning "$(get_msg convert_failed)"
                ICON_PNG="applications-games"
            }
            
            if [ -f "$ICON_PNG" ]; then
                print_info "[OK] $(get_msg icon_converted): $ICON_PNG"
                
                if [ -d "/usr/share/icons/hicolor/128x128/apps" ]; then
                    print_info "$(get_msg copying_icon_sys)"
                    sudo cp "$ICON_PNG" "/usr/share/icons/hicolor/128x128/apps/ut2003.png" 2>/dev/null && {
                        print_info "[OK] $(get_msg icon_copied_sys) /usr/share/icons/hicolor/128x128/apps/"
                        sudo gtk-update-icon-cache /usr/share/icons/hicolor/ 2>/dev/null || true
                    } || print_warning "$(get_msg cannot_copy_sys)"
                fi
            fi
        else
            print_warning "$(get_msg convert_failed)"
            ICON_PNG="applications-games"
        fi
    else
        print_warning "$(get_msg icon_not_found): $ICON_SOURCE"
        ICON_PNG="applications-games"
    fi
    
    cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Unreal Tournament 2003
Comment=Unreal Tournament 2003 - First Person Shooter
Exec=$INSTALL_DIR/ut2003_launch.sh
Path=$INSTALL_DIR/System
Icon=$ICON_PNG
Terminal=false
Categories=Game;ActionGame;
Keywords=game;fps;shooter;unreal;
EOF

    chmod +x "$DESKTOP_FILE"
    
    if command -v update-desktop-database &> /dev/null; then
        update-desktop-database "$HOME/.local/share/applications" 2>/dev/null
        print_info "[OK] $(get_msg cache_updated)"
    fi
    
    print_info "[OK] $(get_msg shortcut_created)"
    print_info "$(get_msg file): $DESKTOP_FILE"
}

create_launcher() {
    print_step "$(get_msg creating_launcher)"
    
    LAUNCHER="$INSTALL_DIR/ut2003_launch.sh"
    
    cat > "$LAUNCHER" << 'EOF'
#!/bin/bash

# UT2003 Launcher
cd "$(dirname "$0")/System"
./ut2003-bin "$@"
EOF
    
    chmod +x "$LAUNCHER"
    
    print_info "$(get_msg launcher_created): $LAUNCHER"
}

cleanup() {
    print_step "$(get_msg cleanup)"
    
    read -p "$(get_msg remove_temp)" clean
    
    if check_yes "$clean"; then
        print_info "$(get_msg removing_temp)"
        rm -rf "$TEMP_DIR"
        print_info "$(get_msg cleanup_complete)"
    else
        print_info "$(get_msg temp_kept): $TEMP_DIR"
    fi
}

show_summary() {
    print_step "$(get_msg install_complete)"
    
    echo ""
    print_info "==================================================="
    print_info "  $(get_msg success_msg)"
    print_info "==================================================="
    echo ""
    print_info "$(get_msg install_dir): $INSTALL_DIR"
    echo ""
    print_info "$(get_msg to_play)"
    echo "  cd $INSTALL_DIR/System && ./ut2003-bin"
    echo ""
    print_info "$(get_msg or_launcher)"
    echo "  $INSTALL_DIR/ut2003_launch.sh"
    echo ""
    print_info "$(get_msg menu_available)"
    echo ""
    print_warning "$(get_msg important_notes)"
    echo "  - $(get_msg cdkey_inserted): $DEFAULT_CDKEY"
    echo "  - $(get_msg user_config): ~/.ut2003/"
    echo "  - $(get_msg config_files)"
    echo "  - $(get_msg multiplayer)"
    echo "  - $(get_msg sound_links)"
    echo "  - $(get_msg shortcut_in): ~/.local/share/applications/ut2003.desktop"
    echo "  - $(get_msg icon_installed): ~/.local/share/icons/ut2003.png"
    echo ""
    print_info "$(get_msg enjoy)"
    echo ""
}

main() {
    detect_language
    
    clear
    echo ""
    echo "==================================================="
    echo "  $(get_msg installer_title)"
    echo "       $(get_msg for_linux)"
    echo "==================================================="
    echo ""
    
    print_warning "$(get_msg script_will)"
    echo "  $(get_msg step1)"
    echo "  $(get_msg step2)"
    echo "  $(get_msg step3)"
    echo "  $(get_msg step4)"
    echo "  $(get_msg step5)"
    echo ""
    print_info "$(get_msg install_dir): $INSTALL_DIR"
    echo ""
    
    read -p "$(get_msg continue_q)" continue
    if ! check_yes "$continue"; then
        print_info "$(get_msg install_cancelled)"
        exit 0
    fi
    
    check_dependencies
    create_directories
    download_game
    extract_7z
    mount_and_copy
    download_and_apply_patch
    setup_cdkey
    decompress_uz2
    configure_render_device
    fix_sound_libraries
    setup_user_config
    create_desktop_entry
    create_launcher
    cleanup
    show_summary
}

main
