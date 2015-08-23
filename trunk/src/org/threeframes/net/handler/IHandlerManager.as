package org.threeframes.net.handler
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 一个套接字对应消息处理句柄管理器
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 * 
	 **/
	public interface IHandlerManager
	{
		/*
		 * 处理消息的句柄
		 *
		 *
		 */
		function handleMessage(message:Object):void;
		
		/*
		 * 安装处理消息的handler
		 *
		 *
		 */
		function addHandleParser(handler:IHandler):void;
		
		/*
		 * 设置和获取网络服务的实体
		 *
		 *
		 */
		function setNetServiceInstance(instance:IExtendService):void;
		function getNetServiceInstance():IExtendService;
		
		/* 
		 * 安装消息的parser
		 *
		 *
		 */
		function setMessageHeaderParser(fun:Function):void;
	}
}