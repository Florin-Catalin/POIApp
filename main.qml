// System includes
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15

// Application includes
import "qrc:/AGlobal.js" as GLOBAL
import "qrc:/AColors.js" as COLORS

ApplicationWindow {
    id: oApplicationWindow
    property string pText: qsTr("POI App")
    property bool pIsDesktop: GLOBAL.mIsDesktop()
    width: pIsDesktop ? GLOBAL.desktopApplicationWidth() : maximumWidth
    height: pIsDesktop ? GLOBAL.desktopApplicationHeight() : maximumHeight
    visible: true
    title: oApplicationWindow.pText

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: listViewPage
    }

    // First View: List View
    Item {
        id: listViewPage

        ListModel {
            id: oListModel
        }

        function fillModelFromCpp() {
            oListModel.clear();
            for (let i = 0; i < poiProvider.poiData.length; ++i)
                oListModel.append(poiProvider.poiData[i]);
        }

        Component.onCompleted: fillModelFromCpp()

        Item {
            id: oContentWrapper
            anchors.fill: parent

            POIListVIew {
                id: oListView
                pModel: oListModel
                pDraggedItemParent: oContentWrapper
            }
        }

        Button {
            text: qsTr("Go to Map")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: stackView.push(mapViewPage)
        }
    }

    // Second View: Map View
    Item {
        id: mapViewPage

        Map {
            id: map
            anchors.fill: parent
            plugin: Plugin {
                name: "osm" // OpenStreetMap plugin
            }
            center: QtPositioning.coordinate(48.858844, 2.294351) // Example: Eiffel Tower
            zoomLevel: 14

            // Dynamically create markers for each POI
            Repeater {
                model: poiProvider.poiData
                MapQuickItem {
                    anchorPoint.x: 12
                    anchorPoint.y: 12
                    coordinate: QtPositioning.coordinate(modelData.latitude, modelData.longitude)
                    sourceItem: Rectangle {
                        width: 24
                        height: 24
                        color: modelData.color
                        radius: 12
                    }
                }
            }
        }

        Button {
            text: qsTr("Back to List")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: stackView.pop()
        }
    }
}
