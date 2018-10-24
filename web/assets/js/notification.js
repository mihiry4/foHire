chatManager.connect().then(currentUser => {
    var now=new Date();

    for(var i=0;i<(currentUser.rooms).length;i++)
    {

            var roomid1=currentUser.rooms[i].id;
            //console.log(currentUser.rooms[i])

        currentUser.subscribeToRoom({
            roomId: roomid1,
            hooks: {
                onNewMessage: message => {
                    var date = new Date(message.createdAt);

                    //console.log(date.getTime());
                if(date.getTime() > now.getTime()){
                    console.log(message.text);
                    $('#indic').append('<p style="color:#ee1212;font-size:20px;">*</p>');
                }


                }

            }

        })

        }
    });

