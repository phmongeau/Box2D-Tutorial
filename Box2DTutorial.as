package
{
	import org.flixel.*;
	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Box2DTutorial extends FlxGame
	{
		public function Box2DTutorial()
		{
			super(640,480,MenuState,1);
		}
	}
}
