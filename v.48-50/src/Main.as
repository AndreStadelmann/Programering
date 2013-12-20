package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author EpicToaster
	 */
	public class Main extends Sprite 
	{
		private var yRad:Vector.<Vector.<Sprite>> = new Vector.<Vector.<Sprite>>();
		private var miss:int;
		private var hit:int;
		private var t:TextField = new TextField();
		private var imgSize:int = 32;
		private var boatCordinates:Point = new Point;
		private var theBoatCordinatesX:int = 0;
		private var theBoatCordinatesY:int = 0;
		private var vertical:Boolean;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			for (var i:int = 0; i < 10; i++)	// Creating first boxes and putting them into a 2d mapp with 2 arrays
			{
					var	xRad:Vector.<Sprite> = new Vector.<Sprite>();
					for (var j:int = 0; j < 10; j++) 
					{
						var	box:Tile = new Tile();
						
						box.x = 50 + j * (imgSize + 1);
						box.y = 95 + i * (imgSize + 1);
						addChild(box);
						xRad.push(box);
					}
					yRad.push(xRad);
			}
			
			for (var k:int = 0; k < 2; k++) 
			{	
				boatEquiper();	// Starts the boat equiper to add a new boat
			}
			t.width = 100;
			
			stage.addEventListener(MouseEvent.CLICK, clickToPick)
			stage.addEventListener(KeyboardEvent.KEY_UP, spaceReset)
			stage.addEventListener(Event.ENTER_FRAME, enterFrameForScore)
			
		}
		
		private function enterFrameForScore(e:Event):void 	// Uppdates the score of hits and misses
		{
			t.text = "Misses: " + String(miss) + " Hits: " + String(hit);
			addChild(t);
		}
		
		private function clickToPick(e:MouseEvent):void 	// tells the tile class to change their img when clicked
		{
			if (e.target != stage) 
			{
				var answer:int = Tile(e.target).clicked();
				if (answer == Tile.MISS)
					miss++;
				if (answer == Tile.HIT) 
					hit++
			}
		}
		
		private function spaceReset(e:KeyboardEvent):void // tells the tile class to reset all from start
		{	
			if (e.keyCode == 32) 
			{
				for (var i:int = 0; i < 10; i++) 
				{
					for (var j:int = 0; j < 10; j++) 
					{
						Tile(yRad[i][j]).resetTile();
					}
				}
			}
			miss = 0;
			hit = 0;
			
			for (var k:int = 0; k < 2; k++) 
			{
				boatEquiper();	// starts boat equiper
			}
			
		}
		
		private function boatEquiper():void // tells boatcordinates to generate a boatcordinate then tells tile class to make it to a boat
		{
			if (Math.random() < 0.5) 	// tells if it's a vertical boat or not
				vertical = true;
			else
				vertical = false;
				
			boatCordinates = new BoatCordinates(vertical).getBoatCoordinates();	// gets the cordinates for the first boat part
			
			theBoatCordinatesY = int(boatCordinates.y);
			theBoatCordinatesX = int(boatCordinates.x);
			
			if (Tile(yRad[theBoatCordinatesY][theBoatCordinatesX]).getIfPlacementIsAble())
			{
				
				while ((theBoatCordinatesX - int(boatCordinates.x) < 3 && theBoatCordinatesY - int(boatCordinates.y) == 0) || ( theBoatCordinatesX - int(boatCordinates.x) == 0 && theBoatCordinatesY - int(boatCordinates.y) < 3))	// makes alla parts of the boat
				{
					if (theBoatCordinatesY < 9) 
						Tile(yRad[theBoatCordinatesY + 1][theBoatCordinatesX]).boatPlacementDistance();	// Makes the tiles around so you can't start a boat there 
					if (theBoatCordinatesY > 0) 
						Tile(yRad[theBoatCordinatesY - 1][theBoatCordinatesX]).boatPlacementDistance();
						
					if (theBoatCordinatesX < 9) 
						Tile(yRad[theBoatCordinatesY][theBoatCordinatesX + 1]).boatPlacementDistance();
						
					if (theBoatCordinatesX > 0) 
						Tile(yRad[theBoatCordinatesY][theBoatCordinatesX - 1]).boatPlacementDistance();
					
					
					Tile(yRad[theBoatCordinatesY][theBoatCordinatesX]).giveBoat(); // Makes it a boat
					
					if (vertical)	// Makes the direction of the boat
					{
						theBoatCordinatesX++
					}
					else 
					{ 
						theBoatCordinatesY++
					}
					
				}
				
				theBoatCordinatesY = 0
				theBoatCordinatesX = 0	// resets it for the next use of boatEquipper
			}
			else 
			{
				boatEquiper();
			}
		}
		
	}
	
}