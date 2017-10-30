import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.6
import "common.js" as Common
import QtWebView 1.1

Item {
    id: listViewItem
    visible: true

    ListModel{
        id: myModel
    }

    ListView {
            id:view
            anchors.fill: parent
            anchors.margins: 20
            spacing: 4
            clip: true
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            delegate:
                Loader {
                    id: loaderId
                    property string jsonValue: modelData.value
                    property string jsonType: modelData.type
                    property string jsonTitle: modelData.title

                    width: root.width
                    height: root.height*0.9

                    sourceComponent:
                        switch(modelData.type){
                            case "Text": return textDelegate
                            case "Image": return imageDelegate
                            case "Web": return webDelegate
                            case "Video": return videoDelegate
                            case "Audio": return audioDelegate
                            default: return emptyDelegate
                        }




                    Component{
                        id: imageDelegate
                        Rectangle{
                            width: root.width
                            height: root.height/2

                            color: "#dfaadf"

                            Text {
                                text: qsTr(modelData.title)
                            }
                            Image {
                                y: 20
                                width: root.width
                                height: root.height

                                source: "/"+modelData.value
                            }
                        }
                    }

                    Component{
                        id: audioDelegate



                        Rectangle{
                            width: root.width
                            height: root.height/2

                            color: "#0f0adf"

                            SoundEffect {
                                id: music
                                source: "./"+modelData.value
                            }

                            Text {
                                text: qsTr(modelData.title)
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: music.play()
                            }

                        }
                    }

                    Component{
                        id:webDelegate
                        Rectangle{
                            width: root.width
                            height: root.height

                            color: "#efaa00"

                            Text {
                                text: qsTr(modelData.title+"\n"+modelData.value)
                            }

                            WebView {
                                id: webView
                                anchors.fill: parent
                                url: modelData.value
                                onLoadingChanged: {
                                    if (loadRequest.errorString)
                                        console.error(loadRequest.errorString);
                                }
                            }

                        }
                    }

                    Component{
                        id: videoDelegate
                        Rectangle{
                            width: root.width
                            height: root.height

                            color: "#efaa00"
                            MediaPlayer {
                                id: player
                                source: "./"+modelData.value
                            }
                            VideoOutput {
                                anchors.fill: parent
                                source: player
                            }

                            MouseArea{
                                anchors.fill: parent

                                onClicked: {
                                    player.play();
                                }
                            }
                        }
                    }




                    Component{
                        id: emptyDelegate
                        Rectangle{
                            width: root.width
                            height: root.height/2

                            color: "#afddaf"

                            Text {
                                text: qsTr(modelData.title)
                            }
                        }
                    }

                }



            Component {
                    id: textDelegate
                    Rectangle {

    //                                width: root.width
    //                                height: root.height
                        color: "#0faa0f"

                        Text {
                            color: "white"
                            text: qsTr(jsonTitle + "\n" + jsonValue)
                        }

                    }
                }

            function request() {


                    var xhr = new XMLHttpRequest();
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                            print('HEADERS_RECEIVED')
                        } else if(xhr.readyState === XMLHttpRequest.DONE) {
                            print('DONE')
                            print(xhr.responseText)
                            getFavourites()
                        }
                    }
                    xhr.open("POST", Common.BASE_URL + "/login");
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
                    xhr.send("username=user2&password=user2_secret");
            }

            function getFavourites() {

                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                        print('HEADERS_RECEIVED')
                    } else if(xhr.readyState === XMLHttpRequest.DONE) {
                        print('DONE')
                        print(xhr.responseText)
                        var json = JSON.parse(xhr.responseText.toString())

                        view.model = json.items

            //                //mainView.model = json.items
            //                for (var i = 0; i < json.items.length; i++) {
            //                    mylistmodel.append(json.items[i]);
            //                    console.log(json.items[i].itemtitle);
            //                   }
                    }
                    }
                    xhr.open("GET", Common.BASE_URL + "/favourite");
                //        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
                    xhr.send();
            }

        Component.onCompleted: {
            request()
        }

    }
}

