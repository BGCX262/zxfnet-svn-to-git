package org.threeframes.net.pack
{
	/**
	 * 消息组装接口
	 * 
	 * @author harry
	 * @date 04.25 2010
	 * 
	 **/
	public interface IProtocolPacker
	{
		/*
		 * 获取一个消息组装后的格式化消息
		 *
		 */
		function getPackedMessage():String;
	}
}