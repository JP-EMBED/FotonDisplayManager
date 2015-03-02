import QtQuick 2.4
import QtQuick.Window 2.2

Rectangle
{
    property alias saveOpen: saveFile.openSave
    property int page: 0
    property int count: explorer.count()
    property int total: ((count-1)/8)+1

    id: background
    width: parent.width
    height: parent.height
    color: "#595959"

    Rectangle
    {
        id:sideBar
        height: parent.height
        width: parent.width/5
        color: "#262626"
        border.width: 4;


        Text
        {
            y: parent.height/2
            color: "white"
            text:"go back"

        }
        MouseArea
        {
            anchors.fill: parent

            onClicked:
            {
                background.x = Screen.width*-1
            }
        }

    }

    Rectangle
    {
        id:topBar
        width: parent.width
        height: parent.height/8
        color: "#262626"
        border.width: 3;
        Rectangle
        {
            id: up
            height:topBar.height
            width: topBar.height
            color: "transparent"
            border.width: 3;
            Text
            {
                color: "white"
                text:"    ^ "
            }
            MouseArea
            {
                anchors.fill: parent

                onClicked:
                {
                    explorer.cd("..") ;
                    topBarText.text = explorer.getCurrentDir();
                    display();
                    background.page = 0;
                }
            }
        }

        Text
        {
            x: up.width
            id: topBarText
            text: explorer.getCurrentDir();
            color: "white"
            onTextChanged:
            {
                x: 4
                background.page = 0
            }
        }

    }

    Rectangle
    {
        id: fileContainer
        width: (background.width - (sideBar.width+8))
        height: (background.height - topBar.height)
        x: sideBar.width + 4
        y: topBar.height + 4
        color: "#595959"

        Column
        {
            anchors.fill: parent
            spacing: 4
            Rectangle
            {
                id: fileInput
                height: parent.height*(1/17)
                width: parent.width *9/10
                TextInput
                {
                    id: saveText
                    anchors.leftMargin: 4; anchors.bottomMargin: 3; anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft; verticalAlignment: Text.AlignTop
                    color: "#AAAAAA"; selectionColor: "#FF7777AA"
                    font.pixelSize: height
                    maximumLength: 256
                    selectByMouse: true

                }
            }
            File
            {
                id:file1
                index: 0
                text: file1.text = explorer.getFile(background.page*8     );

            }
            File
            {
                id:file2
                index: 1
                text: file2.text = explorer.getFile(background.page*8 + 1 );
            }
            File
            {
                id:file3
                index: 2
                text: file3.text = explorer.getFile(background.page*8 + 2 );
            }
            File
            {
                id:file4
                index: 3
                text: file4.text = explorer.getFile(background.page*8 + 3 );
            }
            File
            {
                id:file5
                index: 4
                text: file5.text = explorer.getFile(background.page*8 + 4 );
            }
            File
            {
                id:file6
                index: 5
                text: file6.text = explorer.getFile(background.page*8 + 5 );
            }
            File
            {
                id:file7
                index: 6
                text: file7.text = explorer.getFile(background.page*8 + 6 );
            }
            File
            {
                id:file8
                index: 7
                text: file8.text = explorer.getFile(background.page*8 + 7 );
            }
        }
        Rectangle
        {
            id:saveFile
            height: fileInput.height
            width: parent.width *1/10
            x: file1.width +4
            property int openSave: 1
            Text
            {
                text: parent.openSave ? "Save" : "Open"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    if (saveText.text != "")
                    {
                        if(saveFile.openSave)
                            Foton.saveFoton(saveText.text);
                        else
                            Foton.openFoton(saveText.text);

                        display()
                        displayGrid()
                    }
                    inputBox.text = LedGrid.getDuration()/1000
                    background.x = Screen.width*-1
                }
            }
        }

        Rectangle
        {
            id:upFile
            height: parent.width *1/10
            width: parent.width *1/10
            y: fileInput.height+8
            x: file1.width +4
            Text
            {
                text:"up"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    loadPage(0);
                }
            }
        }
        Rectangle
        {
            id:downFile
            height: parent.width *1/10
            width: parent.width *1/10
            y: (fileContainer.height - (height+8))
            x: file1.width +4
            Text
            {
                text:"down"
            }
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    loadPage(1);
                }
            }
        }
    }

    function loadPage(dir)
    {
        background.count = explorer.count();
        //load new values
        if(dir)
        {
            if(background.page >= (total-1))
                background.page = 0;
            else
                background.page += 1;
        }
        else
        {
            if(background.page <= 0)
                background.page = total-1;
            else
                background.page -= 1;
        }
        display()
    }

    function display()
    {
        file1.text = explorer.getFile(background.page*8     );
        file2.text = explorer.getFile(background.page*8 + 1 );
        file3.text = explorer.getFile(background.page*8 + 2 );
        file4.text = explorer.getFile(background.page*8 + 3 );
        file5.text = explorer.getFile(background.page*8 + 4 );
        file6.text = explorer.getFile(background.page*8 + 5 );
        file7.text = explorer.getFile(background.page*8 + 6 );
        file8.text = explorer.getFile(background.page*8 + 7 );
    }

}
