fx_version 'cerulean'

game 'gta5'
lua54 'yes'

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}
