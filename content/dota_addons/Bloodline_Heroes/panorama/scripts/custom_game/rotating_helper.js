'use strict';
var state = "disabled";

function StartRotatingHelper( params )
{
  if (params !== undefined)
  {
    state = params["state"];
  }
  if (state === 'active')
  {
    $.Schedule(0.001, StartRotatingHelper);
    var mPos = GameUI.GetCursorPosition();

    mPos[0] = (mPos[0] * 1.0 / $( "#BuildingHelperBase").desiredlayoutwidth ) * 1920;
    mPos[1] = (mPos[1] * 1.0 / $( "#BuildingHelperBase").desiredlayoutheight) * 1080;

    $( "#GreenSquare").style['height'] = String(50) + "px;";
    $( "#GreenSquare").style['width'] = String(50) + "px;";
    $( "#GreenSquare").style['margin'] = String(mPos[1] - (25)) + "px 0px 0px " + String(mPos[0] - (25)) + "px;";
    $( "#GreenSquare").style['transform'] = "rotateX( 30deg );"
  }
}

function EndBuildingHelper()
{
  state = 'disabled'
  $( "#GreenSquare").style['margin'] = "-1000px 0px 0px 0px;";
}

function SendRotateCommand( params )
{
  $.Schedule(0.03, SendRotateCommand);
  var mPos = GameUI.GetCursorPosition();
  var GamePos = Game.ScreenXYToWorld(mPos[0], mPos[1]);
  GameEvents.SendCustomGameEventToServer( "rotating_helper_rotate_command", { "X" : GamePos[0], "Y" : GamePos[1], "Z" : GamePos[2] } );
  pressedShift = GameUI.IsShiftDown();

  // Remove the green square once the player have clicked left-click
  // At that point we are continiously sending the mouse position
  if (state === "active")
  {  
    EndBuildingHelper();
  } 
}

function SendCancelCommand( params )
{
  EndBuildingHelper();
  GameEvents.SendCustomGameEventToServer( "building_helper_cancel_command", {} );
}

(function () {
  GameEvents.Subscribe( "rotating_helper_enable", StartRotatingHelper);
})();