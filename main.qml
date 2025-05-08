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

                    // Handle click
                             MouseArea {
                                 anchors.fill: parent
                                 onClicked: {
                                     poiInfoPopup.visible = true
                                     poiInfoPopup.poiName = modelData.name
                                     poiInfoPopup.poiDescription = modelData.description
                                 }
                             }
                }

            }

            // Info popup
            Popup {
                id: poiInfoPopup
                property string poiName
                property string poiDescription
                visible: false
                // Center the popup in the parent
                anchors.centerIn: parent
                // Set a fixed or proportional size if desired
                width: parent.width * 0.6
                height: parent.height * 0.3
                // Make the popup background semi-transparent
                background: Rectangle {
                    color: "#CC222222" // semi-transparent dark background
                    radius: 12
                }
                contentItem: Column {
                    anchors.centerIn: parent
                    spacing: 12
                    Text {
                        text: poiInfoPopup.poiName
                        color: "white"
                        font.bold: true
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: poiInfoPopup.poiDescription
                        color: "white"
                        font.pixelSize: 16
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Button {
                        text: "Close"
                        anchors.horizontalCenter: parent.horizontalCenter
                        onClicked: poiInfoPopup.visible = false
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
