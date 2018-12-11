
public class CpuTempSensor {
GLib.File thermal;
GLib.MainLoop loop=null;
private bool is_run = false;
public signal void on_result(int result);
public CpuTempSensor(){
	this.thermal = File.new_for_path("/sys/class/thermal/thermal_zone0/temp");
	this.loop = new MainLoop();
}
public void run(){
	if(this.loop.is_running())
		return;

	this.is_run = true;
	do_stuff.begin((obj,res)=>{
			loop.quit();
		});
	loop.run();
}
private async void do_stuff(){
	while(is_run) {
		yield get_value(1000);
	}
}
private async void get_value(uint interval,int priority = GLib.Priority.DEFAULT){
	SourceFunc callback = get_value.callback;
	int result = 0;
	GLib.Timeout.add(interval,()=>{
			result=get_temp();
			on_result(result);
			GLib.Idle.add((owned) callback);
			return false;
		},priority);
	yield;
}
public void destroy(){
	if(loop.is_running()) {
		loop.quit();
	}
	this.is_run = false;

}
private int get_temp(){
	int result=0;
	if(thermal.query_exists()) {
		try{
			var dis = new DataInputStream(thermal.read());
			string line;
			while((line = dis.read_line(null))!=null) {
				result = int.parse(line)/1000;
			}
			dis.close();

		}catch(Error e) {

		}
	}
	return result;

}
}
