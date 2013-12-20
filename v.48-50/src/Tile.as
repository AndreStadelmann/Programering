package  
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author EpicToaster
	 */
	public class Tile extends Sprite
	{
		[Embed(source="../lib/tile.png")]	// picture! :D
		private var TileImage:Class;
		
		[Embed(source = "../lib/tileMiss.png")]	// another picture! :D
		private var TileImageMiss:Class;
		
		[Embed(source = "../lib/tileHit.png")]	// This is the happiest day of my life 3 pictures in a row!!! :DDDD
		private var TileImageHit:Class;
		
		private var hasBoat:Boolean = false;
		private var isClicked:Boolean = false;
		private var canAddBoat:Boolean = true;
		
		public static const MISS:int = 1;
		public static const HIT:int = 2;
		
		private var imgSize:int = 32;
		
		public function Tile() // Creates all the tiles
		{
			this.graphics.beginBitmapFill(Bitmap(new TileImage()).bitmapData);
			this.graphics.drawRect(0, 0, imgSize, imgSize);
			this.graphics.endFill();
		}
		
		public function clicked():int	// when clicked, if it's a boat make the tile into a hit and return HIT, if not a boat make into a miss and return MISS
		{
			if (!this.isClicked)
			{
				if (hasBoat) 
				{
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new TileImageHit()).bitmapData);
					this.graphics.drawRect(0, 0, imgSize, imgSize);
					this.graphics.endFill();
					this.isClicked = true;
					return HIT
				}
				else 
				{
					this.graphics.clear();
					this.graphics.beginBitmapFill(Bitmap(new TileImageMiss()).bitmapData);
					this.graphics.drawRect(0, 0, imgSize, imgSize);
					this.graphics.endFill();
					this.isClicked = true;
					return MISS
				}
				
			}
			else 
			{
				return 0	// Just to get it work
			}
		}
		
		public function resetTile():void // Clears the graphics and put on new so it's like it was from the begining
		{
			this.graphics.clear();
			this.graphics.beginBitmapFill(Bitmap(new TileImage()).bitmapData);
			this.graphics.drawRect(0, 0, imgSize, imgSize);
			this.graphics.endFill();
			this.hasBoat = false;
			this.isClicked = false;
			this.canAddBoat = true;
		}
		
		public function giveBoat():void // Gives the tile a boat, tiles loves boats! :D
		{
			this.hasBoat = true;
			this.canAddBoat = false;
		}
		
		public function boatPlacementDistance():void	// Makes this tile so no boat can start here
		{
			canAddBoat = false;
		}
		
		public function getIfPlacementIsAble():Boolean	// Returns if you can add a boat here or not
		{
			return this.canAddBoat	
		}
	}

}