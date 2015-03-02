TEMPLATE = app

QT += qml quick bluetooth

#move other libraries too Bluetooth.


SOURCES += main.cpp \
    connectionmanager.cpp \
    fotonledmessagefactory.cpp \
    ledboardmanager.cpp \
    FExplorer.cpp \
    Foton.cpp \
    grid.cpp

RESOURCES += qml.qrc

CONFIG += C++11

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/main.qml \
    qml/FindDeviceMenu.qml \
    qml/LedBoardView.qml \
    qml/ColorPicker/CheckerBoard.qml \
    qml/ColorPicker/ColorPicker.qml \
    qml/ColorPicker/ColorSlider.qml \
    qml/ColorPicker/NumberBox.qml \
    qml/ColorPicker/PanelBorder.qml \
    qml/ColorPicker/SBPicker.qml \
    qml/FExplorer/FExplorer.qml \
    qml/FExplorer/File.qml \
    qml/LedBoardView/ColorPalette.qml \
    qml/LedBoardView/ToolBar.qml \
    qml/LedBoardView/AnimationBar.qml \
    qml/LedBoardView/LedGrid.qml \
    qml/LedBoardView/LedBoardView.qml \
    qml/LedGrid.qml \
    qml/LedBoardView/LedGrid.qml

HEADERS += \
    connectionmanager.h \
    fotonledmessagefactory.h \
    iConnection.h \
    ledboardmanager.h \
    FExplorer.h \
    Foton.h \
    grid.h

OTHER_FILES += \
    qml/main.qml \
    qml/ColorPicker/CheckerBoard.qml \
    qml/ColorPicker/ColorPicker.qml \
    qml/ColorPicker/ColorSlider.qml \
    qml/ColorPicker/NumberBox.qml \
    qml/ColorPicker/PanelBorder.qml \
    qml/ColorPicker/SBPicker.qml \
    qml/FExplorer/FExplorer.qml \
    qml/FExplorer/File.qml \
    qml/LedBoardView/AnimationBar.qml \
    qml/LedBoardView/ColorPalette.qml \
    qml/LedBoardView/LedBoardView.qml \
    qml/LedBoardView/LedGrid.qml \
    qml/LedBoardView/ToolBar.qml \
    qml/ConnectionMenu/FindDeviceMenu.qml
