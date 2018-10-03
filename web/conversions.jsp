<%--
  Created by IntelliJ IDEA.
  User: manan
  Date: 20/9/18
  Time: 11:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%if (request.getSession().getAttribute("user")==null)
request.getRequestDispatcher("index.jsp").forward(request, response);%>
<jsp:include page="importLinks.jsp">
    <jsp:param name="title" value="Conversions"/>
</jsp:include>
<jsp:include page="header.jsp">
    <jsp:param name="type" value="nonindex"/>
</jsp:include>
<script src="https://unpkg.com/@pusher/chatkit/dist/web/chatkit.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.0.12/handlebars.js"></script>
<script type="text/javascript">
    const tokenProvider = new Chatkit.TokenProvider({
        url: "auth.php"

    });
    const chatManager = new Chatkit.ChatManager({
        instanceLocator: "v1:us1:0ee28cf9-46f6-49ca-ae03-5f06d486aee6",
        userId: "ru",
        tokenProvider: tokenProvider
    });



    chatManager.connect().then(currentUser => {

        for(var i=0;i<(currentUser.rooms).length;i++)
        {
            console.log('1');
            if(!(currentUser.id===currentUser.rooms[i].users[0].id))
            {
                var user1=currentUser.rooms[i].users[0].id;
            }else if(!(currentUser.id===currentUser.rooms[i].users[1].id))
            {
                var user1=currentUser.rooms[i].users[1].id;
            }

            var template = $('#chatuser').html();
            var templateScript = Handlebars.compile(template);
            var data = 	{
                userid:user1
            }


            $('#chatlist').append( templateScript(data) );
        }

        // if(currentUser.rooms[i].users[0].id==ouid || currentUser.rooms[i].users[1].id==ouid){
        //   var roomid1=currentUser.rooms[i].id;
        //   console.log(currentUser.rooms[i])
        // }
    });
</script>
<jsp:include page="footer.jsp"/>
