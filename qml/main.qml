import QtQuick 2.4
import QtQuick.Controls 1.2
import "LedBoardView"
import "ConnectionMenu"

ApplicationWindow
{
    title: "F0T0N2"
    visible: true
    id: mainWindow
    width: ScreenWidth
    height: ScreenHeight
    LedBoardView{
        id:boardView
    }

    FindDeviceMenu{
        anchors.fill: parent
    }
}
