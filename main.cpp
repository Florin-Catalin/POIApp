// System includes
#include "poidataprovider.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>


// Qt Quick Application
auto main(int inCounter, char *inArguments[]) -> int {

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
      &oEngine, &QQmlApplicationEngine::objectCreated, &oApplication,
      [oURL](QObject *obj, const QUrl &objUrl) {
          if ((nullptr == obj) && oURL == objUrl) {
          QCoreApplication::exit(-1);
        }
      },
      Qt::QueuedConnection);

  oEngine.load(oURL);

  return QGuiApplication::exec();
}
