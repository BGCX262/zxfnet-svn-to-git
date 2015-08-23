package org.threeframes.net.pack
{
	/**
	 * 消息包装类的基础类
	 * 
	 * 注意： 实际应用中将继承该类，实现自己的包装功能，并
	 * 重写getPackedMessage方法
	 * 
	 * @author harry
	 * @date 04.25 2010
	 * 
	 **/
	public class BasePacker implements IProtocolPacker
	{
		public function BasePacker()
		{
			
		}

		public function getPackedMessage():String
		{
			return '';
		}
		
	}
}