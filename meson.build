project(
    'dcsms-applets',
    ['vala','c'],
    version:'0.0.1'
)

gtk= dependency('gtk+-3.0')
gio= dependency('gio-2.0')
glib= dependency('glib-2.0')
peas = dependency('libpeas-1.0', version: '>= 1.8.0')
budgie = dependency('budgie-1.0', version: '>= 2')


APPLETDIR = join_paths(get_option('prefix'), get_option('libdir'), 'budgie-desktop', 'plugins', meson.project_name())
DATADIR = join_paths(get_option('prefix'), get_option('datadir'))
meson.add_install_script('post-install.sh')

subdir('src')
