package
{
	import org.flixel.*;
	
	import flash.display.Sprite;
	import flash.events.Event;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;


	public class PlayState extends FlxState
	{
		[Embed(source = 'data/box.png')] private var ImgCube:Class;
		[Embed(source = 'data/ball.png')] private var ImgBall:Class;
		[Embed(source = 'data/rect.png')] private var ImgRect:Class;
		
		private var _world:b2World;
		
		//ration of pixels to meters
		public static const RATIO:Number = 30;
		
		private var cube:B2FlxSprite;
		private var _rot:B2FlxSprite;
		
		override public function create():void
		{
			//Set up the world
			setupWorld();
			//Create Walls and floor
			createWallsAndFloor();
			
			//Add a crate			
			cube = new B2FlxSprite(320, 240, 20, 20, _world);
			cube.angle = 30;
			cube.createBody();
			cube.loadGraphic(ImgCube, false, false, 20, 20);
			
			//Add a ball
			var ball:B2Circle = new B2Circle(350, 240, 10, _world);
			ball.createBody();
			ball.loadGraphic(ImgBall, false, false, 20, 20);
			
			//Add rotating sprite
			_rot = new B2FlxSprite(320, 280, 150, 20, _world);
			_rot._density = 0.0;
			_rot._angle = 30;
			_rot._type = b2Body.b2_kinematicBody;
			_rot.createBody();
			_rot.loadGraphic(ImgRect, false, false, 150, 20);
			
			this.add(cube);
			this.add(ball);
			this.add(_rot);
			
			debugDraw();
			
		}
		
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);
			FlxG.log(cube.y.toString());
			super.update();			
		}
		
		private function debugDraw():void
		{
			var spriteToDrawOn:Sprite = new Sprite();
			addChild(spriteToDrawOn);
			
			var artistForHire:b2DebugDraw = new b2DebugDraw();
			artistForHire.SetSprite(spriteToDrawOn);
			artistForHire.SetXFormScale(30);
			artistForHire.SetFlags(b2DebugDraw.e_shapeBit);
			artistForHire.SetLineThickness(2.0);
			artistForHire.SetFillAlpha(0.6);
			
			_world.SetDebugDraw(artistForHire);
		}
		
		
		private function setupWorld():void
		{
			//size of the univers
			//var universeSize:b2AABB = new b2AABB();
			//universeSize.lowerBound.Set(-3000/RATIO, -3000/RATIO);
			//universeSize.upperBound.Set(3000/RATIO, 3000/RATIO);
			
			//gravity
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			
			//Ignore sleeping objects
			var ignoreSleeping:Boolean = true;
			
			_world = new b2World(gravity, ignoreSleeping);
			
		}
		
		private function createWallsAndFloor():void
		{			
			//Floor:
			var floor:B2FlxTileblock = new B2FlxTileblock(0, 400, 640, 80, _world)
			floor.createBody();
			floor.loadGraphic(ImgCube);
			add(floor);
		}		
	}
}
