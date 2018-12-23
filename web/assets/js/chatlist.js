chatManager.connect().then(currentUser => {
    let sequence = Promise.resolve();
    if(!currentUser.rooms){
        $("#chatlistmain").append("<li class='nonot'><strong>No messages</strong></li>");
    }
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
                if(true){
                }

            }).catch(err => {
                console.log(`Error fetching messages: ${err}`)
            });
        });
    });
});
