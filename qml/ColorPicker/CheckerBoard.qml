import QtQuick 2.0

Grid
{
    id: root
    property int cellSide: 10
    width: parent.width; height: parent.height
    rows: height/cellSide; columns: width/cellSide
    Repeater
    {
        model: root.columns*root.rows
        Rectangle
        {
            width: root.cellSide; height: root.cellSide
            color: ((index%2  == 0) ? "gray" : "white")

                   /*((root.rows%2 == 0) ? ((index%root.rows*2) < root.rows ?
                                      ((index%2  == 0) ? "gray" : "white"): (((index+1)%2  == 0) ? "gray" : "white")):*/
        }
    }
}
