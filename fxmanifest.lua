fx_version 'cerulean'

game 'gta5'

ui_page 'html/index.html'

files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
}

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua',
}

client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}
