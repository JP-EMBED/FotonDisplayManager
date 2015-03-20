import QtQuick 2.4
import QtQuick.Controls 1.2
import "styles"
Rectangle {
    anchors.centerIn: parent
    property real parentWidth:0
    property real parentHeight:0
    width:parentWidth * .8
    height: parentHeight * .8
    color:"transparent"


    Switch{
        id: switchTop
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        checked: false
        enabled:true
        width:parent.width
        height: parent.height * .55
        style:ATOnOffStyleLowRes{

        }
        onCheckedChanged: {

        }
    }
    Text{
        anchors.horizontalCenter: switchTop.horizontalCenter
        anchors.top: switchTop.bottom
        anchors.bottom: parent.bottom
        width: switchTop.width
        font.pixelSize: width/3
        anchors.topMargin: -4
        text: switchTop.checked ? "On":"Off"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
    }

}

