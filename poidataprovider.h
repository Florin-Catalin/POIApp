#ifndef POIDATAPROVIDER_H
#define POIDATAPROVIDER_H

#include <QObject>
#include <QVariantList>

class POIDataProvider : public QObject {
  Q_OBJECT // Ensure this macro is present

      public : explicit POIDataProvider(QObject *parent = nullptr);

  Q_PROPERTY(QVariantList poiData READ poiData NOTIFY poiDataChanged)

  QVariantList poiData() const;

signals:
  void poiDataChanged();

private:
  QVariantList m_poiData;
};

#endif // POIDATAPROVIDER_H
