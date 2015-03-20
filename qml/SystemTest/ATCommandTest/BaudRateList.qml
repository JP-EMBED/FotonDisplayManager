import QtQuick 2.4
DropDown{
    id:setBaud
    property real parentWidth:0
    property real parentHeight:0
    displayWidth: parentWidth * .8
    displayHeight:  parentHeight * .45
    listMaximumHeight: parentHeight * 1.5
    listMaximumWidth: parentWidth
    listWidth: parentWidth
    anchors.top: parent.top
    anchors.topMargin: 20
    anchors.horizontalCenter: parent.horizontalCenter
    z:2
    listZValue: setBaud.z + 25
    model:ListModel{
        ListElement{
            itemText:"115200"
        }
        ListElement{
            itemText:"38400"
        }
        ListElement{
            itemText:"96000"
        }

      }

}
