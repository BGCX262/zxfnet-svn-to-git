package org.threeframes.net.service
{
	/**
	 * 扩展的服务接口
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public interface IExtendService extends IService
	{
		/*
		 * 发送字符串格式消息
		 *
		 */
		function sendMessage(msg:String, charset:String='utf-8'):void;
		
		/*
		 * 发送xml格式的消息
		 *
		 *
		 */
		function sendXMLMessage(httpObj:Object, headerObj:Object, bodyObj:Object, charset:String='utf-8'):void
	}
}