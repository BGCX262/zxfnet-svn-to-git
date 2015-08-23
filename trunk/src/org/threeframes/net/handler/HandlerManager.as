package org.threeframes.net.handler
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 消息处理句柄的管理器
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 * 
	 **/
	public class HandlerManager implements IHandlerManager
	{
		// instance
		private static var _instance:HandlerManager=null;
		
		// params
		private var arrayHandlers:Array=null;
		private var netServiceInstance:IExtendService=null;
		private var headerParser:Function=null;
		
		public function HandlerManager(vo:OnlyOne)
		{
			if(vo == null)
				throw new Error('ERROR: IN SINGNAL MODEL!!!');
			
			arrayHandlers = [];
		}
		
		public static function getInstance():HandlerManager
		{
			if(_instance == null)
				_instance = new HandlerManager(new OnlyOne());
				
			return _instance;
		}
		
		/*
		 * 处理消息的句柄
		 *
		 *
		 */
		public function handleMessage(message:Object):void
		{
			trace('INFO: HANDLE MESSAGE>> ', message.toString());
			
			var xmlMessage:XML = null;
			var messageHeader:String = null;
			var handler:IHandler = null;
			if(message is XML)
			{
				messageHeader = parseMessageHeader( message );
				handler = arrayHandlers[messageHeader];
				if(handler)
				{
					handler.handleMessage(message, messageHeader);
				}
				else
				{
					trace('ERROR: CANNOT FIND A MESSAGE HANDLER.')
				}
			}
			else
			{
				// other extend code(json or string)
				messageHeader = parseMessageHeader( message );
				handler = arrayHandlers[messageHeader];
				if(handler)
				{
					handler.handleMessage(message, messageHeader);
				}
				else
				{
					trace('ERROR: CANNOT FIND A MESSAGE HANDLER.')
				}
			}
		}
		
		/* 
		 * 安装消息的parser
		 *
		 *
		 */
		public function setMessageHeaderParser(fun:Function):void
		{
			headerParser = fun;
		}
		
		public function parseMessageHeader(msg:Object):String
		{
			/*
			 * 重写该函数，解析出消息标签
			 *
			 */
			/*
			 一种基本的xml格式的消息
			<Header Name='' Type='req' From='uid' To='' Group='sns' uid=''>
				<Body Type='messageFlag' Room='' >
					<Login Zone='zone1' userId='' pwd='' encoding=''>
						<userName></userName>
						<pwd></pwd>
					</Login>
				</Body>
			</Header>
			*/
			var message:String = '';
			if(headerParser != null)
				message = headerParser(msg);
			else
				message = msg.toString();
			
			return message;
		} 
		
		/*
		 * 安装处理消息的handler
		 *
		 *
		 */
		public function addHandleParser(handler:IHandler):void
		{
			var arrayMessageInterests:Array = handler.listMessageInterests();
			if(arrayMessageInterests.length > 0)
			{
				var len:uint = arrayMessageInterests.length;
				var notifyName:String = '';
				for(var i:uint=0; i<len; i++)
				{
					notifyName = arrayMessageInterests[i];
					if(arrayHandlers[notifyName])
					{
						// 一个消息对应不重复的处理句柄
						var arrayTemp:Array = arrayHandlers[notifyName];
						var len2:uint = arrayTemp.length;
						for(var k:uint=0; k<len2; k++)
						{
							if(arrayTemp[k] == handler)
								return;
						}
						
						arrayHandlers[notifyName].push( handler );
						handler.setNetServiceInstance( netServiceInstance );
						
					}
					else
					{
						arrayHandlers[notifyName] = [];
						arrayHandlers[notifyName].push(handler)
						handler.setNetServiceInstance( netServiceInstance );
					}
				}
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
		
		public function dispose():void
		{
			if(arrayHandlers)
			{
				for(var prop:String in arrayHandlers)
					arrayHandlers[prop] = null;
			}
		}
		
	}
}
class OnlyOne
{
	// ...

}