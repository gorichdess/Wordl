#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <src/GameController.h>

int main(int argc,char * argv[]){

    //qputenv("QT_QUICK_CONTROLS_STYLE", "Basic");

    QGuiApplication app(argc,argv);

    QQmlApplicationEngine engine;

    GameController gameController;

    engine.rootContext()->setContextProperty("gameController", &gameController);

    engine.loadFromModule("WordlClone", "Main");

    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}