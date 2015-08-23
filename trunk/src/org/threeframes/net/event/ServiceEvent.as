package org.threeframes.net.event
{
	import flash.events.Event;

	/**
	 * 网络服务的事件定义
	 *
	 * @author harry
	 * @date 04.26 2010
	 * 
	 */
	public class ServiceEvent extends Event
	{
		// const
		public static const SERVICE_START:String='startedService';
		public static const SERVICE_CLOSE:String='closedService';
		public static const SERVICE_ERROR:String='errorService';
				
		public var detailMessage:String='';
		
		public function ServiceEvent(type:String, msg:String='', bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			detailMessage = msg;
		}
		
		override public function clone():Event
		{
			return new ServiceEvent(type, detailMessage);
		}
		
	}
}