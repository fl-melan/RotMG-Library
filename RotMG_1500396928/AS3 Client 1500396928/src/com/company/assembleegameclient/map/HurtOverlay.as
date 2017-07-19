package com.company.assembleegameclient.map
{
   import com.company.util.GraphicsUtil;
   import flash.display.GradientType;
   import flash.display.GraphicsGradientFill;
   import flash.display.GraphicsPath;
   import flash.display.IGraphicsData;
   import flash.display.Shape;
   
   public class HurtOverlay extends Shape
   {
       
      
      private var s:Number;
      
      private var gradientFill_:GraphicsGradientFill;
      
      private const gradientPath_:GraphicsPath = GraphicsUtil.getRectPath(0,0,600,600);
      
      private var gradientGraphicsData_:Vector.<IGraphicsData>;
      
      public function HurtOverlay()
      {
         super();
         this.s = 600 / Math.sin(Math.PI / 4);
         this.gradientFill_ = new GraphicsGradientFill(GradientType.RADIAL,[16777215,16777215,16777215],[0,0,0.92],[0,155,255],GraphicsUtil.getGradientMatrix(this.s,this.s,0,(600 - this.s) / 2,(600 - this.s) / 2));
         this.gradientGraphicsData_ = new <IGraphicsData>[this.gradientFill_,this.gradientPath_,GraphicsUtil.END_FILL];
         graphics.drawGraphicsData(this.gradientGraphicsData_);
         visible = false;
      }
   }
}
