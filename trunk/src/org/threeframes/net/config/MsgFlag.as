package org.threeframes.net.config
{
	/**
	 * 特殊消息格式标签
	 * 
	 * @author harry
	 * @date 04.23 2010
	 * 
	 **/
	public class MsgFlag
	{
		public static var MSG_END:int=0x00;
		
		// msg type
		public static const MSG_TYPE_XML:String = "xml";
		public static const MSG_TYPE_STR:String = "str";
		public static const MSG_TYPE_JSON:String = "json";
		
		// flags
		public static const MSG_XML:String  = "<";
		public static const MSG_JSON:String = "{";
		public static const MSG_STR:String  = "%";
	}
}