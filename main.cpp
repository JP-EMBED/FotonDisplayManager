#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ledboardmanager.h"
#include <QQmlContext>
#include <QScreen>
//#include "serialconnectionmanager.h"
#include "Foton.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    QScreen* pscreen(app.primaryScreen());

    int  screen_width;
    int  screen_height;
    bool show_expanded(true);
    QString display_mode("FullScreen");


    show_expanded = false; // Uncomment for FULLSCREEN

    if(!show_expanded)
    {
        screen_width = pscreen->size().width();
        screen_height = pscreen->size().height();
    }
    else
    {
        screen_width = pscreen->availableGeometry().width();
        screen_height = pscreen->availableGeometry().height();
        display_mode = "Maximized";
    }
    int temp_width(screen_width);
    if(screen_height > screen_width)
    {
        screen_width = screen_height;
        screen_height = temp_width;
    }

	Grid grid;
    FExplorer explorer(&grid);
	Foton foton(&grid, &explorer);
    LedBoardManager   brdManager(nullptr,&app);
    engine.rootContext()->setContextProperty("ScreenWidth",screen_width);
    engine.rootContext()->setContextProperty("ScreenHeight",screen_height);
    engine.rootContext()->setContextProperty("LedBoardManager", &brdManager);
	engine.rootContext()->setContextProperty("Foton", &foton);
    engine.rootContext()->setContextProperty("LedGrid", &grid);
    engine.rootContext()->setContextProperty("explorer", &explorer);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));




    int ret_val = app.exec();
    return ret_val;
}
