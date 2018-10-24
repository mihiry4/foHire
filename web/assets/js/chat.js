var ouid = window.location.href.split('?').pop();
var spinner = document.querySelector('.loader');
//spinner.classList.add('spin');

      chatManager.connect().then(currentUser => {
        for(var i=0;i<(currentUser.rooms).length;i++)
          {
              if (currentUser.rooms[i].users[0].id === ouid || currentUser.rooms[i].users[1].id === ouid) {
              var roomid1=currentUser.rooms[i].id;
              //console.log(currentUser.rooms[i])
            }
          }
          currentUser.subscribeToRoom({
            roomId: roomid1,
            hooks: {
              onNewMessage: message => {
                
                const s=document.getElementById("chat");
                
                var date = new Date(message.createdAt);
                  var time1 = (date.getHours() < 10 ? '0' : '') + date.getHours() + ':' + (date.getMinutes() < 10 ? '0' : '') + date.getMinutes();
                  var date1= date.getDate()+'/'+(date.getMonth()+1);
                  var day1=date.getDay();
                  var a=['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
                  var data = {
                    time: time1,
                    user: message.senderId,
                    message:message.text,
                    msgdate:date1,
                    msgday:a[day1]};
                  if (message.senderId === currentUser.id)
                {
                    let template = $('#messaget').html();
                    let templateScript = Handlebars.compile(template);
                  $('#chathistory').append( templateScript(data) ); 
                  s.scrollTop = s.scrollHeight;

                }
                else
                {
                    let template = $('#messager').html();
                    let templateScript = Handlebars.compile(template);
                  $('#chathistory').append( templateScript(data) ); 
                  s.scrollTop = s.scrollHeight;
                }
                  spinner.classList.remove('spin');
                  spinner.classList.remove('loader');


              }

            }

          });


          const form = document.getElementById("message-form");
          form.addEventListener("submit", e => {
            e.preventDefault();
            const input = document.getElementById("message-text");
            currentUser.sendMessage({
              text: input.value,
              roomId: roomid1
            });
            input.value = "";
          });
        })
        .catch(error => {
          console.error("error:", error);
        });


// .catch(function(error){
//     if ( $('#chathistory').children().length < 1 ) {
//         $('#chathistory').append(" <li style='color:gray'>No messages</li>");
//     }
// })