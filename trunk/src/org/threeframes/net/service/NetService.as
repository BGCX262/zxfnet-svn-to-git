package org.threeframes.net.service
{
	import flash.events.EventDispatcher;
	import flash.net.Socket;
	
	import org.threeframes.net.event.ServiceEvent;
	import org.threeframes.net.event.SocketEvent;
	import org.threeframes.net.handler.IHandlerManager;
	import org.threeframes.net.send.IMSocket;
	import org.threeframes.net.send.MSocket;

	/**
	 *
	 * 提供网络数据的发送和处理的服务类
	 * 并提供额外的服务器功能
	 *
	 * 提示: 扩展该类实现提供更多的服务功能
	 * 
	 * @author harry
	 * @date 04.23 2010
	 *  
	 */
	public class NetService extends EventDispatcher implements IExtendService
	{
		// quote
		protected var _socket:IMSocket=null;
		protected var _handlerManager:IHandlerManager=null;
		
		// params
		protected var _type:String='';
		protected var _serviceStartListener:Function=null;
		protected var _serviceClosedListener:Function=null;
		protected var _serviceErrorListener:Function=null;
		
		public function NetService(type:String, host:String='', port:int=0, manager:IHandlerManager=null)
		{
			if(host != '' && port != 0)
			{
				_socket = new MSocket(host, port);
				configSocketEventListener( EventDispatcher(_socket) );
			}
			
			if(manager)
			{
				_handlerManager = manager;
				manager.setNetServiceInstance(this);
			}
				
		}
		
		public function setSocket(socket:IMSocket):void
		{
			_socket = socket;
			configSocketEventListener( EventDispatcher(_socket) );
		}
		
		public function setHandleManager(manager:IHandlerManager):void
		{
			_handlerManager = manager;
			
			/*
			 * set me
			 */
			_handlerManager.setNetServiceInstance(this);
		}
		
		public function sendMessage(msg:String, charset:String='utf-8'):void
		{
			_socket.sendMessage(msg, charset);
		}
		
		public function sendXMLMessage(httpObj:Object, headerObj:Object, bodyObj:Object, charset:String='utf-8'):void
		{
			var httpMsg:String = constructHttp( httpObj );
			var headerMsg:String = constructHeader( headerObj );
			var bodyMsg:String = bodyObj.toString();
			var endHeader:String = '</Msg>'
			var contentMsg:String = headerMsg + bodyMsg + endHeader;
			
			/*
			一种组合格式
				
				var bytes:ByteArray = new ByteArray();
				bytes.writeMultiByte(bodyMsg, charset);
				var sendMsg:String = httpMsg + (bytes.length+1) + "\n\n" + contentMsg;
			*/
			
			var message:String = '';
			//message = sendMsg;
			message = httpMsg+'\n\n'+contentMsg;
			
			_socket.sendMessage(message, charset);
		}
		
		protected function constructHttp(obj:Object):String
		{
			var http:String = "POST /sns HTTP/1.1\n";
			for (var item:String in obj)
			{
				http +=item + obj[item] + "\n";
			}
			http += "Content-Length:";
			
			return http;
		}
		
		protected function constructHeader(obj:Object):String
		{
			var header:String = "<Msg><Header";
			
			for (var item:String in obj)
			{
				header += ' ' + item + '="' + obj[item] + '"';
			}
			header += " />";
			
			return header;
		}
		
		protected function configSocketEventListener(listener:EventDispatcher, isAdd:Boolean=true):void
		{
			if(isAdd)
			{
				_socket.addDataComingHandler( onDataComingHandler );
				_socket.addDisConnectErrorHandler( onDisConnectHandler );
				_socket.addIOErrorHandler( onIoErrorHandler );
				_socket.addSecurityErrorHandler( onSecurityErrorHandler );
				_socket.addConnectedHandler( onConnedHandler );
			}
			else
			{
				_socket.removeDataComingHandler( onDataComingHandler );
				_socket.removeDisConnectErrorHandler( onDisConnectHandler );
				_socket.removeIOErrorHandler( onIoErrorHandler );
				_socket.removeSecurityErrorHandler( onSecurityErrorHandler );
				_socket.removeConnectedHandler( onConnedHandler );
			}
		}
		
		/*
		 * 处理服务器的消息
		 *
		 *
		 */
		protected function onDataComingHandler(evt:SocketEvent):void
		{
			var message:String = evt.message;
			
			_handlerManager.handleMessage(message);
		}
		
		private function onDisConnectHandler(evt:SocketEvent):void
		{
			dispatchEvent( new ServiceEvent(ServiceEvent.SERVICE_CLOSE, evt.type) );
		}
		
		private function onIoErrorHandler(evt:SocketEvent):void
		{
			dispatchEvent( new ServiceEvent(ServiceEvent.SERVICE_ERROR, evt.type) );
		}
		
		private function onSecurityErrorHandler(evt:SocketEvent):void
		{
			dispatchEvent( new ServiceEvent(ServiceEvent.SERVICE_ERROR, evt.type) );
		}
		
		private function onConnedHandler(evt:SocketEvent):void
		{
			dispatchEvent( new ServiceEvent(ServiceEvent.SERVICE_START) );
		}
		
		/*
		 * 便捷的方式觉知服务连接、关闭事件
		 *
		 */
		public function addServiceStartedHandler(listener:Function):void
		{
			if(listener != null)
			{
				_serviceStartListener = listener;
				addEventListener(ServiceEvent.SERVICE_START, listener);
			}
		}
		
		public function addServiceErrorHandler(listener:Function):void
		{
			if(listener != null)
			{
				_serviceErrorListener = listener;
				addEventListener(ServiceEvent.SERVICE_ERROR, listener);
			}
		}
		
		public function addServiceClosedHandler(listener:Function):void
		{
			if(listener != null)
			{
				_serviceClosedListener = listener;
				addEventListener(ServiceEvent.SERVICE_CLOSE, listener);
			}
		}
		
		/*
		 * 提供不同的模块删去句柄的接口
		 *
		 */
		public function removeServiceStartedHandler(listener:Function):void
		{
			removeEventListener(ServiceEvent.SERVICE_START, listener);
		}
		
		public function removeServiceErrorHandler(listener:Function):void
		{
			removeEventListener(ServiceEvent.SERVICE_ERROR, listener);
		}
		
		public function removeServiceClosedHandler(listener:Function):void
		{
			removeEventListener(ServiceEvent.SERVICE_CLOSE, listener);
		}
		
		/**
		 * 关闭服务
		 * 
		 **/
		public function closeService():void
		{
			dispose();
			
			if(_serviceStartListener != null)
				removeEventListener(ServiceEvent.SERVICE_START, _serviceStartListener);
			if(_serviceErrorListener != null)
				removeEventListener(ServiceEvent.SERVICE_ERROR, _serviceErrorListener);
			if(_serviceClosedListener != null)
				removeEventListener(ServiceEvent.SERVICE_CLOSE, _serviceClosedListener);
		}
		
		/**
		 * 自动释放资源的接口
		 * 
		 * 
		 **/
		public function dispose():void
		{
			configSocketEventListener(Socket(_socket), false);
			
			if(_socket)
				_socket.closeSocket();
				
			
			
		}
	}
}