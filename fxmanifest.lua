fx_version 'cerulean'
game 'gta5'
lua54 'on'

name "k4_autopilot"
description "A FiveM ESX Script for Autopilot"
author "K4.dev"
version "1.0.0"

shared_scripts {
	'@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'shared/*.lua',
}

client_scripts {
	'client/*.lua',
	'locales/*.lua',
}

server_scripts {
	'server/*.lua',
	'locales/*.lua',
}

escrow_ignore {
  'shared/main.lua',
  'locales/*.lua',
}
