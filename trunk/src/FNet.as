package {
	import flash.display.Sprite;
	
	import org.threeframes.model.entity.BaseRoom;
	import org.threeframes.model.entity.BaseUser;
	import org.threeframes.model.entity.BaseZone;
	import org.threeframes.net.event.ServiceEvent;
	import org.threeframes.net.handler.HandlerManager;
	import org.threeframes.net.service.IExtendService;
	import org.threeframes.net.service.NetService;

	public class FNet extends Sprite
	{
		private var instance:IExtendService=null;
		
		public function FNet()
		{
			instance = new NetService('', '127.0.0.1',8080, HandlerManager.getInstance());
			instance.addServiceStartedHandler( onConnectHandler );
			instance.addServiceErrorHandler( onServiceErrorHandler );
		}
		
		private function onConnectHandler(evt:ServiceEvent):void
		{
			instance.sendMessage('Hello world!');
			
		}
		
		private function onServiceErrorHandler(evt:ServiceEvent):void
		{
			trace('ERROR: ',evt.detailMessage);
			
			instance.closeService();
			
			var b:BaseRoom = new BaseRoom(1,'wzx',10,10,true,true,true,true,10,10);
			var z:BaseZone = new BaseZone('zone');
			var u:BaseUser = new BaseUser(10,'wzx');
			
		}
		
		
	}
}
