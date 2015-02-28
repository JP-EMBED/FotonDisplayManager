import QtQuick 2.0
import QtQuick 2.1
import QtQuick 2.3
import QtQuick.Window 2.2



Rectangle
{
    id: root
    width: parent.width
    height: parent.height/11
    gradient: Gradient
    {
             GradientStop { position: 0.0; color: Qt.rgba(.5,.5,.5,1) }
             GradientStop { position: 1.0; color: Qt.rgba(.7,.7,.7,1) }
    }
    //Top Buttons
    Row
    {
        id:colorButtons
        spacing: 0

        Rectangle
        {
            id: colorButton0
            height: topBar.height
            width: topBar.width/6
            color: 'red'
            border.width: 10
            border.color: "#FFB01C"
            radius: width*.1
            property int colorUse0: 1;
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    if (colorButton0.colorUse0 == 0)
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = "#FFB01C"
                        colorButton1.border.color = 'black'
                        colorButton2.border.color = 'black'
                        colorButton3.border.color = 'black'
                        colorButton4.border.color = 'black'
                        colorButton5.border.color = 'black'
                        colorPicker.x = Screen.width*-1;
                        colorButton0.colorUse0 = 1;
                        colorButton1.colorUse1 = 0;
                        colorButton2.colorUse2 = 0;
                        colorButton3.colorUse3 = 0;
                        colorButton4.colorUse4 = 0;
                    }
                    else if (colorButton0.colorUse0 == 1)
                    {
                        colorPicker.x = 180;
                        colorButton0.colorUse0 = 2;
                    }
                    else
                    {
                        colorPicker.x = Screen.width*-1;
                        colorButton0.color = colorPicker.pickedColor;
                        colorButton0.colorUse0 = 1;
                        LedGrid.colorSelect(parent.color)
                    }
                }
            }
        }

        Rectangle
        {
            id: colorButton1
            height: topBar.height
            width: topBar.width/6
            color: 'blue'
            radius: width*.1
            border.width: 10
            border.color: 'black'
            property int colorUse1: 0;
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    if (colorButton1.colorUse1 == 0)
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = 'black'
                        colorButton1.border.color = "#FFB01C"
                        colorButton2.border.color = 'black'
                        colorButton3.border.color = 'black'
                        colorButton4.border.color = 'black'
                        colorButton5.border.color = 'black'
                        colorPicker.x = Screen.width*-1;
                        colorButton0.colorUse0 = 0;
                        colorButton1.colorUse1 = 1;
                        colorButton2.colorUse2 = 0;
                        colorButton3.colorUse3 = 0;
                        colorButton4.colorUse4 = 0;

                    }
                    else if (colorButton1.colorUse1 == 1)
                    {
                        colorPicker.x = 180;
                        colorButton1.colorUse1 = 2;
                    }
                    else
                    {
                        colorPicker.x = Screen.width*-1;
                        colorButton1.color = colorPicker.pickedColor;
                        colorButton1.colorUse1 = 1;
                        LedGrid.colorSelect(parent.color)
                    }
                }
            }
        }

        Rectangle
        {
            id: colorButton2
            height: topBar.height
            width: topBar.width/6
            color: 'green'
            radius: width*.1
            border.width: 10
            border.color: 'black'
            property int colorUse2: 0;
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    if (colorButton2.colorUse2 == 0)
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = 'black'
                        colorButton1.border.color = 'black'
                        colorButton2.border.color = "#FFB01C"
                        colorButton3.border.color = 'black'
                        colorButton4.border.color = 'black'
                        colorButton5.border.color = 'black'
                        colorPicker.x = Screen.width*-1;
                        colorButton0.colorUse0 = 0;
                        colorButton1.colorUse1 = 0;
                        colorButton2.colorUse2 = 1;
                        colorButton3.colorUse3 = 0;
                        colorButton4.colorUse4 = 0;
                    }
                    else if (colorButton2.colorUse2 == 1)
                    {
                        colorPicker.x = 180;
                        colorButton2.colorUse2 = 2;
                    }
                    else
                    {
                        colorPicker.x = Screen.width*-1;
                        colorButton2.color = colorPicker.pickedColor;
                        colorButton2.colorUse2 = 1;
                        LedGrid.colorSelect(parent.color)
                    }
                }
            }
        }
        Rectangle
        {
            id: colorButton3
            height: topBar.height
            width: topBar.width/6
            color: 'yellow'
            radius: width*.1
            border.width: 10
            border.color: 'black'
            property int colorUse3: 0;
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    if (colorButton3.colorUse3 == 0)
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = 'black'
                        colorButton1.border.color = 'black'
                        colorButton2.border.color = 'black'
                        colorButton3.border.color = "#FFB01C"
                        colorButton4.border.color = 'black'
                        colorButton5.border.color = 'black'
                        colorPicker.x = Screen.width*-1;
                        colorButton0.colorUse0 = 0;
                        colorButton1.colorUse1 = 0;
                        colorButton2.colorUse2 = 0;
                        colorButton3.colorUse3 = 1;
                        colorButton4.colorUse4 = 0;

                    }
                    else if (colorButton3.colorUse3 == 1)
                    {
                        colorPicker.x = 180;
                        colorButton3.colorUse3 = 2;
                    }
                    else
                    {
                        colorPicker.x = Screen.width*-1;
                        colorButton3.color = colorPicker.pickedColor;
                        colorButton3.colorUse3 = 1;
                        LedGrid.colorSelect(parent.color)
                    }
                }
            }
        }
        Rectangle
        {
            id: colorButton4
            height: topBar.height
            width: topBar.width/6
            color: 'orange'
            radius: width*.1
            border.width: 10
            border.color: 'black'
            property int colorUse4: 0;
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    if (colorButton4.colorUse4 == 0)
                    {
                        LedGrid.colorSelect(parent.color)
                        colorButton0.border.color = 'black'
                        colorButton1.border.color = 'black'
                        colorButton2.border.color = 'black'
                        colorButton3.border.color = 'black'
                        colorButton4.border.color = "#FFB01C"
                        colorButton5.border.color = 'black'
                        colorPicker.x = Screen.width*-1;
                        colorButton0.colorUse0 = 0;
                        colorButton1.colorUse1 = 0;
                        colorButton2.colorUse2 = 0;
                        colorButton3.colorUse3 = 0;
                        colorButton4.colorUse4 = 1;

                    }
                    else if (colorButton4.colorUse4 == 1)
                    {
                        colorPicker.x = 180;
                        colorButton4.colorUse4 = 2;
                    }
                    else
                    {
                        colorPicker.x = Screen.width*-1;
                        colorButton4.color = colorPicker.pickedColor;
                        colorButton4.colorUse4 = 1;
                        LedGrid.colorSelect(parent.color)
                    }
                }
            }
        }
        Rectangle
        {
            id: colorButton5
            height: topBar.height
            width: topBar.width/6
            color: 'black'
            radius: width*.1
            border.width: 10
            border.color: 'black'
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    LedGrid.colorSelect(parent.color)
                    colorButton0.border.color = 'black'
                    colorButton1.border.color = 'black'
                    colorButton2.border.color = 'black'
                    colorButton3.border.color = 'black'
                    colorButton4.border.color = 'black'
                    colorButton5.border.color = "#14DADE"
                    colorButton0.colorUse0 = 0;
                    colorButton1.colorUse1 = 0;
                    colorButton2.colorUse2 = 0;
                    colorButton3.colorUse3 = 0;
                    colorButton4.colorUse4 = 0;
                }
            }
        }
    }
}
