<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <!--[if IE]>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <![endif]-->
    <title>CHAT</title>
    <!-- BOOTSTRAP CORE STYLE CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.css" rel="stylesheet"/>

    <!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>-->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>


    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.2 -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="${pageContext.request.contextPath}/resources/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
    <script src="<c:url value="/resources/scripts/sockjs-0.3.4.min.js"/>"></script>
<script src="<c:url value="/resources/scripts/stomp.js"/>"></script>
    <style>
        body {
            font-size: 12px;
        }

        .top-buffer-10 {
            margin-top: 10px;
        }

        .top-buffer {
            margin-top: 20px;
        }

        .bottom-buffer {
            margin-bottom: 20px;
        }

        .no-padding {
            padding: 0px;
        }

        .top-padding-10 {
            padding-top: 10px;
            margin: auto;
        }

        .top-bottom-nopadding {
            padding-top: 0px;
            padding-bottom: 0px;
        }

        .fill {
            border-top: 1px solid #bce8f1;
        }

        .group-chat {
            color: #fff;
            text-shadow: 0 2px #008080;
        }
        .private-room {
            color: #fff;
            text-shadow: 0 2px #f7a746;
        }

        .content-box-title {
            text-align: center;
        }

        .tab-height {
            height: 315px;
        }

        .panel-footer ul li {
            /*height: 24px;*/
            border-right: 1px solid #c4c3c1;
            float: left;
            background: linear-gradient(to bottom, #307ecc 5%, #307ecc 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='@success-color', endColorstr='darken(@success-color, 5%)', GradientType=0);
            background-color: #307ecc;
            color: #fff;
            border: 1px solid;
        }

        .media {
            margin-top: 0px;
            height: 40px;
        }

        .media-body {
            padding: 5px;
        }

        #chat-left {
            border-right: 1px solid #bce8f1;
            height: auto;
        }

        #chat-left ul li.media:hover{
            background-color: #307ecc;
            color: #fff;
            text-decoration: none;
        }
        #chat-left ul li.media:hover a.dropdown-toggle{
            color: #fff;
        }
        .dropdown-menu>li>a:hover {
            color: #777;
            text-decoration: none;
        }
       

        #chat-left > ul > li > .media-sub-ul > li:hover, #chat-left > ul > li > .media-sub-ul > li:hover > a ,#chat-left > ul > li:hover > .media-sub-ul > li ,
        #chat-left > ul > li:hover > .media-sub-ul > li > a{
            background-color: #fff !important;
            color: #fff;
            text-decoration: none;
        }
         ##chat-left ul.dropdown-menu>li:hover{
            background-color: #fff;
            color: #777;
         }
        #chat-left ul.dropdown-menu>li:hover a{
            background-color: #fff;
            color: #777;
        }
        #chat-right,#content {
            height: auto;
        }

        .name-list {
            overflow-x: auto;
            height: auto;
            min-height: 300px;
        }
        .chat-log{
            overflow-x: auto;
            height: auto;
            max-height: 90px;
            height: 90px;
            padding: 5px;
        }

        .media-object {
            max-height: 27px;
            box-shadow: 2px 2px 2px #888888;

        }

        ::-webkit-scrollbar {
            -webkit-appearance: none;
            width: 12px;
            _background-color: #f0f0f0;
        }

        ::-webkit-scrollbar-thumb {
            border-radius: 12px;
            border: 4px solid rgba(255, 255, 255, 0);
            background-clip: content-box;
            _background-color: #bfbfbf;
            background-color: #A0A0A0;
        }

        ::-webkit-scrollbar-corner {
            background-color: #e6e6e6;
        }

        /* .online-green {
            border: 2px solid green;
        }

        .online-red {
            border: 2px solid red;
        }

        .online-orange {
            border: 2px solid orange;
        } */
        .online-green {
	/* border: 2px solid green; */
	width: 10px;
	height: 10px;
	background: #008000 none repeat scroll 0% 0%;
	position: relative;
	left: 22px;
	top: -8px;
	border: 1px solid #FFF;
}

}
.online-red{
	/* border: 2px solid red; */
	width: 10px;
	height: 10px;
	background: #F00 none repeat scroll 0% 0%;
	position: relative;
	left: 22px;
	top: -8px;
	border: 1px solid #FFF;
}

.online-orange {
	/* border: 2px solid orange; */
	width: 10px;
	height: 10px;
	background: #FFA500 none repeat scroll 0% 0%;
	position: relative;
	left: 22px;
	top: -8px;
	border: 1px solid #FFF;
}

        .tab-close {
            position: absolute;
            right: 4px;
            top: 0px;
            font-size: 14px;
        }

        .tab-content {
            height: 100%;
            min-height: 330px;
        }
        .add_new_group_chat{
            position: absolute;
            z-index: 1;
            top: 9px;
            left: 2px;
            color: #726E73;
            font-weight: bold;
            font-size: 12px;
        }
        .invite_friend{
            padding-top: 5px;
            position: absolute;
            z-index: 1;
            background: #fff;
        }
        .tooltip-inner {
            white-space:pre;
            max-width: none;
        }
        .my-chat{
            padding: 0px;
        }
        #example2 .ui-tabs-paging-prev{
            width: 15px;
            height: 32px;
        }
        #example2 .ui-tabs-paging-prev a {
            padding: 0px;
            margin-top: 5px;
        }
        #example2 .ui-tabs-paging-next{
            width: 10px;
            float: right;
            height: 32px;
        }
        #example2 .ui-tabs-paging-next a {
            padding: 0px;
            margin-top: 5px;
            margin-left: 2px;
        }
        .tabs{
            height: 35px;
            width: 361px;
            background: white;
            border: 0px;
        }
        .form-search{
            position: relative;
            z-index: 2;
            float: left;
            width: 100%;
            margin-bottom: 0;
            border-radius: 0 !important;
            box-shadow: none;
            border-color: #d2d6de;
        }
    </style>
    <script id="demo" type="text/javascript">
        $(document).ready(function() {


        	 $.ajax({
            	 url: "groupChatInvitation",
            	  success: function(result){
                   // alert(result);
                    
                 }
                 });

            $('.tab-close').click(function(){
                var tab_val = $(this).closest('li').find('a').attr('href');
                if($(this).closest('li').prev().find('a').html() != null) {
                    $(this).closest('li').prev().addClass('active');
                    $(tab_val).prev().addClass("active");
                    $('.invite_friend').removeClass("show");
                    $('.invite_friend').addClass("hide");
                } else {
                    $(this).closest('li').next().addClass('active');
                    $(tab_val).next().addClass("active");
                    $('.invite_friend').removeClass("show");
                    $('.invite_friend').addClass("hide");
                }

                $($(this).closest('li')).remove();
                $( tab_val ).remove();

            });
            // $('.test').bind('click',function(){
            //     console.log('Test222');
            // });
            $('.test').on('click',function(e){
                e.preventDefault();
            //$('.add_new_group_chat').click(function(){
                //$('.invite_friend').removeClass("hide");
               // $('.invite_friend').addClass("show");
            });
//            $('.add_new_group_chat').click(function(){
//                alert("Test");
//                $('.invite_friend').removeClass("hide");
//                $('.invite_friend').addClass("show");
//            });

            //$('.example').tooltip();
            $('[rel="tooltip"]').tooltip();

        });

        $(document).ready(function() {
            //$('#tabs').tabs();
            //jQuery('#example2').tabs({ cache: true });
            //jQuery('#example2').tabs('paging', { cycle: true, nextButton: '&gt;', prevButton: '&lt;'});

            $('.open-tab').click(function() {
                var link = $(this).attr('href');
                $('#tabs a[href="'+link+'"]').tab('show') // Select tab by name
            });
        });
    </script>
</head>
<body style="font-family:Verdana">
<div class="container" >
    <div class="row ">
        <div >
            <div class="panel panel-info">
                <div class="panel-heading">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <span data-toggle="modal" data-target="#myModal">Chat</span>
                </div>

                <div class="panel-body top-bottom-nopadding">
                    <div class="row">
                        <div id="chat-left" class="col-sm-4 no-padding">
                            <div id="search" class="top-buffer-10">
                                <div class="input-group" style="padding: 2px;">
                                    <input type="text" class="form-control" placeholder="Enter Name" id="search_user">
                                </div>
                            </div>

                            <div class="name-list">

                                <div class="online-chat-list" >
                                    <ul class="media-list">
                                   <%--  <li class="media hvr-fade">
                                        <div class="media-body">
                                            <div class="media">
                                                <a class="pull-left" href="#">
                                                    <img class="media-object img-circle online-green" src="${pageContext.request.contextPath}/resources/img/user.png">
                                                    <!--<div class="online-green"></div>-->
                                                </a>

                                                <div class="media-body">
                                                    <a href="#one" class="open-tab dropdown-toggle" id="my-text-link1" data-toggle="dropdown">User Name</a>
                                                    <small class="text-muted"></small>
                                                        <ul class="dropdown-menu media-sub-ul" role="menu" aria-labelledby="menu1" style="top: 75px;left:20px;">
                                                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Chat</a></li>
                                                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Group Chat</a></li>
                                                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Edit</a></li>
                                                          <li role="presentation"><a role="menuitem" tabindex="-1" href="#">New</a></li>
                                                        </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </li> --%>
                                </ul>
                                </div>
                                
                                  <div> <input type="button" value="Group Chat" id="group-chat"></div>
                                  

                               <!--   <div id="tab-tools1">
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="addPanel()"></a>
                                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'" onclick="removePanel(this)"></a>
                                </div>     -->

                            </div>
                            <div class="chat-log">
                                Group1 Left at 2 P.M
                                Group2 Join at 3 P.M
                                Group1 Left at 2 P.M
                                Group2 Join at 3 P.M
                                Group1 Left at 2 P.M
                                Group2 Join at 3 P.M
                                Group1 Left at 2 P.M
                                Group2 Join at 3 P.M
                                Group1 Left at 2 P.M
                                Group2 Join at 3 P.M
                            </div>
                        </div>
                        

                        <div id="chat-right" class="col-sm-8 no-padding direct-chat-warning ">
                            
                            <div id="content" class="top-buffer-10" style="height: 388px;">
                                   <div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="height:382px;">
                                    </div>
                                    
                                    <script type="text/javascript">
                                        var index = 0;
                                        function addPanel(title){
                                        	if ($('#tt').tabs('exists', title)){
                                                $('#tt').tabs('select', title);
                                            } else{
                                            index++;
                                            $('#tt').tabs('add',{
                                                //title: '<button class="close add_new_group_chat" ><span aria-hidden="true">+</span></button>Tab'+index,
                                                title : title,
                                                content: '<div><div class="input-group invite_friend hide" style="width: 90%;top: 40px;"><input type="text" class="form-control" placeholder="Add friends to this chat"><span class="input-group-btn"><button class="btn btn-info" type="button">Done</button></span></div> <div class="direct-chat-messages" style="padding: 0;"><ul class="my-chat"><li class="message"></li></ul> </div></div>',
                                                closable: true
                                            });
                                            }
                                        }
                                        function removePanel(){
                                            var tab = $('#tt').tabs('getSelected');
                                            if (tab){
                                                var index = $('#tt').tabs('getTabIndex', tab);
                                                $('#tt').tabs('close', index);
                                            }
                                        }
                                    </script>
                            </div>
                            <div class="col-sm-12" style="height: 40px; padding: 0px 5px 0px 5px; bottom: 0px !important;">
                                <div class="input-group single-chat-message">
                                    <input type="text" id="message_body" class="form-control" placeholder="Enter Message">
                                        <span class="input-group-btn">
                                            <button class="btn btn-info" type="button" id="chat_submit">Send</button>
                                        </span>
                                </div>
                                <div class="input-group group-chat-message hide">
                                        <input type="text" id="group_message_body" class="form-control" placeholder="Enter Group Chat Message">
                                            <span class="input-group-btn">
                                                <button class="btn btn-info" type="button" id="group_chat_submit">Send</button>
                                            </span>
                                    </div>
                            </div>
                        </div>
                        <!-- container -->
                    </div>
                </div>


                <div class="panel-footer no-padding" style="height: 20px;">
                    <ul class="list-unstyled">
                        <!--<li class="col-sm-4 pull-left text-center"></li>
                        <li class="col-sm-3 pull-left text-center">Group Chat</li>-->
                        <!--<li class="col-sm-2 pull-left text-center">Chat</li>-->
                        <!--<li class="col-sm-3 pull-left text-center">Private Room</li>-->

                        <!--<div class="input-group">-->
                        <!--<input class="form-control" id="message_body_reply" name="message[body]" placeholder="reply..." type="text">-->
                        <!--<span class="input-group-btn">-->
                        <!--<button class="btn btn-success" type="button" id="chat_reply_submit">sender</button>-->
                        <!--</span>-->
                        <!--</div>-->


                    </ul>

                </div>

            </div>
        </div>
    </div>
</div>

 <!-- Modal -->
  <div class="modal " id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Edit</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default small">Save</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>







<script src="${pageContext.request.contextPath}/resources/js/jQuery-2.1.3.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js" type="text/javascript"></script>
<!-- / jquery mobile (for touch events) -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.mobile.custom.min.js" type="text/javascript"></script>
<!-- / jquery migrate (for compatibility with new jquery) [required] -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-migrate.min.js" type="text/javascript"></script>
<!-- / jquery ui -->
<!-- / jQuery UI Touch Punch -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.js" type="text/javascript"></script>
<!-- / modernizr -->
<script src="${pageContext.request.contextPath}/resources/js/theme.js" type="text/javascript"></script>
<!-- / demo file [not required!] -->
<!-- / START - page related files and scripts [optional] -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.slimscroll.min.js" type="text/javascript"></script>

 <c:url value="http://10.5.3.148:8080/XmppChat/simplemessages" var="socketDest" />
  <script type="text/javascript">
            /***********************************************/
            /* PLEASE READ UP ON STOMP AND SOCKJS          */
            /* 1) http://jmesnil.net/stomp-websocket/doc/  */
            /* 2) https://github.com/sockjs/sockjs-client  */
            /***********************************************/

            //Declare a stompclient which will connect to the server
            var stompClient = null;

            /************************************************************************** 
            /*  JQUERY WAY OF BEING UNOBTRUSIVE AND ADDING EVENT HANDLERS TO WIDGETS, 
            /*  THUS KEEPING HTML AND JAVASCRIPT SEPARATE 
            /*************************************************************************/
            // Runs this code only when the DOM (all elements) are ready
            $(document).ready(function() {
                // On page load the text input field 'MESSAGE', 'DISCONNECT' and 'SEND' buttons 
                // should all be disabled as user has not clickedd 'CONNECT' button yet.
                 connect();
                $("#disconnect").prop('disabled', true);
                $("#txtSendMessage").prop('disabled', true);
                $("#sendMessage").prop('disabled', true);

                //Also all text in server message should be empty
                $("#txtSendMessage").val("");
                //Remove any server responses from previous interactions
                $("#response").empty();
                //Hide the validation and info alerts on page load
                $(".alert").hide();
                // Event handler: Connect button
                //Commented Connect
               /*  $("#connect").on("click", function(e) {
                    // If alert is visible, hide it
                    $("#formAlert").slideUp(400);
                    connect();
                }); */

                // Event handler: Disconnect button 
                $("#disconnect").on("click", function(e) {
                    // If alert is visible, hide it
                    $("#formAlert").slideUp(400);
                    disconnect();
                });
                // Event handler: X button on top right of info alert.
                // Clicking the X button on top right will dismiss it from the screen and hide it
                $(".alert").find(".close").on("click", function(e) {
                    // Find all elements with the "alert" class, get all descendant elements 
                    // with the class "close", and bind a "click" event handler

                    // Don't allow the click to bubble up the DOM
                    e.stopPropagation();

                    // Don't let any default functionality occur (in case it's a link)
                    e.preventDefault();

                    // Hide this specific Alert
                    $(this).closest(".alert").slideUp(400);

                    // Focus on the Send Message textfield
                    $("#txtSendMessage").select();
                    $("#txtSendMessage").focus();
                });

                // Event handler: Send button
               
            });

            //Function sets the state of the Connect and Disconnect buttons
            function setConnected(connected) {
                //Since we are using bootstrap, this is how you disable buttons 
                // and input widgets
                $("#connect").prop('disabled', connected);
                $("#disconnect").prop('disabled', !connected);
                $("#sendMessage").prop('disabled', !connected);
                $("#txtSendMessage").prop('disabled', !connected);
            }

            function renderUser(frame) {
                var prices = JSON.parse(frame.body);
               
                var items =[];
                for(var i in prices) {
                  var val = prices[i];
                 
                          items.push(

                		  '<li class="media hvr-fade">'+
                          '<div class="media-body">'+
                              '<div class="media">'+
                                  '<a class="pull-left" href="#">'+
                                      '<img class="media-object" src="${pageContext.request.contextPath}/resources/img/user.png">'+
                                      '<div class='+val.statusMsg+'></div>'+
                                  '</a>'+
                              '<div class="media-body">'+
                              '<a href="#'+val.name+'_tab" class="open-tab dropdown-toggle" id="my-text-link1" data-toggle="dropdown" >'+val.name+'</a>'+
                              '<small class="text-muted"></small>'+
                                  '<ul class="dropdown-menu media-sub-ul" role="menu" aria-labelledby="menu1" style="top: 75px;left:20px;">'+
                                    '<li role="presentation"><a role="menuitem" tabindex="-1" href="#'+val.name+'" onclick="addTab(\''+val.name+'\')">Chat</a></li>'+
                                    '<li role="presentation"><a role="menuitem" tabindex="-1" href="#">Group Chat</a></li>'+
                                    '<li role="presentation"><a role="menuitem" tabindex="-1" href="#">Edit</a></li>'+
                                    '<li role="presentation"><a role="menuitem" tabindex="-1" href="#">New</a></li>'+
                                  '</ul>'+
                          '</div>'+
                          '</div>'+
                          '</div>'+
                      '</li>');
                }
                $('.media-list').empty();
                $('.media-list').append(items);
                
              }

            function addTab(name){
					 $(".single-chat-message").removeClass('hide');
		             $(".group-chat-message").addClass('hide');
		             addPanel(name);
                }
            
            // Function to connect the web client to the websocket server
            function connect() {
                //Remove any server responses from previous interactions
                $("#response").empty();
                //Also all text in server message input field should be empty
                $("#txtSendMessage").val("");
                $("#txtSendMessage").focus();
                $("#txtSendMessage").select();
                // Register a websocket endpoint using SockJS and stomp.js
                // Refer to Java class Refer to Java class 
                // WebSocketConfig.java#registerStompEndpoints(StompEndpointRegistry registry)
                var socket = new SockJS('${socketDest}');
                stompClient = Stomp.over(socket);
                // Now that a stomp client is defined, its time to open a connection
                // 1) First we connect to the websocket server
                // Notice that we dont pass in username and password as Spring Security
                // has already provided the server with the Principal object containing user credentials
                // 2) The last argument is a callback function which is called when connection succeeds
                stompClient.connect('', '', function(frame) {
                    //set the connect and disconnect button state. (disable connect button)
                    setConnected(true);
                    // In production code remove the next line
                    console.log("Connected: " + frame);
                    console.log("connected, session id: " + stompClient);
                    //Lets show a connection success message
                  //  showServerBroadcast("Connection established: " + frame, false);
                    // Now subscribe to a topic of interest.
                    
                     stompClient.subscribe("/topic/<%=session.getAttribute("userName")%>/displayusers", function(message) {
                         //alert(message);
                    	 renderUser(message);
          			});

                     stompClient.subscribe("/user/<%=session.getAttribute("userName")%>/groupInvite", function(message) {
                         //alert(message);
                    	 alert(message);
                    	 groupInvitation(message);
          			});
           			
                   // stompClient.subscribe("/topic/displayusers", renderUser);
                       // $('#panel').append(servermessage);
                       // });
                  var message = "Hai";
                  stompClient.send("/app/displayusers",{}, JSON.stringify({
                      'message' : message
                  })); 
                         
                   
                    
                    
                    // Refer to Java class WebsocketBroadcastController.java#processMessageFromClient(SimpleMessage message)
                    // WebsocketBroadcastController is waiting for connections. Upon successful connection, it subscribes to
                    // the "/topic/simplemessagesresponse" destination where the server will echo the messages.
                    // When a broadcast message is received by the client on that destination, it will be shown by appending
                    // a paragraph to the DOM in the client browser.
                    stompClient.subscribe("/user/<%=session.getAttribute("userName")%>/queue/simplemessagesresponse", function(servermessage) {//Callback when server responds
                    	Chat_Sender(JSON.parse(servermessage.body).messageContent);
                        //Server responded so hide the info alert
                        $("#formInfoAlert").slideUp(400);
                        //Also all text in server message input field should be empty
                        $("#txtSendMessage").val("");
                        $("#txtSendMessage").focus();
                        $("#txtSendMessage").select();
                    });

                  

                    stompClient.subscribe("/topic/statusmessage", function(message) {
                        alert("status");
                    	//Chat_status(JSON.parse(message.body).messageContent);
                    });

                   

                    stompClient.subscribe("/user/<%=session.getAttribute("userName")%>/topic/groupmessagesresponse", function(servermessage) {//Callback when server responds
                       // alert(JSON.parse(servermessage.body));
                        //alert(JSON.parse(JSON.stringify(servermessage.body)));
                    	group_chat_sender(JSON.parse(servermessage.body));
                        //Server responded so hide the info alert
                    });
                });
            }

            // Function to disconnect the web client to the websocket server
            function disconnect() {
                //First hide any alerts
                $("#formAlert").slideUp(400);
                $("#formInfoAlert").slideUp(400);
                // Disconnect the stompClient
                stompClient.disconnect();
                // Set the connect and disconnect button states
                setConnected(false);
                // In production remove the next line
                console.log("Disconnected");
                showServerBroadcast("WebSocket connection is now terminated!", true);
            }

            // Function to send the message typed in by the user to the "/app/simplemessages" destination on the server.
            // WebsocketBroadcastController will receive this message and broadcast the results after 
            // an artificially introduced delay.
           /*  function sendMessageToServer(messageForServer) {
                //Show on the browser page that a message is being sent
                showServerBroadcast("Your message '" + messageForServer + "' is being sent to the server.", true);
                // The message for the server must be in JSON format. Also refer SimpleMessage.java POJO.
                stompClient.send("/app/simplemessages", {}, JSON.stringify({
                    'message' : messageForServer
                }));
            }
 */
            /**
             * Function to show the server response on the web page
             * @param servermessage - text to be shown on webpage
             * @param localMessage - boolean, if true then it means its a 
             *                       client side javascript generated message.
             */
            function showServerBroadcast(servermessage, localMessage) {
                // Server surrounds the user sent message with <b> and </b> 
                // as &ltb&gt;message%lt;/b&gt;
                // Use Jquery to decode the HTML and show it as <b>message</b>
                var decoded = $("<div/>").html(servermessage).text();

                var tmp = "";
                var serverResponse = document.getElementById("response");
                var p = document.createElement('p');
                p.style.wordWrap = 'break-word';

                if (localMessage) {
                    p.style.color = '#006600';
                    tmp = "<span class='glyphicon glyphicon-dashboard'></span> " + decoded + " (Browser time:" + getCurrentDateTime() + ")";
                } else {
                    p.style.color = '#8A0808';
                    tmp = "<span class='glyphicon glyphicon-arrow-right'></span> " + decoded;
                }
                //Assigning the decoded HTML to the <p> element
                p.innerHTML = tmp;
               serverResponse.appendChild(p);
            }

            /**
             * Utility function to return the date time in simple format
             * like Tue Jan 07 2014 @ 11:47:24 AM
             */
            function getCurrentDateTime() {
                var date = new Date();
                var n = date.toDateString();
                var time = date.toLocaleTimeString();
                return n + " @ " + time;
            }
        </script>

<script>
/* function addTab(e,index,userName){
	  alert(e);
	  
	   //var count = ++i;
	  // var name=userName.split("@");
	   /* if (!$("."+e)[0]){
		   
	   $('#tabs').append('<li id=tabNo'+count+'><a href="#'+e+'" data-toggle="tab">'+userName+'</a><button type="button" class="close tab-close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button></li>');
	   $('#my-tab-content').append('<div class="tab-pane '+e+' " id='+e+'><div class="box-body chat chat-fixed" style="padding: 0px; height: auto;"><div class="scrollable" data-scrollable-height="350" data-scrollable-start="bottom"> <div class="direct-chat-messages"><ul class="my-chat"><li class="message"></li></ul><input type="hidden" id="user'+count+'" value="'+userName+'" </div>');
	   $('#tabs a[href="#'+e+'"]').show();  
	  
      } 
      addPanel(e);
	     // alert( $('#tabs a[href="#'+e+'"]'));
	   $('#tabs a[href="#'+e+'"]').tab('show');   
   } */

   function groupInvitation(message){
	   var groupInv = JSON.parse(message.body);
	   alert(groupInv.messageContent);
	   var r = confirm(groupInv.messageContent);
	    if (r == true) {
	        console.log("Invitation accepted");
	        $.ajax({
           	 url: "joinGroup",
           	  success: function(result){
                  // alert(result);
                   
                }
                });
	    } else {
	    	$.ajax({
	           	 url: "decline",
	           	  success: function(result){
	                  // alert(result);
	                   
	                }
	                });
	       console.log("Invitation Rejected");
	    }
	   
	   }
   
    function Chat_reply(e) {
	   var activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
        var chat, date, li, message, reply, scrollable, scroll_height, sender;
        chat = $(this).parents(".chat");
        li = chat.find("li.message");
        message = $("#message_body").val();
        $("#message_body").val("");
        var datetime =  getCurrentDateTime();
        $("#message_body").val("");
        if (message.length !== 0) {
            my_reply = '<li class="message check"><div class="direct-chat-msg"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-left"><%=session.getAttribute("userName")%></span><span class="direct-chat-timestamp pull-right">'+datetime+'</span>' +
                    '</div><img class="direct-chat-img" src="${pageContext.request.contextPath}/resources/img/user1-128x128.jpg" alt="message user image" />' +
                    '<div class="direct-chat-text"><div class="text_width">' + message + '</div></div></div></li>';
            $(activeClass).find(".message").last().parent().append(my_reply);
            scrollable = li.parents(".scrollable");
            scroll_height = $(".scrollable").height();
          //  $(".scrollable").animate({scrollTop: $('.scrollable')[0].scrollHeight}, 500);
        }
       /*  if (message.length !== 0) {
            my_reply = '<li class="message check"><div class="direct-chat-msg"><div class="direct-chat-info clearfix">' +
                    '<span class="direct-chat-name pull-left">Alexander Pierce</span><span class="direct-chat-timestamp pull-right">23 Jan 2:00 pm </span>' +
                    '</div><img class="direct-chat-img" src="${pageContext.request.contextPath}/resources/img/user1-128x128.jpg" alt="message user image" />' +
                    '<div class="direct-chat-text"><div class="text_width">' + message + '</div></div></div></li>';
            $('.my-chat').find(".message").last().parent().append(my_reply);
            scrollable = li.parents(".scrollable");
            scroll_height = $(".scrollable").height();
            $(".scrollable").animate({scrollTop: $('.scrollable')[0].scrollHeight}, 500);
        } */
    }
    function Chat_Sender(e) {
        var datetime = getCurrentDateTime();
       var chat, date, li, message, reply, scrollable, scroll_height, sender;
       chat = $(this).parents(".chat");
       message_reply = $("#message_body_reply").val();
       $("#message_body_reply").val("");
       var content = e.split('##');
       var user = content[0];
     //  alert(user);
       var name = user.split('@');
       var text = content[1];
       var activeClass = "";
       var sessionUser = "<%=session.getAttribute("userName")%>";
       if(!(sessionUser==name[0])){
       if($('#tt').tabs('exists', name[0])){
           $('#tt').tabs('select', name[0]);
    	    activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
       }else{
    	   index++;
           $('#tt').tabs('add',{
              	title : name[0],
               content: '<div><div class="input-group invite_friend hide" style="width: 90%;top: 40px;"><input type="text" class="form-control" placeholder="Add friends to this chat"><span class="input-group-btn"><button class="btn btn-info" type="button">Done</button></span></div><div class="direct-chat-messages" style="padding: 0;"><ul class="my-chat"><li class="message"></li></ul> </div></div>',
               closable: true
           });
       	activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
           }
      // if (message_reply.length !== 0) {
           sender = '<li class="message "><div class="direct-chat-msg right"><div class="direct-chat-info clearfix">' +
                   '<span class="direct-chat-name pull-right">'+name[0]+'</span><span class="direct-chat-timestamp pull-left">'+datetime+'</span>'+
                   '</div><img class="direct-chat-img" src="${pageContext.request.contextPath}/resources/img/user3-128x128.jpg" alt="message user image" />' +
                   '<div class="direct-chat-text"><div class="text_width">' + text + '</div></div></div></li>';
           $(activeClass).find(".message").last().parent().append(sender);
           li = chat.find("li.message");
           scrollable = li.parents(".scrollable");
           scroll_height = $(".scrollable").height();
           $(".scrollable").animate({scrollTop: $('.scrollable')[0].scrollHeight}, 500);
      // }
       }
    }



    function Chat_status(e) {
       var chat, date, li, message, reply, scrollable, scroll_height, sender;
       chat = $(this).parents(".chat");
       message_reply = $("#message_body_reply").val();
       $("#message_body_reply").val("");
       var content = e.split('##');
       var user = content[0];
     //  alert(user);
       var name = e.name;
       var text = e.content;
       console.log("e typing status");
       alert(name);
       alert(text);
       var activeClass = "";
       var sessionUser = "<%=session.getAttribute("userName")%>";
       if(!(sessionUser==name[0])){

       }
      
    }

    function group_chat_reply(e) {
 	   var activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
         var chat, date, li, message, reply, scrollable, scroll_height, sender;
         chat = $(this).parents(".chat");
         li = chat.find("li.message");
         message = $("#group_message_body").val();
         $("#group_message_body").val("");
         var datetime =  getCurrentDateTime();
         $("#group_message_body").val("");
         if (message.length !== 0) {
             my_reply = '<li class="message check"><div class="direct-chat-msg"><div class="direct-chat-info clearfix"><span class="direct-chat-name pull-left"><%=session.getAttribute("userName")%></span><span class="direct-chat-timestamp pull-right">'+datetime+'</span>' +
                     '</div><img class="direct-chat-img" src="${pageContext.request.contextPath}/resources/img/user1-128x128.jpg" alt="message user image" />' +
                     '<div class="direct-chat-text"><div class="text_width">' + message + '</div></div></div></li>';
             $(activeClass).find(".message").last().parent().append(my_reply);
             scrollable = li.parents(".scrollable");
             scroll_height = $(".scrollable").height();
         }
     }



    
    function group_chat_sender(e) {
        var datetime = getCurrentDateTime();
       // alert(e);
       var chat, date, li, message, reply, scrollable, scroll_height, sender;
       chat = $(this).parents(".chat");
       //var content = e.message;
       //var user = e.user;
      // alert(user);
       var name = e.user;
       var text = e.message;
       var activeClass = "";
       var sessionUser = "<%=session.getAttribute("userName")%>";
       alert("name:"+name);
       alert("grou:"+ e.groupName);
       alert(sessionUser);
       if(!(sessionUser==name))
           {
       if($('#tt').tabs('exists', e.groupName)){
           $('#tt').tabs('select', e.groupName);
    	    activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
       }else{
    	   index++;
           $('#tt').tabs('add',{
              	title : e.groupName,
               content: '<div><div class="input-group invite_friend hide" style="width: 90%;top: 40px;"><input type="text" class="form-control" placeholder="Add friends to this chat"><span class="input-group-btn"><button class="btn btn-info" type="button">Done</button></span></div><div class="direct-chat-messages" style="padding: 0;"><ul class="my-chat"><li class="message"></li></ul> </div></div>',
               closable: true
           }); 
           $(".single-chat-message").addClass('hide');
           $(".group-chat-message").removeClass('hide');
          // $(".single-chat-message").addClass('hide');
         //  $(".group-chat-message").removeClass('hide');
       	activeClass = $('.tabs-panels .panel:visible').find('.my-chat');
         }
           sender = '<li class="message "><div class="direct-chat-msg right"><div class="direct-chat-info clearfix">' +
           '<span class="direct-chat-name pull-right">'+name+'</span><span class="direct-chat-timestamp pull-left">'+datetime+'</span>'+
           '</div><img class="direct-chat-img" src="${pageContext.request.contextPath}/resources/img/user3-128x128.jpg" alt="message user image" />' +
           '<div class="direct-chat-text"><div class="text_width">' + text + '</div></div></div></li>';
           $(activeClass).find(".message").last().parent().append(sender);
           li = chat.find("li.message");
           scrollable = li.parents(".scrollable");
           scroll_height = $(".scrollable").height();
           $(".scrollable").animate({scrollTop: $('.scrollable')[0].scrollHeight}, 500);
           }
    }

    
    $('#message_body').keyup(function(e) {
        if (e.keyCode == 13)
        {
        	sendMsg();
            Chat_reply(e);
            
            
        }
    });
    $("#chat_submit").on('click', function(e) {
        sendMsg();
        Chat_reply(e);
        var text = "Hai";
        
    });

    $("#group_chat_submit").on('click', function(e) {
        sendGroupChat();
        group_chat_reply(e);
    });
    
    $("#chat_reply_submit").on('click', function(e) {
        Chat_Sender(e)
    });

    function sendMsg(){

    	stompClient.send("/app/statusmessage",{} , JSON.stringify({
            'message' : text
        })); 
        
    	var activeClass = $('.tabs .tabs-selected a span').text();
		
		var text = document.getElementById("message_body").value;
		console.log(text);

		//a[activeClass].send(text);	
		
		var textToSend = {"user":activeClass,
				"message":text};
		
		
        stompClient.send("/app/simplemessages",{}, 
        		JSON.stringify(textToSend)
        );  
       }

    function sendGroupChat(){
    	var activeClass = $('.tabs .tabs-selected a span').text();
		console.log(activeClass);
		var text = document.getElementById("group_message_body").value;
		console.log(text);

		//a[activeClass].send(text);	
		
		var textToSend = {"user":activeClass,
				"message":text};
		
		
        stompClient.send("/app/groupChat",{}, 
        		JSON.stringify(textToSend)
        ); 
       }
    

     $(document).ready(function(){
        $(".reassign").click(function(){
            $('.assign_conference').addClass('show').removeClass('hide');
        });

         $('.form-control').keypress(function (e) {
             var key = e.which;
             if (key == 13)  // the enter key code
             {
                 $('input[name = butAssignProd]').click();
                 return false;
             }
         });
         $('#search_user').keyup(function(e){
        	 if (e.keyCode == 13)
             {
                 $.ajax({
                	 url: "searchUser",
                	 data:{"searchString":$('#search_user').val()},
                	  success: function(result){
                        alert(result);
                     }
                 });
             }
             
            });
    });

     $("#group-chat").click(function(){
         $(".single-chat-message").addClass('hide');
         $(".group-chat-message").removeClass('hide');
         $.ajax({
        	 url: "getGroup",
        	  success: function(result){
               // alert(result);
                createRoom(result);
             }
             });
     });

     function createRoom(){
    	 $.ajax({
        	 url: "createRoom",
        	  success: function(result){
               // alert(result);
                addPanel( result);
                
             }
             });
         }

</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/jquery.easyui.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/icon.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/demo.css">

</body>
</html>
