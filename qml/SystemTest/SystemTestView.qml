import QtQuick 2.4
import "ColorChecker"
import "ATCommandTest"
Rectangle {
    id:testView
    visible:false


    function showTestView(){
        testView.visible = true;
        openTestView.start();
    }
    function hideTestView(){
        closeTestView.start();
    }



    TitleBar{
        id: titleBar
        width: parent.width
        height: parent.height/10
        anchors.top: parent.top
    }



    Grid{

        anchors.centerIn: parent
        width: parent.width/2
        height: parent.height/2
        spacing: 40
        columns: 3
        rows: 2
        Rectangle{
            height: 200
            width: 300
            border.color: "orange"
            color:"transparent"
            Rectangle{
                id: colorChecker
                width: parent.width * .85
                height: parent.height * .65
                color: "lightsteelblue"
                radius: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.margins: 10
                Image{
                    anchors.centerIn: parent
                    height:parent.height * .75
                    width:parent.width *.75
                    source: "images/icon.png"
                }
            }
            Text{
                height:parent.height * .3
                width: parent.width * .85
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: colorChecker.bottom
                text: "Color Tester"
                color: "white"
                font.pixelSize: height *.65
                horizontalAlignment: Text.AlignHCenter

            }
            radius: 12
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    colorCheckerLoader.active = true;
                }
            }
        }
        Rectangle{
            height: 200
            width: 300
            border.color: "orange"
            color:"transparent"
            Rectangle{
                id: atCommand
                width: parent.width * .85
                height: parent.height * .65
                color: "lightsteelblue"
                radius: 12
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.margins: 10
                Image{
                    anchors.centerIn: parent
                    height:parent.height * .75
                    width:parent.width *.75
                    source: "images/Terminal.png"
                }
            }
            Text{
                height:parent.height * .3
                width: parent.width * .85
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: atCommand.bottom
                text: "AT Commands"
                color: "white"
                font.pixelSize: height *.5
                horizontalAlignment: Text.AlignHCenter

            }
            radius: 12
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    atTerminalLoader.active = true;
                }
            }
        }
    }




    NumberAnimation on x{
        id: openTestView
        duration: 500;
        from: -(testView.width)
        to: 0
        running: false
        alwaysRunToEnd: true
        onStopped: {

        }

    }
    NumberAnimation on x{
        id: closeTestView
        duration: 500;
        from: 0
        to: -(testView.width)
        alwaysRunToEnd: true
        running: false
        onStopped: {
            testView.visible = false;
        }
    }

    // Loader elements

    Loader{
        id: colorCheckerLoader
        active: false
        anchors.fill: parent
        sourceComponent:colorCheckerComponent
    }

    Loader{
        id: atTerminalLoader
        active: false
        anchors.fill: parent
        sourceComponent:atTerminalComponent
    }

    Component{
        id:atTerminalComponent
        TerminalView{
            id:atTerminalView
            z: testView.z + 4
            onFinished:{
                testView.visible = false;
                colorCheckerLoader.active = false;
            }
        }
    }
    Component{
        id:colorCheckerComponent
        ColorCheckerView{
            id:colorCheckerView
            z: testView.z + 4
            onFinished:{
                testView.visible = false;
                colorCheckerLoader.active = false;
            }
        }
    }
}

