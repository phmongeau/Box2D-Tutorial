package
{
	import org.flixel.*;

	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;

	public class B2Rotation extends FlxSprite
	{
		public var _def:b2PolygonDef;
		public var _bodyDef:b2BodyDef
		public var _obj:b2Body;
		private var ratio:Number = 30;
		private var _width:Number;
		private var _height:Number;
		
		public function B2Rotation(X:Number, Y:Number, Width:Number, Height:Number, w:b2World):void
		{
			super(X,Y);
			
			_width = Width;
			_height = Height;
			
			_def = new b2PolygonDef();
			_def.SetAsBox((Width/2) / ratio, (Height/2) /ratio);
			_def.friction = 0.8;
			_def.restitution = 0.3;
			_def.density = 0.0;
			
			_bodyDef = new b2BodyDef();
			_bodyDef.position.Set((X + (Width/2)) / ratio, (Y + (Height/2)) / ratio);
			_bodyDef.angle = 30 * (Math.PI / 180);
			
			_obj = w.CreateBody(_bodyDef);
			_obj.CreateShape(_def);
			//_obj.SetAngularVelocity(5 * (Math.PI/180));
			_obj.SetMassFromShapes();
		}
		
		override public function update():void
		{
			x = (_obj.GetPosition().x * ratio) - width/2 ;
			y = (_obj.GetPosition().y * ratio) - height/2;
			angle = _obj.GetAngle() * (180 / Math.PI);
			super.update();
			FlxG.log("flx: " + x.toString() + " - B: " + (_obj.GetPosition().x * ratio).toString());
		}
	}
}
