import QtQuick 2.4
import "../ColorPicker"
import "../FExplorer"


Rectangle
{
    id: mainWindow
    width: parent.width
    height: parent.height
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
    ColorPalette{id:topBar;}
    ToolBar{id:toolBar}
    AnimationBar{id:animationBar}


    ColorPicker{id:colorPicker; width:parent.width*4/8; height: parent.height*4/8; y:topBar.height+4; x:parent.width*-1; visible: false}
    FExplorer{id:fExplorer; x: parent.width*-1}

    function displayGrid()
    {
        for(var i = 0; i < 1024;i++)
        {
            var row = i/32;
            var col = Math.floor(i%32);
            var color = LedGrid.getLedColor(i);
            square.grid.itemAt(i).color = color;
            LedBoardManager.sendLedColor(color);
            LedBoardManager.sendLedSet(col, row);
        }
        LedBoardManager.sendLedColor(LedGrid.getColor());
    }

    function flipPage(dir)
    {
        if (LedGrid.getPages() > 1)
        {
            LedGrid.flipPage(dir)
            animationBar.inputBox.text = LedGrid.getDuration()/1000
            displayGrid();
        }
        changeMade()
    }

    function changeMade()
    {
        LedGrid.copyPage(1);
        animationBar.undoButton.redo = 0;
    }
}
