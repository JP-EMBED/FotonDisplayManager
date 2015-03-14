import QtQuick 2.4
import QtMultimedia 5.4

Rectangle {
    id:camView
    visible:false
    property bool viewFinderMode: true
    property string currentDevice: ""
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
        target:titleBar
        onSwitchToBack:{
            camera.position = Camera.BackFace;
        }
        onSwitchToFront:{
            camera.position = Camera.FrontFace;
        }
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
        backCamAvailable: (QtMultimedia.availableCameras.length > 1)
        width: parent.width
        height: parent.height/10
        anchors.top: parent.top
    }

    Camera{
        id:camera
        deviceId:currentDevice
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
        width:capturer.resolution.width
        height:capturer.resolution.height
        sourceSize.width:capturer.resolution.width
        sourceSize.height:capturer.resolution.height
    }

    VideoOutput{
        id:viewFinder
        source: camera
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
        border.width: parent.width/240
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
            camera.cameraState = Camera.ActiveState;
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
            camera.cameraState = Camera.UnloadedState
        }

    }
    Component.onCompleted: {
       if(QtMultimedia.availableCameras.length >= 1)
       {
           for(var i = 0; i < QtMultimedia.availableCameras.length; i++)
           {
                if(QtMultimedia.availableCameras[i].position == Camera.FrontFace)
                {
                    camView.currentDevice = QtMultimedia.availableCameras[i].deviceId;
                    break;
                }
           }
       }
    }
}

