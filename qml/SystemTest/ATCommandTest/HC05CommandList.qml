import QtQuick 2.4

DropDown{
    id:setCommand
    model: ListModel{
        ListElement{
            itemText:"Device Name"
        }
        ListElement{
            itemText:"Pin 18"
        }
        ListElement{
            itemText:"Baud Rate"
        }

      }
}

