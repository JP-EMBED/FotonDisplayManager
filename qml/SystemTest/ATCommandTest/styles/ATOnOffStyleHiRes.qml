import QtQuick 2.4
import QtQuick.Controls.Styles 1.2

SwitchStyle {
    property real height: parent.height
    property real width: parent.width
    groove: Rectangle {
            id:groover
            implicitWidth: 360
            implicitHeight: 180
            radius: width/20
            border.color: control.activeFocus ? "darkblue" : "gray"
            border.width: 1
            color: switchTop.checked ? "blue" : "white"
    }
    handle: Rectangle
    {
        id:handle
        implicitWidth: 178
        implicitHeight: 178
        radius: width/4
        border.color: control.activeFocus ? "darkblue" : "gray"
        border.width: 2
        Rectangle{
            anchors.fill: parent
            anchors.margins: 8
            border.width: 2
            border.color:"black"
            radius: width/2
            color: switchTop.checked ? "green":"red"
        }
    }
}
