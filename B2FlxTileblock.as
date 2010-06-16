package
{
	import org.flixel.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;

	public class B2FlxTileblock extends FlxTileblock
	{
		public var _def:b2PolygonDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;
		private var ratio:Number = 30;
		
		public function B2FlxTileblock(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
		{
			super(X,Y, Width, Height);
			
			_def = new b2PolygonDef();
			_def.SetAsBox((Width/2) / ratio, (Height/2) / ratio);
			_def.friction = 0.5;
			_def.restitution = 0.3;
			_def.density = 0.0;
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((X + (Width/2)) / ratio, (Y + (Height/2)) / ratio);
			
			_obj = w.CreateBody(_bodyDef);
			_obj.CreateShape(_def);
			_obj.SetMassFromShapes();
		}
		
		override public function update():void
		{
			x = (_obj.GetPosition().x * ratio) - width/2 ;
			y = (_obj.GetPosition().y * ratio) - height/2;
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
		}
	}
}
