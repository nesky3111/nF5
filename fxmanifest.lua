fx_version 'adamant'

game 'gta5'

dependency 'es_extended'

client_scripts {
	'@es_extended/locale.lua',
	'dependencies/pmenu.lua',
	'client.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua',
}
