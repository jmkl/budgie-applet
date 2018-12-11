public class DcsmsCpuTempSettings : Gtk.Box {
private GLib.Settings ? settings = null;
public DcsmsCpuTempSettings(GLib.Settings ? settings){
	Object();
	set_orientation(Gtk.Orientation.VERTICAL);
	set_spacing(10);
	this.settings = settings;
	var label = new Gtk.Label("Span style");
	label.set_markup("<b>Span Style</b>");
	var span_entry = new Gtk.Entry();
	add(label);
	add(span_entry);
	show_all();
	this.settings.bind("text-entry",span_entry,"text",SettingsBindFlags.DEFAULT);

}
}