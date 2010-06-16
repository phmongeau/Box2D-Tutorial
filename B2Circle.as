package
{
	import org.flixel.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;

	public class B2Circle extends FlxSprite
	{
		private var ratio:Number = 30;

		public var _fixDef:b2FixtureDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;

		private var _radius:Number;
		private var _world:b2World;
		
		//Physics params default value
		public var _friction:Number = 0.8;
		public var _restitution:Number = 0.3;
		public var _density:Number = 0.7;
		
		//Default angle
		public var _angle:Number = 0;
		//Default body type
		public var _type:uint = b2Body.b2_dynamicBody;
		
		
		public function B2Circle(X:Number, Y:Number, Radius:Number, w:b2World):void
		{
			super(X,Y);
			
			_radius = Radius;
			_world = w;
		}
		
		override public function update():void
		{
			x = (_obj.GetPosition().x * ratio) - _radius ;
			y = (_obj.GetPosition().y * ratio) - _radius;
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
		}
		
		public function createBody():void
		{
			_fixDef = new b2FixtureDef();
			_fixDef.friction = _friction;
			_fixDef.restitution = _restitution;
			_fixDef.density = _density;
			_fixDef.shape = new b2CircleShape(_radius/ratio);
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((x + (_radius)) / ratio, (y + (_radius/2)) / ratio);
			_bodyDef.angle = _angle * (Math.PI / 180);
			_bodyDef.type = _type;
			
			_obj = _world.CreateBody(_bodyDef);
			_obj.CreateFixture(_fixDef);
		}
	}
}
