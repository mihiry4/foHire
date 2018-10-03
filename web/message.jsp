<%@ page import="Objects.Const" %><%--
  Created by IntelliJ IDEA.
  User: Manan
  Date: 11-09-2018
  Time: 08:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%int room_open = (int) request.getAttribute("room_open");%>    <%--Todo: add room_open to Front end--%>
<html lang=en>
<head>
    <meta charset=utf-8>
    <title>Chatkit demo</title>
</head>
<body>
<ul id="message-list"></ul>
<form id="message-form">
    <input type='text' id='message-text'>
    <input type="submit">
</form>

<script src="https://unpkg.com/@pusher/chatkit/dist/web/chatkit.js"></script>
<script>
    const tokenProvider = new Chatkit.TokenProvider({
        url: "Auth_pusher"
    });
    const chatManager = new Chatkit.ChatManager({
        instanceLocator: "<%=Const.Pusher_instanceLocator%>",
        userId: "ru",
        tokenProvider: tokenProvider
    });

    chatManager
        .connect()
        .then(currentUser => {
            currentUser.subscribeToRoom({
                roomId: currentUser.rooms[0].id,
                hooks: {
                    onNewMessage: message => {

                        const ul = document.getElementById("message-list");
                        const li = document.createElement("li");
                        var senid = message.senderId;
                        var msg = message.text;
                        li.appendChild(
                            document.createTextNode(senid + ':' + msg)
                        );
                        ul.appendChild(li);
                    }
                }
            });

            const form = document.getElementById("message-form");
            form.addEventListener("submit", e => {
                e.preventDefault();
                const input = document.getElementById("message-text");
                currentUser.sendMessage({
                    text: input.value,
                    roomId: currentUser.rooms[0].id
                });
                input.value = "";
            });
        })
        .catch(error => {
            console.error("error:", error);
        });
</script>
</body>
</html>
