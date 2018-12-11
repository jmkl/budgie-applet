public class DcsmsCpuTemp : GLib.Object, Budgie.Plugin {
public Budgie.Applet get_panel_widget(string uuid)
{
	return new DcsmsCpuTempApplet(uuid);
}
}

public class DcsmsCpuTempApplet : Budgie.Applet {
private GLib.Settings ? settings = null;
public string uuid {public set; public get;}
Gtk.EventBox box = null;
Gtk.Label cpulabel;
CpuTempSensor sensor;
string span="%s";

public DcsmsCpuTempApplet(string uuid){
	Object(uuid: uuid);
	settings_schema="hello.dcsms.applet-cputemp";
	settings_prefix="/hello/dcsms/applet/cputemp";
	this.settings = get_applet_settings(uuid);
	this.settings.changed.connect(on_settings_changed);
	box = new Gtk.EventBox();
	add(box);
	this.cpulabel = new Gtk.Label("^_^");
	box.add(this.cpulabel);
	update_label(this.settings.get_string("text-entry"));
	box.show_all();
	show_all();
	GLib.Timeout.add(1000, () => {
			init();
			return false;
		});

}

private void init(){
	this.sensor = new CpuTempSensor();
	sensor.on_result.connect((result)=>{
			update_label(result.to_string());

		});
	sensor.run();
}

public override bool supports_settings(){
	return true;
}
private void update_label(string text){
	this.cpulabel.set_markup(span.printf(text));
}
protected void on_settings_changed(string key){
	switch (key) {
	case "text-entry":
		string span = this.settings.get_string(key);
		if("%s" in span) {
			this.span = span;
		}
		break;
	default:
		break;
	}

}

public override Gtk.Widget ? get_settings_ui(){
	return new DcsmsCpuTempSettings(this.get_applet_settings(uuid));

}
}

[ModuleInit]
public void peas_register_types(TypeModule module)
{
	// boilerplate - all modules need this
	var objmodule = module as Peas.ObjectModule;
	objmodule.register_extension_type(typeof(Budgie.Plugin), typeof(DcsmsCpuTemp));
}





