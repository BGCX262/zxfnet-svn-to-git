package org.threeframes.net.service
{
	import flash.events.IEventDispatcher;
	
	import org.threeframes.net.handler.IHandlerManager;
	import org.threeframes.net.send.IMSocket;
	
	/**
	 * NetService基础接口规范
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public interface IService extends IEventDispatcher
	{
		/*
		 * 设置socket，这将使得你可以自由的扩展
		 *
		 *
		 */
		function setSocket(socket:IMSocket):void;
		
		/*
		 * 设置消息处理句柄，这将使得你可以自由的扩展
		 *
		 *
		 */
		function setHandleManager(manager:IHandlerManager):void;
		
		/*
		 * 便捷的方式觉知服务连接、关闭事件
		 *
		 */
		function addServiceStartedHandler(listener:Function):void;
		function addServiceErrorHandler(listener:Function):void;
		function addServiceClosedHandler(listener:Function):void;
		
		/*
		 * 提供不同的模块删去句柄的接口
		 *
		 */
		function removeServiceStartedHandler(listener:Function):void;
		function removeServiceErrorHandler(listener:Function):void;
		function removeServiceClosedHandler(listener:Function):void;
		
		/*
		 * 关闭服务
		 *
		 */
		function closeService():void;
	}
}