package
{
	import org.flixel.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;

	public class B2FlxSprite extends FlxSprite
	{
		private var ratio:Number = 30;

		public var _def:b2PolygonDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;
				
		private var _width:Number;
		private var _height:Number;
		private var _world:b2World;
		
		//Physics params default value
		public var _friction:Number = 0.8;
		public var _restitution:Number = 0.3;
		public var _density:Number = 0.7;
		
		//Default angle
		public var _angle:Number = 0;
		
		
		public function B2FlxSprite(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
		{
			super(X,Y);
			
			_width = Width;
			_height = Height;
			_world = w
		}
		
		override public function update():void
		{
			x = (_obj.GetPosition().x * ratio) - width/2 ;
			y = (_obj.GetPosition().y * ratio) - height/2;
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
		}
		
		public function createBody():void
		{
			_def = new b2PolygonDef();
			_def.SetAsBox((_width/2) / ratio, (_height/2) /ratio);
			_def.friction = _friction;
			_def.restitution = _restitution;
			_def.density = _density;
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((x + (_width/2)) / ratio, (y + (_height/2)) / ratio);
			_bodyDef.angle = _angle * (Math.PI / 180);
			
			_obj = _world.CreateBody(_bodyDef);
			_obj.CreateShape(_def);
			_obj.SetMassFromShapes();

		}
	}
}
