import QtQuick 2.0

Rectangle {
    id: toolBarContainer
    border.color: "lightsteelblue"
    border.width: 2
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
            text:viewFinderMode ? "Capture Image":"Try Again"
            color:"white"
            font.pixelSize: parent.width/text.length
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                if(viewFinderMode)
                {
                    camera.imageCapture.capture();
                    previewImage.z = viewFinder.z+1;
                    viewFinder.visible = false;
                    cropBox.visible = true
                    viewFinderMode = false;
                }
                else
                {
                    previewImage.z = viewFinder.z-1;
                    viewFinder.visible = true;
                    cropBox.visible = false
                    viewFinderMode = true;
                }
            }
        }
    }
    Rectangle{
        id:saveButton
        height:parent.height
        width: parent.width/10
        anchors.right:parent.right
        anchors.topMargin:1
        anchors.bottomMargin:1
        anchors.verticalCenter:  parent.verticalCenter
        border.color: "darkgrey"
        border.width: 2
        color:"black"
        Text{
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text:"Set to Board"
            color:"white"
            font.pixelSize: parent.width/text.length
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                LEDImageGenerator.setPicture(previewImage.source,(cropBox.x - previewImage.x),
                                             (cropBox.y - previewImage.y));
            }
        }

    }
}

