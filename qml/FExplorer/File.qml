import QtQuick 2.4

Rectangle
{
    property alias text: rootText.text
    id: root
    width: parent.width *9/10
    height: (parent.height-40)*(2/17)
    color: "#262626"
    property int index: 0;

    Text
    {
        id: rootText
        color: "white"
        text:".."
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked:
        {
            if(rootText.text != "")
            {
                if(explorer.processFile(rootText.text))
                    saveText.text = rootText.text;
                else
                {
                    topBarText.text = explorer.getCurrentDir();
                    background.page = 0;
                    display();
                }
            }
        }
    }
}
