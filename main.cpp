
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "ledboardmanager.h"
#include <QQmlContext>
#include <QScreen>
#include "Foton.h"
#include <QFont>
#include "ledimagegenerator.h"

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

    LedBoardManager   brdManager(nullptr,&app);
    Grid grid(nullptr, &brdManager);
    FExplorer explorer(&grid);
    LEDImageGenerator   imageGen(&engine);
	Foton foton(&grid, &explorer);
    engine.rootContext()->setContextProperty("ScreenWidth",screen_width);
    engine.rootContext()->setContextProperty("ScreenHeight",screen_height);
    engine.rootContext()->setContextProperty("LedBoardManager", &brdManager);
    engine.rootContext()->setContextProperty("LEDImageGenerator", &imageGen);
	engine.rootContext()->setContextProperty("Foton", &foton);
    engine.rootContext()->setContextProperty("FotonGrid", &grid);
    engine.rootContext()->setContextProperty("explorer", &explorer);

    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));




    int ret_val = app.exec();
    return ret_val;
}
