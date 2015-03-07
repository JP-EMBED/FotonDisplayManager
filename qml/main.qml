import QtQuick 2.4
import QtQuick.Controls 1.2
import "LedBoardView"
import "ConnectionMenu"
import "CameraView"
import "TitleView"
ApplicationWindow
{
    title: "Foton Display Manager"
    visible: true
    id: mainWindow
    width: ScreenWidth
    height: ScreenHeight
    function showConnectionView(){
        titleScreen.visible = false;
        connectView.visible = true;
    }
    function showBoardView(){
        titleScreen.visible = false;
        boardView.visible = true;
    }



    LedBoardView{
        id:boardView

        visible: false
    }

    FindDeviceMenu{
        id:connectView
        anchors.fill: parent
        visible:false
    }
    CameraView{
        id:camView
        width:  parent.width
        height: parent.height
        color: "black"
        x:0
        y:-(height)
        visible:false
    }
    TitleView{
        id:titleScreen
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        visible:true

    }
}
