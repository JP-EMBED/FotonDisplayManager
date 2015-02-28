import QtQuick 2.0
import QtQuick 2.0
import QtQuick 2.1
import QtQuick 2.3
import QtQuick.Window 2.2
import "../ColorPicker"
import "../FExplorer"


Rectangle
{
    id: mainWindow
    width: Screen.width
    height: Screen.height
    visible: true
    color: "black"

    Timer
    {
        id: animationTimer
        interval: LedGrid.getDuration()
        running: false
        onTriggered:
        {
            flipPage(1);
            animationTimer.interval = LedGrid.getDuration();
            animationTimer.restart();
        }
    }

    LedGrid{id:square}
    ColorPalette{id:topBar}
    ToolBar{id:toolBar}
    AnimationBar{id:animationBar}


    ColorPicker{id:colorPicker; width:Screen.width*5/8; height: Screen.height*5/8; y:topBar.height+4; x:Screen.width*-1}
    FExplorer{id:fExplorer; x: Screen.width*-1}

    function displayGrid()
    {
        for(var i = 0; i < 1024;i++)
            square.grid.itemAt(i).color = LedGrid.getLedColor(i);
    }

    function flipPage(dir)
    {
        if (LedGrid.getPages() > 1)
        {
            LedGrid.flipPage(dir)
            animationBar.inputBox.text = LedGrid.getDuration()/1000
            for(var i = 0; i < 1024;i++)
                square.grid.itemAt(i).color = LedGrid.getLedColor(i);
        }
        changeMade()
    }

    function changeMade()
    {
        LedGrid.copyPage(1);
        animationBar.undoButton.redo = 0;
    }
}
