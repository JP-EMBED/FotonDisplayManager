import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {

    property bool backCamAvailable : false
    signal switchToBack()
    signal switchToFront()
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#3e3e3e";
        }
        GradientStop {
            position: 1.00;
            color: "#000000";
        }
    }
    border.color: "orange"
    border.width: 2
    Text{
        id: titleText
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.right: parent.horizontalCenter
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height * .75
        text:"Photo Capture Mode"
        color: "white"
    }
    Switch{
        id: cameraSwitch
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: cameraText.left
        anchors.rightMargin: 20
        checked: false
        visible: backCamAvailable
        width:parent.width/8
        height: parent.height*.75
        style:SwitchStyle {
            groove: Rectangle {
                    id:groove
                    implicitWidth: 200
                    implicitHeight: 90
                    radius: 20
                    border.color: control.activeFocus ? "darkblue" : "gray"
                    border.width: 1
                    color: cameraSwitch.checked ? "blue" : "white"
            }
            handle: Rectangle
            {
                id:handle
                implicitWidth: 100
                implicitHeight: 82
                radius: 20
                border.color: control.activeFocus ? "darkblue" : "gray"
                border.width: 1
                Image{
                    anchors.fill: parent
                    source: "images/swap-camera.png"
                }
            }
        }
        onCheckedChanged: {
            if(checked)
            {
                switchToBack()
            }
            else
            {
                switchToFront()
            }
        }
    }
    Text{
        id: cameraText
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width/6
        height: parent.height
        anchors.margins: 6
        visible: backCamAvailable
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height * .75
        text: cameraSwitch.checked ? "Back" : "Front"
        color: "white"
    }
}

