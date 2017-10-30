import QtQuick 2.6
import QtQuick.Controls 2.2
import "common.js" as Common

Item {
    Text {
        id: usernamelabel
        x: 50
        y: 50
        text: "Username"
    }

    TextField {
        id: username
        x: 50
        anchors.top: usernamelabel.bottom
//        y: 75
    }

    Text {
        id: passwordlabel
        x: 50
//        y: 100
        text: "Password"
        anchors.top: username.bottom

    }

    TextField {
        id: passw
        x: 50
//        y: 125
        echoMode: TextInput.Password
        anchors.top: passwordlabel.bottom

    }

    Button {
        id: loginbtn
        x: 50
//        y: 150
        text: "login"
        onClicked: {

//            Common.request()
            Common.createWindows("list.qml")

        }
        anchors.top: passw.bottom


    }



}
