package org.threeframes.net.handler
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 基础的消息处理句柄
	 * 
	 * 注意：实际的应用中将继承该接口实现自己的parser，
	 * 并将消息进行对应的处理
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public class BaseHandler implements IHandler
	{
		protected var netServiceInstance:IExtendService;
		
		// message flag define
		
		
		
		public function BaseHandler()
		{
			
		}

		public function listMessageInterests():Array
		{
			return [];
		}
		
		public function handleMessage(msg:Object, header:String):void;
		{
			
			/*
			 * 添加具体的处理逻辑
			 *
			 */
			/*
			var xmlMessage:XML=null;
			if(msg is XML)
			{
				xmlMessage = msg as XML;
				
				//...
			}
			else
			{
				// ...
			}
			*/
			
			switch(header)
			{
				case '':
					// add deal with
					
					break;
				default:
					// add deal with
					
					break;
			}
		}
		
		/*
		 * 设置和获取网络服务的实体
		 *
		 *
		 */
		public function setNetServiceInstance(instance:IExtendService):void
		{
			netServiceInstance = instance;
		}
		
		public function getNetServiceInstance():IExtendService
		{
			return netServiceInstance;
		}
		
	}
}