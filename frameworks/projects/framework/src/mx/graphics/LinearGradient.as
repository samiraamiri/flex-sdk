////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2004-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package mx.graphics
{

import flash.display.GradientType;
import flash.display.Graphics;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 *  The LinearGradient class lets you specify the fill of a graphical element,
 *  where a gradient specifies a gradual color transition  in the fill color.
 *  You add a series of GradientEntry objects
 *  to the LinearGradient object's <code>entries</code> Array
 *  to define the colors that make up the gradient fill.
 *  
 *  <p>In MXML, you define a LinearGradient by adding a series
 *  of GradientEntry objects, as the following example shows:
 *  <pre>
 *  &lt;mx:fill&gt;
 *  	&lt;mx:LinearGradient&gt;
 *  		&lt;mx:entries&gt;
 *  			&lt;mx:GradientEntry color="0xC5C551" ratio="0.00" alpha="0.5"/&gt;
 *  			&lt;mx:GradientEntry color="0xFEFE24" ratio="0.33" alpha="0.5"/&gt;
 *  			&lt;mx:GradientEntry color="0xECEC21" ratio="0.66" alpha="0.5"/&gt;
 *  		&lt;/mx:entries&gt;
 *  	&lt;/mx:LinearGradient&gt;
 *  &lt;/mx:fill&gt;
 *  </pre>
 *  </p>
 *  
 *  <p>You can also define a LinearGradient as a fill for any graphic element
 *  in ActionScript, as the following example shows:
 *  <pre>
 *  
 *  &lt;?xml version="1.0"?&gt;
 *  &lt;mx:Application xmlns:mx="http://www.adobe.com/2006/mxml" creationComplete="init()"&gt;
 *  	&lt;mx:Script&gt;
 *  	import flash.display.Graphics;
 *  	import flash.geom.Rectangle;
 *  	import mx.graphics.GradientEntry;
 *  	import mx.graphics.LinearGradient;
 *  
 *  	private function init():void
 *      {
 *  		var w:Number = 200;
 *  		var h:Number = 200;
 *  
 *  		var s:Sprite = new Sprite();
 *  		// Add the new Sprite to the display list.
 *  		rawChildren.addChild(s);	
 *  
 *  		var g:Graphics = s.graphics;
 *  		g.lineStyle(1, 0x33CCFF, 1.0);
 *  
 *  		var fill:LinearGradient = new LinearGradient();
 *  		
 *  		var g1:GradientEntry = new GradientEntry(0xFFCC66, 0.00, 0.5);
 *  		var g2:GradientEntry = new GradientEntry(0x000000, 0.33, 0.5);
 *  		var g3:GradientEntry = new GradientEntry(0x99FF33, 0.66, 0.5);
 *    		
 *   		fill.entries = [ g1, g2, g3 ];
 *  		fill.angle = 240;
 *  
 *   		// Draw a box and fill it with the LinearGradient.
 *  		g.moveTo(0, 0);
 *  		fill.begin(g, new Rectangle(0, 0, w, h));
 *  		g.lineTo(w, 0);
 *  		g.lineTo(w, h);
 *  		g.lineTo(0, h);
 *  		g.lineTo(0, 0);		
 *  		fill.end(g);
 *  	}
 *  	&lt;/mx:Script&gt;
 *  &lt;/mx:Application&gt;
 *  </pre>  
 *  </p>  
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:LinearGradient&gt;</code> tag
 *  inherits all the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:LinearGradient
 *    <b>Properties</b>
 *    angle="0"
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.graphics.GradientEntry
 *  @see mx.graphics.RadialGradient 
 *  @see mx.graphics.IFill
 */
public class LinearGradient extends GradientBase implements IFill
{
	include "../core/Version.as";

	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

 	/**
	 *  Constructor.
	 */
	public function LinearGradient()
 	{
		super();
		matrix = new Matrix();
	}

	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------

	/**
	 *  @inheritDoc
	 */
	public function begin(target:Graphics, rc:Rectangle):void
	{
		var w:Number = !isNaN(scaleX) ? scaleX : rc.width;
		var tx:Number = !isNaN(x) ? x : 0;
		var ty:Number = !isNaN(y) ? y : 0;
					
		matrix.createGradientBox(w, rc.height, 
								!isNaN(mx_internal::_angle) ? 
									mx_internal::_angle : mx_internal::rotationInRadians,
								 tx, ty);

		target.beginGradientFill(GradientType.LINEAR, mx_internal::colors,
								 mx_internal::alphas, mx_internal::ratios,
								 matrix, spreadMethod, interpolationMethod);		
	}

	/**
	 *  @inheritDoc
	 */
	public function end(target:Graphics):void
	{
		target.endFill();
	}
}

}
