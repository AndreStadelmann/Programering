package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author EpicToaster
	 */
	public class BoatCordinates 
	{
		
		private var plausibleBoatStartY:int;
		private var plausibleBoatStartX:int;
		
		private var boatCordinates:Point = new Point();	// do i get a point for this?
		
		public function BoatCordinates(vertical:Boolean):void	// Makes a cordinate that the boat starts at
		{
			if (vertical) // Limit the Y to not be to big so the ship fits
			{
				plausibleBoatStartY = 7;
				plausibleBoatStartX = 10;
			}
			else // Limit the x to not be to big so the ship fits
			{
				plausibleBoatStartY = 10;
				plausibleBoatStartX = 7;
			}
			
			boatCordinates.x = plausibleBoatStartY * Math.random();
			boatCordinates.y = plausibleBoatStartX * Math.random();
		}
		
		public function getBoatCoordinates():Point // returns the cordinate to it's master (Main)
		{
			return boatCordinates;
		}
		
	}

}