
// System includes
import QtQuick 2.15
import QtQuick.Controls 2.15

// Application includes
import "qrc:/AColors.js" as COLORS;

// Component
ScrollView {

    property ListModel pModel;
    property Item pDraggedItemParent;

    id: oScrollView;
    anchors.fill: parent;

    ListView {

        id: oListView;
        width: parent.width;
        model: oScrollView.pModel;
        spacing: 5;
        delegate: DraggableItem {

            id: oDelegate;
            pDraggedItemParent: oScrollView.pDraggedItemParent;

            onSgMoveItem: {

                console.log("Item moved from",inFrom,"to",inTo);
                oScrollView.pModel.move(inFrom,inTo,1);
            }

            Rectangle {

                id: oDelegateItem;
                width: oListView.width;
                height: oDelegateLabel.height * 2.5;
                color: model.color;
                anchors.centerIn: parent;

                Text {

                    id: oDelegateLabel;
                    text: model.name;
                    anchors.centerIn: parent;
                    color: COLORS.mWhiteLight();
                    font.bold: true;
                    font.pixelSize: 18;
                }
            }
        }
    }
}
