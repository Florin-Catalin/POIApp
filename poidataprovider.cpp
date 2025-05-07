#include "poidataprovider.h"

POIDataProvider::POIDataProvider(QObject *parent) : QObject(parent) {
  // NOLINTBEGIN(cppcoreguidelines-avoid-magic-numbers,readability-magic-numbers)
  m_poiData = {QVariantMap{{"name", "Point A"},
                           {"description", "Description A"},
                           {"color", "red"},
                           {"latitude", 48.858844},
                           {"longitude", 2.2943511}},
               QVariantMap{{"name", "Point B"},
                           {"description", "Description B"},
                           {"color", "blue"},
                           {"latitude", 48.860611},
                           {"longitude", 2.3376441}},
               QVariantMap{{"name", "Point C"},
                           {"description", "Description C"},
                           {"color", "green"},
                           {"latitude", 48.853121},
                           {"longitude", 2.3499121}},
               QVariantMap{{"name", "Point D"},
                           {"description", "Description D"},
                           {"color", "black"},
                           {"latitude", 48.852968},
                           {"longitude", 2.3499021}},
               QVariantMap{{"name", "Point E"},
                           {"description", "Description E"},
                           {"color", "cyan"},
                           {"latitude", 50.860611},
                           {"longitude", 2.3376441}},
               QVariantMap{{"name", "Point F"},
                           {"description", "Description F"},
                           {"color", "yellow"},
                           {"latitude", 49.853121},
                           {"longitude", 2.3499121}},
               QVariantMap{{"name", "Point G"},
                           {"description", "Description G"},
                           {"color", "white"},
                           {"latitude", 48.752968},
                           {"longitude", 2.3499021}}};
  // NOLINTEND(cppcoreguidelines-avoid-magic-numbers,readability-magic-numbers)
}

QVariantList POIDataProvider::poiData() const { return m_poiData; }
