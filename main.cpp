// System includes
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "poidataprovider.h"

// Application includes

// Constants

// Qt Quick Application
int main(int inCounter, char *inArguments[]) {

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication oApplication(inCounter, inArguments);
    QQmlApplicationEngine oEngine;



    const QUrl oURL(QStringLiteral("qrc:/main.qml"));
    // Register POIDataProvider
    POIDataProvider poiProvider;

    oEngine.rootContext()->setContextProperty("poiProvider", &poiProvider);
    QObject::connect(
        &oEngine, &QQmlApplicationEngine::objectCreated,
        &oApplication, [oURL](QObject *obj, const QUrl &objUrl) {
            if (!obj && oURL == objUrl) {
                QCoreApplication::exit(-1);
            }
        }, Qt::QueuedConnection
        );


    oEngine.load(oURL);

    return oApplication.exec();
}
