package org.threeframes.net.config
{
	/**
	 * 配置网络的ip和port
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public class NConfig
	{
		public var IP:String='';
		public var PORT:int=0;
		
		public function NConfig(strIp:String, intPort:int)
		{
			IP = strIp;
			PORT = intPort;
		}
	}
}