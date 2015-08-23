package org.threeframes.net.handler
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 处理句柄的标准接口
	 *
	 * @author harry
	 * @date 04.23 2010
	 *
	 */
	public interface IHandler
	{
		function listMessageInterests():Array;
		
		function handleMessage(msg:Object, header:String):void;
		
		/*
		 * 设置和获取网络服务的实体
		 *
		 *
		 */
		function setNetServiceInstance(instance:IExtendService):void;
		function getNetServiceInstance():IExtendService;
	}
}