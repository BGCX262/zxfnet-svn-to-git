package org.threeframes.net.sets
{
	import org.threeframes.net.service.IExtendService;
	
	/**
	 * 实现对当前game、应用套接字的方便存取
	 * 这存在于多个套接字共存的情况
	 * 
	 * @author harry
	 * @date 04.25 2010
	 * 
	 **/
	public class NServiceManager
	{
		private static var _instance:NServiceManager=null;
		
		// simple one netservice
		private var _simpleService:IExtendService=null;
		private var _arrayServiceInstances:Array=null;
		
		public function NServiceManager(vo:OnlyOne)
		{
			if(vo == null)
				throw new Error('ERROR: IN SINGNAL MODEL!!!');	
				
			_arrayServiceInstances = new Array();
			
		}
		
		public static function getInstance():NServiceManager
		{
			if(_instance == null)
				_instance = new NServiceManager(new OnlyOne());
				
			return _instance;
		}
		
		public function getSimpleOne():IExtendService
		{
			return _simpleService;
		}
		
		public function registServiceInstanceByHost(host:String, instance:IExtendService):void
		{
			_arrayServiceInstances[host] = instance;
		}
		
		public function retireServiceInstanceByHost():IExtendService
		{
			return _arrayServiceInstances[host];
		}
		
		public function registSimpleServiceInstance(instance:IExtendService):void
		{
			_simpleService = instance;
		}
		
		
		
	}
}
class OnlyOne
{
	// only one
}