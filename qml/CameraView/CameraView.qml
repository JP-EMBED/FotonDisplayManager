import QtQuick 2.4
import QtMultimedia 5.4

Rectangle {
    id:camView
    visible:false
    function showCameraView(){
        frontCamera.cameraState = Camera.ActiveState;
        camView.visible = true;
        openCameraView.start();
    }
    function hideCameraView(){
        frontCamera.cameraState = Camera.UnloadedState
        closeCameraView.start();
    }

    TitleBar{
        id: titleBar
        width: parent.width
        height: parent.height/10
        anchors.top: parent.top
    }

    Camera{
        id:frontCamera
        cameraState: Camera.UnloadedState
        captureMode:Camera.CaptureViewfinder
        position:Camera.FrontFace
        imageCapture{
            id:capturer
            resolution: Qt.size(320,240)
            onImageCaptured: {
                previewImage.source = preview;
            }
        }
    }
    Image{
        id:previewImage
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: toolBar.top
    }

    VideoOutput{
        id:viewFinder
        source: frontCamera
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: toolBar.top
    }
    Rectangle{
        height:80
        width: 80
        anchors.top: viewFinder.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
        Text{
            text:"Click"
            anchors.fill: parent
        }
    }
    ListView {
            anchors.left: parent.left
            height:parent.height
            width: parent.width/3

            model: QtMultimedia.availableCameras
            delegate: Text {
                text: modelData.displayName

                MouseArea {
                    anchors.fill: parent
                    onClicked: camera.deviceId = modelData.deviceId
                }
            }
        }
    ToolBar{
        id: toolBar
        width: parent.width
        height:parent.height/10
        border.color: "lightsteelblue"
        anchors.bottom: parent.bottom
    }
    Rectangle
    {
        id: cropBox
        color: "transparent"
        border.width: parent.width/200
        border.color: 'white'
        transformOrigin: Item.Center
        width: 320
        height: width
        x: viewFinder.x+40
        y: viewFinder.y+40
        z:viewFinder.z +2
        MouseArea{
            anchors.fill: parent
            drag.target: cropBox
            drag.axis: Drag.XAndYAxis
            drag.minimumX: 0
            drag.minimumY: 0
            drag.maximumX: previewImage.width
            drag.maximumY: previewImage.height
        }
    }
    NumberAnimation on y{
        id: openCameraView
        duration: 500;
        from: -(camView.height)
        to: 0
        running: false
        alwaysRunToEnd: true
        onStopped: {
        }

    }
    NumberAnimation on y{
        id: closeCameraView
        duration: 500;
        from: 0
        to: -(camView.height)
        alwaysRunToEnd: true
        running: false
        onStopped: {
            camView.visible = !camView.visible;
        }

    }
}

