import QtQuick 2.4

Rectangle {
   color:"transparent"
   id: topLoader
   property real currentWidget: 0
   property var widgets:[]
   Loader{
       id:loader
       active:true
       source: ""
       onLoaded:
       {
           item.parent = topLoader
           item.parentWidth = topLoader.width
           item.parentHeight = topLoader.height
       }
   }
   onCurrentWidgetChanged: {
       if(currentWidget < widgets.length && widgets[currentWidget] !== undefined)
       {
           loader.setSource(widgets[currentWidget]);
           loader.active = true;
       }
       else
       {
           loader.setSource("")
           loader.active = false
       }
   }
   onWidgetsChanged: {
       if(currentWidget < widgets.length && widgets[currentWidget] !== undefined)
       {
           loader.setSource(widgets[currentWidget]);
           loader.active = true;
       }
       else
       {
           loader.setSource("")
           loader.active = false
       }
   }
}

