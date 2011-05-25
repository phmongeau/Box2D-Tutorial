package
{
	import org.flixel.*;
	
	import flash.display.Sprite;
	import flash.events.Event;

	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Common.b2Settings;


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
		private var ball:B2Circle;
		
		override public function create():void
		{
			//Set up the world
			setupWorld();
			
			//Add a crate			
			cube = new B2FlxSprite(420, 150, 20, 20, _world);
			cube.angle = 30;
			cube.createBody();
			cube.loadGraphic(ImgCube, false, false, 20, 20);
			
			//Add a ball
			ball = new B2Circle(450, 150, 10, _world);
			ball._density = 0.9;
			ball.createBody();
			ball.loadGraphic(ImgBall, false, false, 20, 20);
			
			//Add rotating sprite
			_rot = new B2FlxSprite(320, 280, 150, 20, _world);
			_rot._density = 0.0;
			_rot._angle = 30;
			_rot._type = b2Body.b2_kinematicBody;
			_rot.createBody();
			_rot.loadGraphic(ImgRect, false, false, 150, 20);

			var revJointDef:b2RevoluteJointDef = new b2RevoluteJointDef();
			//revJointDef.Initialize(ball._obj, cube._obj, ball._obj.GetWorldCenter());
			revJointDef.Initialize(cube._obj, ball._obj, cube._obj.GetWorldCenter());
			revJointDef.maxMotorTorque = 1.0;
			revJointDef.enableMotor = true;
			_world.CreateJoint(revJointDef);

			//var distJointDef:b2DistanceJointDef = new b2DistanceJointDef();
			//distJointDef.Initialize(ball._obj, cube._obj, ball._obj.GetWorldCenter(), cube._obj.GetWorldCenter());
			//_world.CreateJoint(distJointDef);
			
			//Floor:
			var floor:B2FlxTileblock = new B2FlxTileblock(0, 400, 640, 80, _world)
			floor.createBody();
			floor.loadTiles(ImgCube);
			
			this.add(cube);
			this.add(ball);
			this.add(_rot);
			this.add(floor);
			
			//debugDraw();
			
		}
		
		override public function update():void
		{
			_world.Step(FlxG.elapsed, 10, 10);
			super.update();
			
			if(FlxG.keys.pressed("RIGHT"))
			{
				var angularVelocity:Number = _rot._obj.GetAngularVelocity();
				_rot._obj.SetAngularVelocity(angularVelocity + 5 * (Math.PI/180));
			}
			else if(FlxG.keys.pressed("LEFT"))
			{
				angularVelocity = _rot._obj.GetAngularVelocity();
				_rot._obj.SetAngularVelocity(angularVelocity - 5 * (Math.PI/180));
			}
			else
			{
				angularVelocity = _rot._obj.GetAngularVelocity();
				_rot._obj.SetAngularVelocity(angularVelocity * 0.95);
			}
			if(FlxG.keys.pressed("SPACE"))
			{
				ball._obj.SetPosition(new b2Vec2(350/RATIO, 240/RATIO))
			}
		}
		
		/*private function debugDraw():void
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
		}*/
		
		
		private function setupWorld():void
		{			
			//gravity
			var gravity:b2Vec2 = new b2Vec2(0, 9.8);
			
			//Ignore sleeping objects
			var ignoreSleeping:Boolean = true;
			
			_world = new b2World(gravity, ignoreSleeping);
			
		}		
	}
}

