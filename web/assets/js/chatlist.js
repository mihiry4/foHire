const chatManager = new Chatkit.ChatManager({
    instanceLocator: "v1:us1:0ee28cf9-46f6-49ca-ae03-5f06d486aee6",
    userId: "ru",
    tokenProvider: new Chatkit.TokenProvider({url: "auth.php"})
});


chatManager.connect().then(currentUser => {
    let sequence = Promise.resolve();
    currentUser.rooms.forEach(function (room) {
        const roomID = room.id;
        let user1, username;
        if (currentUser.id !== room.users[0].id){
            user1 = room.users[0].id;
            username = room.users[0].name;
        } else {
            user1 = room.users[1].id;
            username = room.users[1].name;
        }
        let data = {};
        data.userid = user1;
        data.username = username;
        sequence = sequence.then(function () {
            currentUser.fetchMessages({
                roomId: roomID,
                direction: 'older',
                limit: 1
            }).then(messages => {
                const m = messages[0].text;
                const t = messages[0].createdAt;
                data.message = m;
                data.time = t;
                const template = $('#chatlist').html();
                const templateScript = Handlebars.compile(template);
                $('#chatlistmain').append(templateScript(data));
            }).catch(err => {
                console.log(`Error fetching messages: ${err}`)
            });
        });
    });
});
