import QtQuick 2.4
import "../ColorPicker"
import "../FExplorer"


Rectangle
{
    property alias inputBox: animationBar.inputBox
    property alias ledBoard: square.grid
    id: mainWindow
    width: parent.width
    height: parent.height
    visible: true
    color: "black"


    Timer
    {
        id: animationTimer
        interval: FotonGrid.getDuration()
        running: false
        onTriggered:
        {
            flipPage(1);
            animationTimer.interval = FotonGrid.getDuration();
            animationTimer.restart();
        }
    }

    LedGrid{id:square;}
    ColorPalette{id:topBar;}
    ToolBar{
        id:toolBar
        onSelectToolDisabled:{
            square.selectionBox.placed = 0
            square.selectionMode = false
            square.selectionBox.width = 0;
            square.selectionBox.height = 0;
        }
        onSelectToolEnabled:{
            square.selectionBox.placed = 0
            square.selectionMode = true
        }
        onToolSelected:{
            if(square.selectionMode && !square.selectionBox.placed)
            {
                selectTool.border.color = "black"
                selectTool.selected = false
                square.selectionMode = false
            }
            square.selectionBox.dragArea.enabled = (square.selectedTool == "Move")

        }
    }
    AnimationBar{id:animationBar}


    ColorPicker{id:colorPicker; width:parent.width* .5; height: parent.height* .5; y:topBar.height+4; x:parent.width*-1; visible: false}
    FExplorer{id:fExplorer; x: parent.width*-1}

    function displayGrid()
    {
        for(var i = 0; i < 1024;i++)
        {
            var row = i/32;
            var col = Math.floor(i%32);
            var color = FotonGrid.getLedColor(i);
            square.grid.itemAt(i).color = color;
            LedBoardManager.sendLedColor(color);
            LedBoardManager.sendLedSet(col, row);
        }
        LedBoardManager.sendLedColor(FotonGrid.getColor());
    }

    function flipPage(dir)
    {
        if (FotonGrid.getPages() > 1)
        {
            FotonGrid.flipPage(dir)
            animationBar.inputBox.text = FotonGrid.getDuration()/1000
            displayGrid();
        }
        changeMade()
    }

    function changeMade()
    {
        FotonGrid.copyPage(1);
        animationBar.undoButton.redo = 0;
    }
}
