package org.threeframes.model.entity
{
	/**
	 * 基础的zone类
	 * 
	 * @author harry
	 * @date 04.26 2010
	 * 
	 **/
	public class BaseZone
	{
		private var roomList:Array;
		private var name:String;
		
		public function BaseZone(name:String)
		{
			this.name = name;
			this.roomList = [];
		}
		
		public function getRoom(id:int):BaseRoom
		{
			return (roomList[id] as BaseRoom);
		}
		
		public function getRoomByName(name:String):BaseRoom
		{
			var room:BaseRoom = null;
			var found:Boolean = false;
			
			for (var key:String in roomList)
			{
				room = roomList[key] as BaseRoom
				
				if (room.getName() == name)
				{
					found = true;
					break;
				}	
			}
			
			if (found)
				return room;
			else
				return null;
		}
	}
}