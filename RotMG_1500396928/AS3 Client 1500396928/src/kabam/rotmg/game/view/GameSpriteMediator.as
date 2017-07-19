package kabam.rotmg.game.view
{
   import com.company.assembleegameclient.game.GameSprite;
   import com.company.assembleegameclient.game.events.ReconnectEvent;
   import com.company.assembleegameclient.objects.Player;
   import flash.utils.getTimer;
   import kabam.rotmg.core.StaticInjectorContext;
   import kabam.rotmg.core.model.MapModel;
   import kabam.rotmg.core.model.PlayerModel;
   import kabam.rotmg.core.signals.InvalidateDataSignal;
   import kabam.rotmg.core.signals.SetScreenSignal;
   import kabam.rotmg.core.signals.SetScreenWithValidDataSignal;
   import kabam.rotmg.core.signals.TrackPageViewSignal;
   import kabam.rotmg.dailyLogin.signal.ShowDailyCalendarPopupSignal;
   import kabam.rotmg.dialogs.control.AddPopupToStartupQueueSignal;
   import kabam.rotmg.dialogs.control.CloseDialogsSignal;
   import kabam.rotmg.dialogs.control.FlushPopupStartupQueueSignal;
   import kabam.rotmg.dialogs.control.OpenDialogSignal;
   import kabam.rotmg.dialogs.model.DialogsModel;
   import kabam.rotmg.game.logging.LoopMonitor;
   import kabam.rotmg.game.model.GameInitData;
   import kabam.rotmg.game.signals.GameClosedSignal;
   import kabam.rotmg.game.signals.PlayGameSignal;
   import kabam.rotmg.game.signals.SetWorldInteractionSignal;
   import kabam.rotmg.maploading.signals.HideMapLoadingSignal;
   import kabam.rotmg.maploading.signals.ShowLoadingViewSignal;
   import kabam.rotmg.news.controller.NewsButtonRefreshSignal;
   import kabam.rotmg.packages.control.BeginnersPackageAvailableSignal;
   import kabam.rotmg.packages.control.InitPackagesSignal;
   import kabam.rotmg.packages.control.OpenPackageSignal;
   import kabam.rotmg.packages.control.PackageAvailableSignal;
   import kabam.rotmg.packages.model.PackageInfo;
   import kabam.rotmg.packages.services.PackageModel;
   import kabam.rotmg.pets.controller.ShowPetTooltip;
   import kabam.rotmg.promotions.model.BeginnersPackageModel;
   import kabam.rotmg.promotions.signals.ShowBeginnersPackageSignal;
   import kabam.rotmg.ui.signals.HUDModelInitialized;
   import kabam.rotmg.ui.signals.HUDSetupStarted;
   import kabam.rotmg.ui.signals.UpdateHUDSignal;
   import robotlegs.bender.bundles.mvcs.Mediator;
   
   public class GameSpriteMediator extends Mediator
   {
       
      
      [Inject]
      public var view:GameSprite;
      
      [Inject]
      public var setWorldInteraction:SetWorldInteractionSignal;
      
      [Inject]
      public var invalidate:InvalidateDataSignal;
      
      [Inject]
      public var setScreenWithValidData:SetScreenWithValidDataSignal;
      
      [Inject]
      public var setScreen:SetScreenSignal;
      
      [Inject]
      public var playGame:PlayGameSignal;
      
      [Inject]
      public var playerModel:PlayerModel;
      
      [Inject]
      public var gameClosed:GameClosedSignal;
      
      [Inject]
      public var mapModel:MapModel;
      
      [Inject]
      public var beginnersPackageModel:BeginnersPackageModel;
      
      [Inject]
      public var closeDialogs:CloseDialogsSignal;
      
      [Inject]
      public var monitor:LoopMonitor;
      
      [Inject]
      public var hudSetupStarted:HUDSetupStarted;
      
      [Inject]
      public var updateHUDSignal:UpdateHUDSignal;
      
      [Inject]
      public var hudModelInitialized:HUDModelInitialized;
      
      [Inject]
      public var tracking:TrackPageViewSignal;
      
      [Inject]
      public var beginnersPackageAvailable:BeginnersPackageAvailableSignal;
      
      [Inject]
      public var packageAvailable:PackageAvailableSignal;
      
      [Inject]
      public var initPackages:InitPackagesSignal;
      
      [Inject]
      public var showBeginnersPackage:ShowBeginnersPackageSignal;
      
      [Inject]
      public var packageModel:PackageModel;
      
      [Inject]
      public var openPackageSignal:OpenPackageSignal;
      
      [Inject]
      public var showPetTooltip:ShowPetTooltip;
      
      [Inject]
      public var showLoadingViewSignal:ShowLoadingViewSignal;
      
      [Inject]
      public var newsButtonRefreshSignal:NewsButtonRefreshSignal;
      
      [Inject]
      public var openDialog:OpenDialogSignal;
      
      [Inject]
      public var dialogsModel:DialogsModel;
      
      [Inject]
      public var showDailyCalendarSignal:ShowDailyCalendarPopupSignal;
      
      [Inject]
      public var addToQueueSignal:AddPopupToStartupQueueSignal;
      
      [Inject]
      public var flushQueueSignal:FlushPopupStartupQueueSignal;
      
      public function GameSpriteMediator()
      {
         super();
      }
      
      public static function sleepForMs(param1:int) : void
      {
         var _loc2_:int = getTimer();
         while(getTimer() - _loc2_ < param1)
         {
         }
      }
      
      override public function initialize() : void
      {
         this.showLoadingViewSignal.dispatch();
         this.view.packageModel = this.packageModel;
         this.setWorldInteraction.add(this.onSetWorldInteraction);
         addViewListener(ReconnectEvent.RECONNECT,this.onReconnect);
         this.view.modelInitialized.add(this.onGameSpriteModelInitialized);
         this.view.drawCharacterWindow.add(this.onStatusPanelDraw);
         this.hudModelInitialized.add(this.onHUDModelInitialized);
         this.showPetTooltip.add(this.onShowPetTooltip);
         this.view.monitor.add(this.onMonitor);
         this.view.closed.add(this.onClosed);
         this.view.mapModel = this.mapModel;
         this.view.dialogsModel = this.dialogsModel;
         this.view.beginnersPackageModel = this.beginnersPackageModel;
         this.view.openDialog = this.openDialog;
         this.view.addToQueueSignal = this.addToQueueSignal;
         this.view.flushQueueSignal = this.flushQueueSignal;
         this.view.connect();
         this.tracking.dispatch("/gameStarted");
         this.view.showBeginnersPackage = this.showBeginnersPackage;
         this.view.openDailyCalendarPopupSignal = this.showDailyCalendarSignal;
         this.view.showPackage.add(this.onShowPackage);
         this.newsButtonRefreshSignal.add(this.onNewsButtonRefreshSignal);
      }
      
      private function onShowPackage() : void
      {
         var _loc1_:PackageInfo = this.packageModel.getPriorityPackage();
         if(_loc1_)
         {
            this.openPackageSignal.dispatch(_loc1_.packageID);
         }
         else
         {
            this.flushQueueSignal.dispatch();
         }
      }
      
      override public function destroy() : void
      {
         this.view.showPackage.remove(this.onShowPackage);
         this.setWorldInteraction.remove(this.onSetWorldInteraction);
         removeViewListener(ReconnectEvent.RECONNECT,this.onReconnect);
         this.view.modelInitialized.remove(this.onGameSpriteModelInitialized);
         this.view.drawCharacterWindow.remove(this.onStatusPanelDraw);
         this.hudModelInitialized.remove(this.onHUDModelInitialized);
         this.beginnersPackageAvailable.remove(this.onBeginner);
         this.packageAvailable.remove(this.onPackage);
         this.view.closed.remove(this.onClosed);
         this.view.monitor.remove(this.onMonitor);
         this.newsButtonRefreshSignal.remove(this.onNewsButtonRefreshSignal);
         this.view.disconnect();
      }
      
      private function onMonitor(param1:String, param2:int) : void
      {
         this.monitor.recordTime(param1,param2);
      }
      
      public function onSetWorldInteraction(param1:Boolean) : void
      {
         this.view.mui_.setEnablePlayerInput(param1);
      }
      
      private function onBeginner() : void
      {
         this.view.showBeginnersButtonIfSafe();
      }
      
      private function onPackage() : void
      {
         this.view.showPackageButtonIfSafe();
      }
      
      private function onClosed() : void
      {
         if(!this.view.isEditor)
         {
            this.gameClosed.dispatch();
         }
         this.closeDialogs.dispatch();
         var _loc1_:HideMapLoadingSignal = StaticInjectorContext.getInjector().getInstance(HideMapLoadingSignal);
         _loc1_.dispatch();
         sleepForMs(100);
      }
      
      private function onReconnect(param1:ReconnectEvent) : void
      {
         if(this.view.isEditor)
         {
            return;
         }
         var _loc2_:GameInitData = new GameInitData();
         _loc2_.server = param1.server_;
         _loc2_.gameId = param1.gameId_;
         _loc2_.createCharacter = param1.createCharacter_;
         _loc2_.charId = param1.charId_;
         _loc2_.keyTime = param1.keyTime_;
         _loc2_.key = param1.key_;
         _loc2_.isFromArena = param1.isFromArena_;
         this.playGame.dispatch(_loc2_);
      }
      
      private function onGameSpriteModelInitialized() : void
      {
         this.hudSetupStarted.dispatch(this.view);
         this.beginnersPackageAvailable.add(this.onBeginner);
         this.packageAvailable.add(this.onPackage);
         this.initPackages.dispatch();
      }
      
      private function onStatusPanelDraw(param1:Player) : void
      {
         this.updateHUDSignal.dispatch(param1);
      }
      
      private function onHUDModelInitialized() : void
      {
         this.view.hudModelInitialized();
      }
      
      private function onShowPetTooltip(param1:Boolean) : void
      {
         this.view.showPetToolTip(param1);
      }
      
      private function onNewsButtonRefreshSignal() : void
      {
         this.view.refreshNewsUpdateButton();
      }
   }
}