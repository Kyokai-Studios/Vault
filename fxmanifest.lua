----------------------- [ Vault ] -----------------------
-- GitHub: https://github.com/Kyokai-Studios/Vault
-- Author: JaiFaim
-- Name: Vault
-- Version: 0.0.1
-- Description: Vault is a standalone economy management system, giving scripts easy access to this system.
----------------------- [ Vault ] -----------------------

fx_version "cerulean"
game "gta5"
lua54 'yes'
name 'Holo'
version '0.0.1'
description 'ault is a standalone economy management system, giving scripts easy access to this system.'
author 'JaiFaim'
contact 'https://discord.gg/Bd9BbbVQSv'
url 'https://github.com/Kyokai-Studios/Vault'

server_scripts {
    'config.lua',
    'src/player_account.lua',
    'src/player_manager.lua',
    'exemple.lua'
}