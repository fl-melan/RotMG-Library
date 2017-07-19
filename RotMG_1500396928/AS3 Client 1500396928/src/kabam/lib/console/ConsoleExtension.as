package kabam.lib.console
{
   import flash.display.DisplayObjectContainer;
   import kabam.lib.resizing.ResizeExtension;
   import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
   import robotlegs.bender.framework.api.IContext;
   import robotlegs.bender.framework.api.IExtension;
   
   public class ConsoleExtension implements IExtension
   {
       
      
      [Inject]
      public var contextView:DisplayObjectContainer;
      
      public function ConsoleExtension()
      {
         super();
      }
      
      public function extend(param1:IContext) : void
      {
         param1.extend(SignalCommandMapExtension).extend(ResizeExtension).configure(ConsoleConfig);
      }
   }
}
