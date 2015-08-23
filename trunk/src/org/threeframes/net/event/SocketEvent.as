package org.threeframes.net.event
{
	import flash.events.Event;
	
	/**
	 * 复写socket事件 
	 * 
	 * @author harry
	 * @date 04.26 2010
	 * 
	 **/
	public class SocketEvent extends Event
	{
		public static const IO_ERROR:String='ioTypeError';
		public static const SECURITY_ERROR:String='securitytTypeError';
		public static const DIS_CONNECT:String='connectClosed';
		public static const GET_CONNECT:String='connected';
		public static const DATA_COMING:String='dataComing';
		
		public var message:String='';// socket data
		
		public function SocketEvent(type:String, msg:String=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			message = msg;
		}
	
		override public function clone():Event
		{
			return new SocketEvent(type, message, bubbles, cancelable);
		}
	}
}