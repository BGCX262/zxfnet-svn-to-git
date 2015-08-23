package org.threeframes.net.common
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 模块具有通信能力的接口
	 * 任何模块只要实现了该接口，可以通过框架设置其
	 * 通信instance，从而使其具备通信能力
	 * 
	 * @author harry
	 * @date 04.26 2010
	 * 
	 **/
	public interface INServiceModule
	{
		/*
		 * 模块具有通信能力的接口
		 * 
		 * 
		 * @params instance 具备通信能力的实体
		 * @params args 具备通信能力的实体的其他实体
		 *
		 **/
		function setNServiceInstance(instance:IExtendService, ...args):void;
	}
}