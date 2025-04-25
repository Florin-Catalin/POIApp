#include "poidataprovider.h"

POIDataProvider::POIDataProvider(QObject *parent)
    : QObject(parent) {
    // Example data
    m_poiData = {
        QVariantMap{{"name", "Point A"}, {"description", "Description A"}},
        QVariantMap{{"name", "Point B"}, {"description", "Description B"}},
        QVariantMap{{"name", "Point C"}, {"description", "Description C"}},
        QVariantMap{{"name", "Point A"}, {"description", "Description A"}},
        QVariantMap{{"name", "Point B"}, {"description", "Description B"}},
        QVariantMap{{"name", "Point C"}, {"description", "Description C"}}
    };
}

QVariantList POIDataProvider::poiData() const {
    return m_poiData;
}
