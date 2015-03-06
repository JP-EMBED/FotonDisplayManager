import QtQuick 2.0

Rectangle {
    id: toolBarContainer
    border.color: "lightsteelblue"
    border.width: 2
    property bool viewFinderMode: true
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#ffffff";
        }
        GradientStop {
            position: 0.55;
            color: "#fff8e2";
        }
    }
    Rectangle{
        id:backButton
        height:parent.height
        width: parent.width/10
        anchors.left:parent.left
        anchors.topMargin:1
        anchors.bottomMargin:1
        anchors.verticalCenter:  parent.verticalCenter
        border.color: "darkgrey"
        border.width: 2
        color:"black"
        Image{
            height:parent.height*.8
            width:height
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectFit
            source: "images/back.png"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                camView.hideCameraView();
            }
        }

    }
    Rectangle{
        id:captureButton
        height:parent.height
        width: parent.width/3
        anchors.topMargin:1
        anchors.bottomMargin:1
        anchors.horizontalCenter:  parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.color: "darkgrey"
        border.width: 2
        color:"black"
        Text{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text:toolBarContainer.viewFinderMode ? "Capture Image":"Try Again"
            color:"white"
            font.pixelSize: parent.width/text.length
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(viewFinderMode)
                {
                    frontCamera.imageCapture.capture();
                    previewImage.z = viewFinder.z+1;
                    viewFinderMode = false;
                }
                else
                {
                    previewImage.z = viewFinder.z-1;
                    viewFinderMode = true;
                }
            }
        }
    }
}

