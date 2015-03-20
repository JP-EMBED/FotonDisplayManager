import QtQuick 2.4
import "../../TitleView"
Rectangle {
    id:atTerminalTop
    width: parent.width
    height:parent.height
    color: "black"
    border.color: "white"
    border.width: 2
    signal finished()
    Rectangle{
        id:terminalContainer
        anchors.left: parent.left
        width: parent.width * .75
        height: parent.height * .75
        color:"black"
        clip: true
        anchors.margins: 4
        TerminalEditView{
            id:terminalEdit
            anchors.fill: parent
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            border.color: "white"
            border.width: 2
            terminalEdit.readOnly: true
        }

    }
    Rectangle{
        id: commandRect
        anchors.left:terminalContainer.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#554848"
        border.color: "white"
        border.width: 2
        Text{
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right:  parent.right
            anchors.margins: 2
            height: parent.height/9
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
            id: actionText
            text:"Perform Action"
            color:"white"
            font.pixelSize: (actionText.width/text.length -2)
        }



        /*******************************************************
        *Set Type Drop Down Box
        * Choose to Query current value or Set the value.
        *******************************************************/
        HC05CommandTypes{
            id:setType
            displayWidth: parent.width * .8
            displayHeight:  parent.height/6
            listMaximumHeight: parent.height - 4
            listMaximumWidth: parent.width
            listWidth: parent.width
            anchors.margins: 8
            anchors.top: actionText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            z:3
            listZValue: setCommand.z + 25
        }

        /*******************************************************
        *Set Command Drop Down Box
        * Choose the command to send
        *******************************************************/
        HC05CommandList{
            id:setCommand
            displayWidth: parent.width * .8
            displayHeight:  parent.height/6
            listMaximumHeight: parent.height - 4
            listMaximumWidth: parent.width
            listWidth: parent.width
            anchors.top: setType.bottom
            anchors.margins: 8
            anchors.horizontalCenter: parent.horizontalCenter
            listZValue: commandRect.z + 26
            z:2
            onItemSelected: {
                commandWidget.currentWidget = index;
            }
        }

        CommandWidgetLoader{
            id: commandWidget
            anchors.margins: 4
            z:1
            anchors.top: setCommand.bottom
            anchors.bottom: performButton.top
            anchors.left:parent.left
            anchors.right:parent.right
        }
        TitleButton{
            id:performButton
            height: parent.height/6
            width:parent.width -8
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            font_family: rockerFont.name
            z:0
            text:"Perform Action"
        }

        Component.onCompleted: {
            commandWidget.widgets = ["TextInput.qml" ,
                                     commandWidget.width > 360 ? "ATOnOffHiRes.qml":"ATOnOffLowRes.qml",
                                     "BaudRateList.qml"];
        }
    }


}

