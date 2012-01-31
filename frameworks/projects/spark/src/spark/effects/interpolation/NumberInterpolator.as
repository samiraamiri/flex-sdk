////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2008 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package mx.effects.interpolation
{
	
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;    

//--------------------------------------
//  Other metadata
//--------------------------------------

[ResourceBundle("sparkEffects")]
	
/**
 * The NumberInterpolator class provides interpolation between
 * <code>Number</code> start and end values. 
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */
public class NumberInterpolator implements IInterpolator
{
    private static var theInstance:NumberInterpolator;
    
    public function NumberInterpolator()
    {
        super();
    }
    
    /**
     *  @private
     *  Used for accessing localized Error messages.
     */
    private var resourceManager:IResourceManager =
                                    ResourceManager.getInstance();
    
    /**
     * Returns the singleton of this class. Since all NumberInterpolators
     * have the same behavior, there is no need for more than one instance.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public static function getInstance():NumberInterpolator
    {
        if (!theInstance)
            theInstance = new NumberInterpolator();
        return theInstance;
    }
    
    /**
     * Returns the <code>Number</code> type, which is the type of
     * object interpolated by NumberInterpolator
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function get interpolatedType():Class
    {
        return Number;
    }

    /**
     * @inheritDoc
     * 
     * <p>Interpolation for NumberInterpolator consists of a simple
     * parametric calculation between <code>startValue</code> and 
     * <code>endValue</code>, using <code>fraction</code> as the 
     * fraction elapsed from start to end, like this:</p>
     * 
     * <p><code>return startValue + fraction * (endValue - startValue);</code></p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function interpolate(fraction:Number, startValue:Object, 
        endValue:Object):Object
    {
        if ((startValue is Number && isNaN(Number(startValue))) || 
            (endValue is Number && isNaN(Number(endValue))))
            throw new Error(resourceManager.getString("sparkEffects", "cannotCalculateValue", [startValue, endValue]));
        // Quick test for 0 or 1 to avoid round-off error on either end
        if (fraction == 0)
            return startValue;
        else if (fraction == 1)
            return endValue;
        return Number(startValue) + (fraction * (Number(endValue) - Number(startValue)));
    }
    
    /**
     * @inheritDoc
     * 
     * <p><code>return baseValue + incrementValue;</code></p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function increment(baseValue:Object, incrementValue:Object):Object
    {
        return Number(baseValue) + Number(incrementValue);
    }

    /**
     * @inheritDoc
     * 
     * <p><code>return baseValue - decrementValue;</code></p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
   public function decrement(baseValue:Object, decrementValue:Object):Object
   {
        return Number(baseValue) - Number(decrementValue);
   }
}
}