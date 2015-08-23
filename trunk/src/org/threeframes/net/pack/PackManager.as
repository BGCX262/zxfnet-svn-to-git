package org.threeframes.net.pack
{
	/**
	 * 管理消息的组装
	 * 
	 * @author harry
	 * @date 04.25 2010
	 * 
	 **/
	public class PackManager
	{
		public function PackManager()
		{
			
		}
		
		public static function getProtocolPackedMessage(ipacker:IProtocolPacker):String
		{
			return ipacker.getPackedMessage();
		}

	}
}