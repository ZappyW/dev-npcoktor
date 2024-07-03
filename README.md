# FiveM Doctor NPC Script

This script adds doctor NPCs to specific locations in your FiveM server. Players can interact with these NPCs to get revived in exchange for money from their bank account. The script supports both qb-target and ox-target systems.

## Features
- Spawn doctor NPCs at specified coordinates.
- Interact with NPCs using qb-target or ox-target.
- Revive players for a fee deducted from their bank account.
- NPCs are invincible and stationary.

## Installation

### Requirements
- QBCore Framework
- qb-target or ox-target

### Instructions
1. Clone or download this repository.
2. Add the script to your FiveM resources folder.
3. Ensure the required dependencies are installed and configured correctly.
4. Add the following line to your `server.cfg` file: ensure dev-npcdoktor


5. Edit the `config.lua` file to specify NPC coordinates, target system, and revive cost.

## Configuration

### config.lua
```lua
Config = {}

Config.NPCs = {
 {coords = vector3(312.2, -592.9, 43.3), heading = 90.0, model = 's_m_m_doctor_01'},
 {coords = vector3(314.2, -592.9, 43.3), heading = 90.0, model = 's_m_m_doctor_01'},
}

Config.TargetSystem = "qb-target" -- or "ox-target"

Config.ReviveCost = 500 -- Revive cost in bank money

----------------------------------------------------------------------------------------

# FiveM Doktor NPC Scripti

Bu script, FiveM sunucunuza belirli konumlara doktor NPC'leri ekler. Oyuncular bu NPC'lerle etkileşime girerek banka hesaplarından para karşılığında kendilerini diriltebilirler. Script, hem qb-target hem de ox-target sistemlerini destekler.

## Özellikler
- Belirtilen koordinatlarda doktor NPC'leri oluşturur.
- NPC'lerle qb-target veya ox-target kullanarak etkileşime geçin.
- Oyuncuları banka hesaplarından alınan bir ücret karşılığında diriltin.
- NPC'ler yenilmez ve hareketsizdir.

## Kurulum

### Gereksinimler
- QBCore Framework
- qb-target veya ox-target

### Talimatlar
1. Bu depoyu klonlayın veya indirin.
2. Script'i FiveM kaynaklar klasörünüze ekleyin.
3. Gerekli bağımlılıkların kurulu ve doğru şekilde yapılandırıldığından emin olun.
4. `server.cfg` dosyanıza şu satırı ekleyin: ensure dev-npcdoktor
5. NPC koordinatlarını, target sistemini ve diriltme maliyetini belirlemek için `config.lua` dosyasını düzenleyin.

## Yapılandırma

### config.lua
```lua
Config = {}

Config.NPCs = {
 {coords = vector3(312.2, -592.9, 43.3), heading = 90.0, model = 's_m_m_doctor_01'},
 {coords = vector3(314.2, -592.9, 43.3), heading = 90.0, model = 's_m_m_doctor_01'},
}

Config.TargetSystem = "qb-target" -- veya "ox-target"

Config.ReviveCost = 500 -- Banka parasıyla diriltme maliyeti

