import QtQuick 2.4
import QtMultimedia 5.4

Rectangle {
    id:camView
    visible:false
    property bool viewFinderMode: true
    function showCameraView(){
        openCameraView.start();
        camView.visible = true;
    }
    function hideCameraView(){
        closeCameraView.start();

        viewFinder.visible = true;
        previewImage.visible = false
        cropBox.visible = false
        viewFinderMode = true
    }
    Connections{
        target: LEDImageGenerator
        onUpdatedLed:{
           LedBoardManager.sendLedColor(color_in);
           FotonGrid.setLedColor(color_in,col_in, row_in);
           boardView.ledBoard.itemAt(col_in + row_in*32).color = color_in
           LedBoardManager.sendLedSet(col_in, row_in);

        }
        onFinishedGeneratingImage:
        {
            hideCameraView();
        }
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
            resolution: Qt.size(1280,720)
            onImageCaptured: {
                previewImage.source = preview;
                previewImage.visible = true
                cropBox.visible = true
            }
        }
    }
    Image{
        id:previewImage
        anchors.centerIn: parent
        width:1280
        height:720
        sourceSize.width:1280
        sourceSize.height:720
    }

    VideoOutput{
        id:viewFinder
        source: frontCamera
        anchors.top: titleBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: toolBar.top
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
        visible: false
        transformOrigin: Item.Center
        width: 320
        height: width
        x: previewImage.x+40
        y: previewImage.y+40
        z:viewFinder.z +2
        MouseArea{
            anchors.fill: parent
            drag.target: cropBox
            drag.axis: Drag.XAndYAxis
            drag.minimumX: previewImage.x
            drag.minimumY: previewImage.y
            drag.maximumX: (previewImage.x +previewImage.width - 320)
            drag.maximumY: (previewImage.y +previewImage.height - 320)
        }
        PinchArea{
            id:pincharea
            enabled:false
            anchors.fill: parent
            property double oldZoom: 1
            onPinchStarted: {
                oldZoom = pinch.scale
            }
            onPinchUpdated: {
                if(oldZoom  < pinch.scale)
                {
                    cropBox.height = cropBox.height + (cropBox.count * 1)
                    cropBox.width = cropBox.width + (cropBox.count * 1)
                }
                else
                {
                    cropBox.height = cropBox.height - (cropBox.count * 5)
                    cropBox.width = cropBox.width - (cropBox.count * 5)
                }
            }
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
            frontCamera.cameraState = Camera.ActiveState;
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
            frontCamera.cameraState = Camera.UnloadedState
        }

    }
}

