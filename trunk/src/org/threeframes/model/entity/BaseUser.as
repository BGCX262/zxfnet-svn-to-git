package org.threeframes.model.entity
{
	/**
	 * 基础的用户信息类
	 * 
	 * @author harry
	 * @date 04.26 2010
	 * 
	 **/
	public class BaseUser
	{
		// params
		private var id:int;
		private var name:String;
		private var variables:Array;
		
		private var _isSpectators:Boolean;
		private var _isRoomCreator:Boolean;
		private var pId:int;
		
		public function BaseUser(id:int, name:String)
		{
			id = id;
			name = name;
		}
		
		public function getId():int
		{
			return id;
		}
		
		public function getName():String
		{
			return name;
		}
		
		public function getVariable(varName:String):*
		{
			return this.variables[varName];
		}
		
		public function getVariables():Array
		{
			return this.variables;
		}
		
		public function setVariables(o:Object):void
		{
			// only string, number, boolean
			for (var key:String in o)
			{
				var v:* = o[key];
				if (v != null)
					this.variables[key] = v;
				else
					delete this.variables[key];
			} 
		}
		
		public function clearVariables():void
		{
			this.variables = [];
		}
		
		public function setSpectators(b:Boolean):void
		{
			_isSpectators = b;
		}
		
		public function isSpectators():Boolean
		{
			return _isSpectators;
		}
		
		public function setRoomCreator(b:Boolean):void
		{
			_isRoomCreator = b;
		}
		
		public function isRoomCreator():Boolean
		{
			return _isRoomCreator;
		}
		
		public function getPlayerId():int
		{
			return pId;
		}
		
		public function setPlayerId(id:int):void
		{
			pId = id;
		}
		
	}
}