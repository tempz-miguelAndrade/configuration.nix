# ❄️ NixOS Config - COSMIC Desktop & Intel 13th Gen

Este repositório contém os arquivos de configuração do meu **NixOS (24.11)**, otimizado para um notebook Acer com processador **Intel Core i5 de 13ª Geração**.

O sistema foca no uso da interface **COSMIC (Epoch)**, performance em Wayland e compatibilidade com Dual Boot.

---

## 🚀 Destaques do Sistema

* **Interface:** COSMIC Desktop Environment (Wayland Nativo).
* **Kernel:** `linuxPackages_latest` (Kernel Linux mais recente para suporte a hardware moderno).
* **Bootloader:** GRUB configurado especificamente para partições EFI pequenas (100MB) e Dual Boot.
* **Performance:** * `zramSwap` habilitado para gerenciamento de memória.
  * `thermald` para controle térmico da Intel.
  * Otimizações de GPU Intel (`i915.enable_guc=2`).

---

## 📂 Estrutura dos Arquivos

| Arquivo | Descrição |
| :--- | :--- |
| **`configuration.nix`** | Arquivo central. Define boot, hardware, serviços, usuários e o ambiente COSMIC. |
| **`hardware-configuration.nix`** | Mapeamento automático dos discos e sistemas de arquivos. |
| **`programas.nix`** | Inventário de pacotes organizado por categorias (Essenciais, Dev, Social, etc.). |
| **`visual.nix`** | Configurações de shell, aliases (atalhos) e variáveis de ambiente visuais. |

---

## 📦 Softwares Instalados (`programas.nix`)

Os aplicativos foram separados em blocos lógicos para fácil manutenção:

* **Essenciais:** `git`, `vim`, `wget`, `curl`, `unzip`, `starship`, `ncdu`.
* **Social & Web:** `discord`, `spotify`, `obsidian`, `tor-browser`, `firefox`.
* **Desenvolvimento:** `vscode`, `pywal`, `figlet`.
* **Sistema & Hardware:** `gparted`, `pavucontrol`, `networkmanagerapplet`, `intel-gpu-tools`, `libva-utils`.
* **Estética (Terminal):** `cava`, `neofetch`, `btop`, `cmatrix`, `neo`, `peaclock`, `sl`.
* **COSMIC Apps:** `cosmic-term`, `cosmic-files`.

---

## ⌨️ Atalhos e Aliases (`visual.nix`)

Para agilizar o fluxo de trabalho no terminal:

| Alias | Comando Executado | Função |
| :--- | :--- | :--- |
| `rebuild` | `sudo nixos-rebuild switch` | Aplica as mudanças na configuração do NixOS. |
| `limpar` | `sudo nix-collect-garbage -d` | Remove gerações antigas e libera espaço. |
| `matrix` | `neo -D` | Executa o efeito visual Matrix no terminal. |
| `ll` | `ls -l` | Listagem detalhada de arquivos. |

---

## 🔧 Configurações Específicas de Hardware

### 1. Bootloader (Dual Boot Friendly)
Para resolver o problema de espaço na partição EFI do Windows (100MB), o GRUB foi configurado com:
* `configurationLimit = 3`: Mantém apenas as 3 últimas gerações.
* `copyKernels = false`: Lê o kernel direto da partição raiz, economizando espaço na EFI.
* `efiInstallAsRemovable = true`: Garante boot em BIOS Acer/HP rebeldes.

### 2. Gráficos Intel & Wayland
* Drivers de aceleração: `intel-media-driver` e `libvdpau-va-gl`.
* Variável `NIXOS_OZONE_WL = "1"`: Força apps Electron (VSCode, Discord) a rodarem nativamente no Wayland (sem borrões).
* Monitoramento: Suporte ao `intel_gpu_top` para verificar uso da GPU.

### 3. Monitores
Script de fallback para X11 (`xrandr`) configurado para:
* **HDMI-1:** 1920x1080 (Primário).
* **eDP-1:** 1366x768 (Tela do notebook, Secundário à direita).

---

## 🧼 Manutenção Automática
O sistema se mantém limpo e otimizado automaticamente:
* **Garbage Collection:** Semanal, deleta arquivos com mais de 7 dias.
* **Otimização do Store:** Deduplicação automática de arquivos no `/nix/store`.
* **SSD Trim:** Serviço `fstrim` ativo para saúde do NVMe.
