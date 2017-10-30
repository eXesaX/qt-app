function createWindows(qmlname) {
     var component = Qt.createComponent(qmlname);
     console.log("Component Status:", component.status, component.errorString());
     var c = component.createObject(window, {"x": 0, "y": 0});
//     c.show();
}

var BASE_URL = "http://192.168.43.45:5000"


function request() {


        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED')
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                print('DONE')
                print(xhr.responseText)
//                getFavourites()
            }
        }
        xhr.open("POST", Common.BASE_URL + "/login");
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
        xhr.send("username=user2&password=user2_secret");
}
