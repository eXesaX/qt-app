import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtMultimedia 5.6
import "common.js" as Common


Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Component.onCompleted: {
        Common.createWindows("list.qml");
    }


}
