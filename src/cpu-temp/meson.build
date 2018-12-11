CPUTEMPDIR = APPLETDIR + '.cpu-temp'

me_src=[
    'CpuTempApplet.vala',
    'CpuTempSetting.vala',
    'CpuTempSensor.vala']

shared_library(
    'dcsms-cputemp',    
    me_src,
    dependencies:[
        gtk,
        budgie,
        peas
    ],
    c_args:[
        '-DGMENU_I_KNOW_THIS_IS_UNSTABLE',
    ],
    install:true,
    install_dir:CPUTEMPDIR
)

custom_target('dcsms-cputemp',
    input : 'CpuTempApplet.plugin',
    output : 'CpuTempApplet.plugin',
    command : ['cp', '@INPUT@', '@OUTPUT@'],
    install : true,
    install_dir: CPUTEMPDIR
)

install_data(
    'hello.dcsms.applet.cputemp.gschema.xml',
    install_dir: join_paths(DATADIR, 'glib-2.0', 'schemas'),
)
