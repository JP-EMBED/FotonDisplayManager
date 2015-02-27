TEMPLATE = app

QT += qml quick bluetooth

#move other libraries too Bluetooth.
win32:QT += serialport

SOURCES += main.cpp \
    connectionmanager.cpp \
    fotonledmessagefactory.cpp \
    ledboardmanager.cpp \
    serialconnectionmanager.cpp

RESOURCES += qml.qrc

CONFIG += C++11

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    qml/main.qml \
    qml/FindDeviceMenu.qml \
    qml/LedBoardView.qml

HEADERS += \
    connectionmanager.h \
    fotonledmessagefactory.h \
    iConnection.h \
    ledboardmanager.h \
    serialconnectionmanager.h
