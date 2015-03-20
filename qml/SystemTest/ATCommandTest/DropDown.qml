import QtQuick 2.4

Rectangle {
    color:"transparent"
    border.color: "transparent"
    id: topContainer
    signal itemSelected(real index, var object)
    visible: true
    property real  displayWidth: 200
    property real  displayHeight: 200
    property alias displayItem: dropDownMain
    property string currentText: ""
    property real listHeight: parent.height * 1.5
    property real listWidth: parent.width
    property real listMaximumHeight: 200
    property real listMaximumWidth: 200
    property real listZValue: 100
    property bool  open: false
    property ListModel  model:ListModel{}
    height: displayHeight
    width: displayWidth
    Rectangle{
       id: dropDownMain
       height: displayHeight
       width: displayWidth
       color: "blue"
       radius: parent.width/10
       border.color: "black"
       border.width: 2
       anchors.margins: 4
       anchors.top: parent.top
       anchors.horizontalCenter: parent.horizontalCenter
       Text{
           color:"white"
           text: currentText
           anchors.fill: parent
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           font.pixelSize: width / text.length + 2
       }
       MouseArea
       {
           enabled: !topContainer.open
           anchors.fill: parent
           onClicked: {
               topContainer.open = true;
           }
       }
       z:parent.z
    }

    property Component delegate:Rectangle{
        id: dropDownCommand
        color:"red"
        border.width: 1
        border.color: "black"
        radius: dropDownMain.width/8
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        property alias text: textArea
        height: dropDownMain.height
        width: dropDownMain.width
        Text{
            id:textArea
            color:"white"
            text: itemText
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: width / text.length + 2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                ListView.currentIndex = index;
                topContainer.currentText = textArea.text;
                topContainer.open = false;
                itemSelected(index, textArea.text)
            }
        }
     }

    Rectangle{
        id:listViewContainer
        anchors.top:dropDownMain.top
        anchors.horizontalCenter: dropDownMain.horizontalCenter
        height: listHeight < listMaximumHeight ? listHeight:listMaximumHeight
        width: listWidth < listMaximumWidth ? listWidth:listMaximumWidth
        visible: topContainer.open
        z: listZValue
        clip:true
        ListView{
            id:list
            delegate: topContainer.delegate
            model:model
            highlightFollowsCurrentItem: true
            spacing:10
            anchors.fill: parent
            anchors.margins: 2
            anchors.topMargin: 8
        }
        border.color: "black"
        border.width: 4
        color:"darkgrey"
    }



    onModelChanged: {
        list.model = model;
        if(model)
        {
            currentText = model.get(0).itemText
            listHeight = (displayHeight * model.count)
            //list.height = (displayHeight * model.length)
        }
    }
    onDelegateChanged: {
        list.delegate = delegate;
    }
}

