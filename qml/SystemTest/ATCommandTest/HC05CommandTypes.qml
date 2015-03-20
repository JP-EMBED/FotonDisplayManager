import QtQuick 2.4

DropDown{
    id:setType
    model:ListModel{
        ListElement{
            itemText:"Query"
        }
        ListElement{
            itemText:"Set"
        }
      }
}

