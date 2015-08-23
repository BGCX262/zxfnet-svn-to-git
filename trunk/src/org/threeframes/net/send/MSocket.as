package org.threeframes.net.send
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	
	import org.threeframes.net.config.MsgFlag;
	import org.threeframes.net.event.SocketEvent;

	public class MSocket extends Socket implements IMSocket
	{
		// params
		protected var dataBytes:ByteArray=null;
		protected var charCodingType:String='utf-8';
		
		// handlers
		protected var dataComingListener:Function=null;
		protected var ioErrorListener:Function=null;
		protected var securityErrorListener:Function=null;
		protected var disConnErrorListener:Function=null;
		protected var connectedListener:Function=null;
		
		public function MSocket(host:String=null, port:int=0)
		{
			super(host, port);
			
			dataBytes = new ByteArray();
			configureListeners();
		}
		
		protected function configureListeners(isAdd:Boolean=true):void 
		{
			if(isAdd)
			{
		        addEventListener(Event.CLOSE, closeHandler);
		        addEventListener(Event.CONNECT, connectHandler);
		        addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		        addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		        addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		 	}
		 	else
		 	{
		 		removeEventListener(Event.CLOSE, closeHandler);
		        removeEventListener(Event.CONNECT, connectHandler);
		        removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		        removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		        removeEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		 	}
    	}

		private function closeHandler(event:Event):void 
		{
        	trace("closeHandler: " + event);
        	
        	dispatchEvent( new SocketEvent(SocketEvent.DIS_CONNECT) );
    	}

    	private function connectHandler(event:Event):void 
    	{
        	trace("connectHandler: " + event);
        	
        	dispatchEvent( new SocketEvent(SocketEvent.GET_CONNECT) );
    	}

    	private function ioErrorHandler(event:IOErrorEvent):void 
    	{
        	trace("ioErrorHandler: " + event);
        	
        	dispatchEvent( new SocketEvent(SocketEvent.IO_ERROR) );
    	}

    	private function securityErrorHandler(event:SecurityErrorEvent):void 
    	{
        	trace("securityErrorHandler: " + event);
        	
        	dispatchEvent( new SocketEvent(SocketEvent.SECURITY_ERROR) );
    	}
		
		/**
		 * 当收到服务器发送的消息的处理句柄
		 * 
		 * 注意：你可以添加自己的处理解析句柄或者
		 * 覆盖该方法
		 * 
		 * @author harry
		 * @date 04.23 2010
		 * 
		 * 
		 **/
    	protected function socketDataHandler(event:ProgressEvent):void 
    	{
        	trace("socketDataHandler: " + event);
        	
        	/*var byte:int=0;
        	while(bytesAvailable)
        	{
        		byte = readByte();
        		if(byte != MsgFlag.MSG_END)
        		{
        			dataBytes.writeByte(byte);
        		}
        		else
        		{
        			// notify observer
        			var message:String = dataBytes.toString();
        			dispatchEvent( new SocketEvent(SocketEvent.DATA_COMING, message) );
        			
        			dataBytes = null;
        			dataBytes = new ByteArray();// reset
        		}
        	}*/
        	
        	if(bytesAvailable)
        	{
        		var message:String = readMultiByte(bytesAvailable, charCodingType);
        		dispatchEvent( new SocketEvent(SocketEvent.DATA_COMING, message) );
        	}
    	}
    	
    	public function closeSocket():void
    	{
    		if(connected)
    			close();
    		
    		configureListeners(false);
    		
    		if(dataComingListener != null)
    			removeEventListener(SocketEvent.DATA_COMING, dataComingListener);
    		if(connectedListener != null)
    			removeEventListener(SocketEvent.GET_CONNECT, connectedListener);
    		if(ioErrorListener != null)
    			removeEventListener(SocketEvent.IO_ERROR, ioErrorListener);
    		if(securityErrorListener != null)
    			removeEventListener(SocketEvent.SECURITY_ERROR, securityErrorListener);
    		if(disConnErrorListener != null)
    			removeEventListener(SocketEvent.DIS_CONNECT, disConnErrorListener);
    	}
    	
    	/**
    	 * 将字符串消息发送到服务器，采用charSet指定的格式
    	 * 
    	 * 
    	 **/
    	public function sendMessage(message:String, charSet:String='utf-8'):void
    	{
    		charCodingType = charSet;// save charset
    		
    		var bytes:ByteArray = new ByteArray();
    		message += '\n';
    		bytes.writeMultiByte(message, charSet);
    		//bytes.writeByte(MsgFlag.MSG_END);
    		writeBytes(bytes);
    		flush();
    	}
    	
    	public function addDataComingHandler(listener:Function):void
    	{
    		if(listener != null)
    		{
    			dataComingListener = listener;
    			addEventListener(SocketEvent.DATA_COMING, dataComingListener);
    		}
    	}
    	
    	public function addConnectedHandler(listener:Function):void
    	{
    		if(listener != null)
    		{
    			connectedListener = listener;
    			addEventListener(SocketEvent.GET_CONNECT, listener);
    		}
    	}
    	
    	public function addIOErrorHandler(listener:Function):void
    	{
    		if(listener != null)
			{
				ioErrorListener = listener;
				addEventListener(SocketEvent.IO_ERROR, ioErrorListener);
			}
    	}
		
		public function addSecurityErrorHandler(listener:Function):void
		{
			if(listener != null)
			{
				securityErrorListener = listener;
				addEventListener(SocketEvent.SECURITY_ERROR, securityErrorListener);
			}
		}
		
		public function addDisConnectErrorHandler(listener:Function):void
		{
			if(listener != null)
			{
				disConnErrorListener = listener;
				addEventListener(SocketEvent.DIS_CONNECT, disConnErrorListener);
			}
		}
    	
    	public function removeDataComingHandler(listener:Function):void
    	{
    		if(dataComingListener != null)
    			removeEventListener(SocketEvent.DATA_COMING, dataComingListener);
    		
    	}
    	
    	public function removeConnectedHandler(listener:Function):void
    	{
    		if(connectedListener != null)
    			removeEventListener(SocketEvent.GET_CONNECT, connectedListener);
    	}
    	
		public function removeIOErrorHandler(listener:Function):void
		{
			if(ioErrorListener != null)
    			removeEventListener(SocketEvent.DATA_COMING, ioErrorListener);
    		
		}
		
		public function removeSecurityErrorHandler(listener:Function):void
		{
			if(securityErrorListener != null)
    			removeEventListener(SocketEvent.DATA_COMING, securityErrorListener);
    		
		}
		
		public function removeDisConnectErrorHandler(listener:Function):void
		{
			if(disConnErrorListener != null)
    			removeEventListener(SocketEvent.DATA_COMING, disConnErrorListener);
		}
    	
	}
}