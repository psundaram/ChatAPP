<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate, max-age=0">
<!--  Bootstrap related -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Latest compiled and minified Bootstrap CSS -->
<link rel="stylesheet" href="<c:url value="/resources/scripts/bootstrap/css/bootstrap.min.css"/>">
<title>Learn WebSockets 1</title>
<!-- WebSocket related javascript includes -->
<script src="<c:url value="/resources/scripts/sockjs-0.3.4.min.js"/>"></script>
<script src="<c:url value="/resources/scripts/stomp.js"/>"></script>
</head>
<body>
  <noscript>
    <h2 style="color: #ff0000">Seems your browser doesn't support Javascript! WebSocket relies on Javascript being enabled. Please enable Javascript and reload this page!</h2>
  </noscript>
  <c:url var="imageUrl" value="/resources/images/user01.png" />
  <div class="container">
    <div class="row">
      <div class="col-sm-10">
        <!-- WebSocket related Twitter Bootstrap 3.0 based UI elements -->
        <div id="heading" class="masthead">
          <div class="pull-right">
            Logged In: <strong>${username}</strong> | ${time } | <a href="${pageContext.request.contextPath}/logout">Logout&nbsp;<span class="glyphicon glyphicon-remove"></span></a>
          </div>
          <h3 class="muted">
            <img src="${imageUrl}" />
          </h3>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-sm-6">
        <p>&nbsp;</p>
        <!-- Connect and Disconnect buttons to establish/terminate a connection to the websocket service -->
        <!-- <div class="panel">
          <button id="connect" class="btn btn-success btn-sm">Connect</button>
          <button id="disconnect" class="btn btn-danger btn-sm">Disconnect</button>
        </div> -->
        <p />
        <div class="panel">
        <div id="price"></div>
        </div>
        <div class="panel panel-default">
          <div class="panel-heading">Send Messages To WebSocket Server</div>
          <div class="panel-body" id="conversationDiv">
            <div class="input-group">
              <input type="text" class="form-control" id="txtSendMessage" placeholder="Enter message"> <span class="input-group-btn">
                <button id="sendMessage" class="btn btn-primary">
                  <span class="glyphicon glyphicon-share-alt"></span>&nbsp;Send
                </button>
              </span>
            </div>
            <!-- Error alert -->
            <div class="alert alert-danger alert-dismissable" id="formAlert">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong>Error!</strong> Message cannot be blank.
            </div>
            <!-- /Error alert -->
            <!-- Info alert -->
            <div class="alert alert-info alert-dismissable" id="formInfoAlert">
              <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
              <strong>Message Sent!</strong> <br />Your message has been sent to the server. You can continue to do other actions. Server response will be shown when it arrives.
            </div>
            <!-- /Info alert -->
            <!-- .input-group -->
          </div>
          <!-- .panel-body -->
          <div class="panel-body" id="response"></div>
          <!-- Div to show the server responses -->
        </div>
        <!-- .panel -->
      </div>
    </div>
  </div>
  <!-- .container -->
  <!-- External Javascripts -->
  <!-- Latest compiled and minified JQuery JavaScript (necessary for Bootstrap's JavaScript plugins). Placed at the end of the document so the pages load faster -->
  <script src="<c:url value="/resources/scripts/jquery-1.10.2.min.js"/>"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="<c:url value="/resources/scripts/bootstrap/js/bootstrap.min.js"/>"></script>
  <!-- Knockout data-binding MVVM library. More at http://knockoutjs.com/  -->
  <script src="<c:url value="/resources/scripts/knockout-3.0.0.js"/>"></script>
  <%-- URL for the STOMP end point for registering a stomp client--%>
  <c:url value="/simplemessages" var="socketDest" />
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
                $("#sendMessage").on("click", function(e) {

                    // Find the input text element for the server message
                    var messageForServer = $("#txtSendMessage").val();

                    if (messageForServer === "") {

                        // If message is empty prevent submission and show the alert
                        e.preventDefault();
                        $("#formAlert").slideDown(400);

                    } else {

                        // Message is not empty so send to server
                        $("#formAlert").slideUp(400);

                        // Show a please wait alert
                        $("#formInfoAlert").slideDown(400);

                        // Send message to server. The message for the server must 
                        // be in JSON format. 
                        // Also refer SimpleMessage.java POJO.
                        sendMessageToServer(messageForServer);
                    }
                });
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
                alert(frame.body);
                var prices = JSON.parse(frame.body);
                $('#price').empty();
                for(var i in prices) {
                  var price = prices[i];
                  $('#price').append(
                         
                    $('<tr>').append(
                      $('<td>').html(price.name),
                      $('<td>').html(price.name),
                      $('<td>').html(price.username),
                      $('<td>').html(price.statusMsg)
                    )
                  );
                }
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
                    //Lets show a connection success message
                    showServerBroadcast("Connection established: " + frame, false);
                    // Now subscribe to a topic of interest.
                    
                     stompClient.subscribe("/topic/displayusers", function(message) {
                    	 renderUser(message);
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
                    stompClient.subscribe("/topic/simplemessagesresponse", function(servermessage) {//Callback when server responds
                        showServerBroadcast(JSON.parse(servermessage.body).messageContent, false);
                        //Server responded so hide the info alert
                        $("#formInfoAlert").slideUp(400);
                        //Also all text in server message input field should be empty
                        $("#txtSendMessage").val("");
                        $("#txtSendMessage").focus();
                        $("#txtSendMessage").select();
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
            function sendMessageToServer(messageForServer) {
                //Show on the browser page that a message is being sent
                showServerBroadcast("Your message '" + messageForServer + "' is being sent to the server.", true);
                // The message for the server must be in JSON format. Also refer SimpleMessage.java POJO.
                stompClient.send("/app/simplemessages", {}, JSON.stringify({
                    'message' : messageForServer
                }));
            }

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
</body>
</html>