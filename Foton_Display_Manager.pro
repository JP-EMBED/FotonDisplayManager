TEMPLATE = app

QT += qml quick bluetooth

win32{
QT += serialport
}

#move other libraries too Bluetooth.


SOURCES += main.cpp \
    connectionmanager.cpp \
    fotonledmessagefactory.cpp \
    ledboardmanager.cpp \
    FExplorer.cpp \
    Foton.cpp \
    grid.cpp \
    serialconnectionmanager.cpp \
    ledimagegenerator.cpp

RESOURCES += qml.qrc \
    images.qrc

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
    qml/LedBoardView/LedGrid.qml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    qml/CameraView/CameraView.qml \
    qml/CameraView/TitleBar.qml \
    qml/CameraView/ToolBar.qml \
    qml/TitleView/TitleView.qml \
    qml/ledscreencomponent/LedScreen.qml \
    qml/TitleView/TitleButton.qml \
    qml/SystemTest/SystemTestView.qml \
    qml/SystemTest/TitleBar.qml \
    qml/SystemTest/ColorChecker/ColorCheckerView.qml \
    qml/SystemTest/ColorChecker/Spinner.qml \
    qml/SystemTest/ColorChecker/RGBColorPicker.qml \
    qml/SystemTest/ATCommandTest/TerminalView.qml \
    qml/SystemTest/ATCommandTest/TerminalEditView.qml \
    qml/SystemTest/ATCommandTest/DropDown.qml \
    qml/SystemTest/ATCommandTest/HC05CommandTypes.qml \
    qml/SystemTest/ATCommandTest/HC05CommandList.qml \
    qml/SystemTest/ATCommandTest/CommandWidgetLoader.qml \
    qml/SystemTest/ATCommandTest/styles/ATOnOffStyleHiRes.qml \
    qml/SystemTest/ATCommandTest/BaudRateList.qml \
    qml/SystemTest/ATCommandTest/TextInput.qml \
    qml/SystemTest/ATCommandTest/styles/ATOnOffStyleLowRes.qml \
    qml/SystemTest/ATCommandTest/ATOnOffHiRes.qml \
    qml/SystemTest/ATCommandTest/ATOnOffLowRes.qml

HEADERS += \
    connectionmanager.h \
    fotonledmessagefactory.h \
    iConnection.h \
    ledboardmanager.h \
    FExplorer.h \
    Foton.h \
    grid.h \
    serialconnectionmanager.h \
    ledimagegenerator.h

OTHER_FILES += \


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
