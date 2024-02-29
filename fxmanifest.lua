fx_version 'cerulean'
lua54 'yes'

game 'gta5'

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
}

shared_scripts {
    'config.lua',
    -- '@ox_lib/init.lua', -- uncomment if you want oxlib
}

client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}
