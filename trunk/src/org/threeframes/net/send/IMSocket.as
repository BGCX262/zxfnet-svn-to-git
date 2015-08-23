package org.threeframes.net.send
{
	import flash.events.IEventDispatcher;
	
	/**
	 * 扩展的自定义套接字
	 * 
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public interface IMSocket extends IEventDispatcher
	{
		/* 
		 * 发送消息
		 *
		 */
		function sendMessage(message:String, charSet:String='utf-8'):void;
		
		/*
		 * 关闭套接字
		 *
		 */
		function closeSocket():void;
		
		/*
		 * 添加数据到达的处理句柄
		 *
		 */
		function addDataComingHandler(listener:Function):void;
		
		/*
		 * 便捷的消息监听句柄
		 *
		 */
		function addConnectedHandler(listener:Function):void;
		function addIOErrorHandler(listener:Function):void;
		function addSecurityErrorHandler(listener:Function):void;
		function addDisConnectErrorHandler(listener:Function):void;
		
		
		
		/*
		 * 便捷的消息监听句柄
		 *
		 */
		function removeConnectedHandler(listener:Function):void;
		function removeDataComingHandler(listener:Function):void;
		function removeIOErrorHandler(listener:Function):void;
		function removeSecurityErrorHandler(listener:Function):void;
		function removeDisConnectErrorHandler(listener:Function):void;
		
	}
}