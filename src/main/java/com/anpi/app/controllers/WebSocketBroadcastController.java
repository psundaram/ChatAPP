package com.anpi.app.controllers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.PacketListener;
import org.jivesoftware.smack.Roster;
import org.jivesoftware.smack.RosterEntry;
import org.jivesoftware.smack.RosterGroup;
import org.jivesoftware.smack.RosterListener;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.filter.MessageTypeFilter;
import org.jivesoftware.smack.filter.PacketFilter;
import org.jivesoftware.smack.packet.Packet;
import org.jivesoftware.smack.packet.Presence;
import org.jivesoftware.smack.packet.Presence.Mode;
import org.jivesoftware.smack.util.StringUtils;
import org.jivesoftware.smackx.ChatState;
import org.jivesoftware.smackx.ChatStateListener;
import org.jivesoftware.smackx.ChatStateManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompCommand;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ConcurrentTaskScheduler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.anpi.app.model.Connection;
import com.anpi.app.model.Contacts;
import com.anpi.app.model.MessageBroadcast;
import com.anpi.app.model.SimpleMessage;
import com.anpi.app.model.StatusListener;
import com.anpi.app.util.Util;
import com.fasterxml.jackson.databind.ObjectMapper;
/**
 * {@link WebSocketBroadcastController} is a regular Spring Controller as seen
 * in most Spring MVC applications. Its job is to receive {@link SimpleMessage}
 * message objects from the client, extract the <code>payload</code> (or
 * contents) of the message, prepend it with some simple text and finally
 * broadcast (or publish) the message to all clients who have subscribed to the
 * <code>/topic/simplemessages</code> message queue.
 * 
 * 
 */

@Controller
public class WebSocketBroadcastController implements PacketListener,ChatStateListener{
    
     private SimpMessagingTemplate template;  
    
    private TaskScheduler scheduler = new ConcurrentTaskScheduler();
    
    public SimpMessagingTemplate getTemplate() {
        return template;
    }

    @Autowired
    public void setTemplate(SimpMessagingTemplate template) {
        this.template = template;
    }

    private static final Logger LOG = LoggerFactory
            .getLogger(WebSocketBroadcastController.class);
    
    

    
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginPage(String username,String password,HttpServletRequest request) throws XMPPException {
        LOG.info("Request for /loginPage url processed at {}",
                Util.getSimpleDate());
        ConnectionConfiguration config = new ConnectionConfiguration("10.5.3.217");
        XMPPConnection connection = new XMPPConnection(config);
        connection.connect();
        connection.login(username, password);

        System.out.println("Success");
        Connection connections = new Connection();
        connections.setConnection(connection);
        PacketFilter filter = new MessageTypeFilter(org.jivesoftware.smack.packet.Message.Type.chat);
            connection.addPacketListener(this,filter);
        Presence p = new Presence(Presence.Type.available, "Online", 42, Mode.available);
        connection.sendPacket(p);
        request.getSession().setAttribute("connection", connections);
        request.getSession().setAttribute("userName", username);
        Connection connections2 = (Connection) request.getSession().getAttribute("connection");
        System.out.println(connections2.getConnection().getConnectionID());
//        request.getSession().setAttribute("userName", userName);
//        return "chat";
        return "secured/chat";
    }

    /**
     * Method to handle the requests sent to this controller at
     * <code>/simplemessages</code> <br/>
     * <br/>
     * <b>Explanation:</b> The <code>@MessageMapping</code> annotation ensures
     * that if a message is sent to destination <code>/simplemessages</code>,
     * then the
     * {@link WebSocketBroadcastController#processMessageFromClient(SimpleMessage)}
     * method is called. <br/>
     * <br/>
     * The message payload is bound to the {@link SimpleMessage} object. For
     * simplicity, this method simulates a 3 second delay before sending back
     * the message as a {@link MessageBroadcast} object. The return value is
     * broadcast to all subscribers to
     * <code>/topic/simplemessagesresponse</code> as specified in the
     * <code>@SendTo</code> annotation. <br/>
     * <br/>
     * <b>Note:</b> The 3 second delay demonstrates that after the server
     * receives a message from the client, the client is free to continue any
     * other processing while the server takes its own time to act on the
     * received message.
     * 
     * @param message
     * @param principal
     * @param locale
     * @return
     * @throws Exception 
     * @throws Exception
     */
    @MessageMapping("/statusmessage")
    public void statusMessage(Message message
           
            ) throws Exception {
        
        System.out.println("Inside statusMessage " + message.getPayload().toString());
    }
    
    @MessageMapping("/simplemessages")
//    @SendTo("/topic/simplemessagesresponse")
    public void processMessageFromClient(Message message,String text
            ) throws Exception {
        // Simulate a delay of 3 seconds
        System.out.println("Inside simpleMessage " + message.getPayload().toString());
        System.out.println("**********" + text);
//        Thread.sleep(10000);
        LOG.info("Sending server side response '{}' for user: {}", message,
                "testuser");
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
        StompCommand command = accessor.getCommand();
        Map<String, Object> attrs = accessor.getSessionAttributes();
        
        ObjectMapper objectMapper = new ObjectMapper();
        com.anpi.app.model.Message messageObj = objectMapper.readValue(text, com.anpi.app.model.Message.class);
        System.out.println("messageObj: "+messageObj.toString());

        
        Connection connections = (Connection) attrs.get("connection");
        Chat chat = connections.getConnection().getChatManager().createChat(messageObj.getUser()+"@mouli",(ChatStateListener)this); 
            
           
        ChatStateManager.getInstance(connections.getConnection()).setCurrentState(ChatState.composing, chat);
//        Thread.sleep(10000);
        chat.sendMessage(messageObj.getMessage());
    }
    
    /*@MessageMapping("/groupChat")
//  @SendTo("/topic/simplemessagesresponse")
  public void processGroupChatMessage(Message message,String text
          ) throws Exception {
      // Simulate a delay of 3 seconds
      System.out.println("Inside processGroupChatMessage " + message.getPayload().toString());
      System.out.println("**********" + text);
//      Thread.sleep(10000);
      LOG.info("Sending processGroupChatMessage server side response '{}' for user: {}", message,
              "testuser");
      StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
      StompCommand command = accessor.getCommand();
      Map<String, Object> attrs = accessor.getSessionAttributes();
      
      ObjectMapper objectMapper = new ObjectMapper();
      com.blogspot.sunitkatkar.model.Message messageObj = objectMapper.readValue(text, com.blogspot.sunitkatkar.model.Message.class);
      System.out.println("messageObj: "+messageObj.toString());

      
      Connection connections = (Connection) attrs.get("connection");
      Chat chat = connections.getConnection().getChatManager().createChat(messageObj.getUser()+"@mouli",(MessageListener) this);
      chat.sendMessage(messageObj.getMessage());
  }*/
  
  
    
    public void processMessage(Chat chat, org.jivesoftware.smack.packet.Message message) {
        if (message.getType() == org.jivesoftware.smack.packet.Message.Type.chat)
            System.out.println(chat.getParticipant() + " says: " + message.getBody());
        /*try {
                dummySession.getBasicRemote().sendText(chat.getParticipant()+"##"+message.getBody());
            } catch (IOException e) {
                e.printStackTrace();
            }*/
    }

    public void processPacket(Packet packet) {
         org.jivesoftware.smack.packet.Message message = (org.jivesoftware.smack.packet.Message) packet;
         System.out.println(message.getTo());
            try{
             if (message.getBody() != null) {
                 String fromName = StringUtils.parseBareAddress(message
                         .getFrom());
                System.out.println("XMPPClient Got text [" + message.getBody()
                         + "] from [" + fromName + "]");
                
                this.template.convertAndSendToUser(message.getTo().split("@")[0],"/queue/simplemessagesresponse", new MessageBroadcast(fromName+"##"+message.getBody()));
                
             }
             }catch(Exception e){
                e.printStackTrace();
             }
        
    }
    
    
    
    
    @MessageMapping("/displayusers")
    public void displayUser(final Message message
            )  {
        System.out.println("Display users");
        StompHeaderAccessor accessor = StompHeaderAccessor.wrap(message);
        StompCommand command = accessor.getCommand();
        Map<String, Object> attrs = accessor.getSessionAttributes();
        System.out.println("attrs:"+attrs);
        System.out.println("Connection:"+attrs.get("connection"));
        Connection connections = (Connection) attrs.get("connection");
        System.out.println("-----0"+connections.getConnection().getConnectionID());
        String userName = (String) attrs.get("userName");
        System.out.println("userNme:"+userName);
        
        List<Contacts> listOfUsers = new ArrayList<Contacts>();
        Roster roster = connections.getConnection().getRoster();
        Collection<RosterEntry> entries = roster.getEntries();

        System.out.println("\n\n" + entries.size() + " buddy(ies):");
        roster.addRosterListener(new RosterListener() {
        public void entriesDeleted(Collection<String> addresses) {}
        public void entriesUpdated(Collection<String> addresses) {}
        public void presenceChanged(Presence presence) {
            
            System.out.println("Presence changed: " + presence.getFrom() + " " + presence);
                displayUser(message);
        }
        public void entriesAdded(Collection<String> arg0) {}
        });
        
        
        for (RosterEntry r : entries) {
            Contacts contacts = new Contacts();
            System.out.println(r.getUser() + "," + r.getStatus() + "," + r.getName());
            System.out.println(r.getUser().split("@")[0]);
            contacts.setName(r.getUser().split("@")[0]);
            contacts.setUserName(r.getUser());
            try { Thread.sleep(500); } catch (InterruptedException e) { }
            Presence presence = roster.getPresence(r.getUser());
            System.out.println("Presence status: "+presence.getStatus());                                    
            System.out.println("Presence type: "+presence.getType());                
            System.out.println("Presence mode: "+presence.getMode()); 
            if(presence.getType().equals(Presence.Type.available)){
                contacts.setStatus(presence.getStatus());
            }
            else{
                contacts.setStatus(Presence.Type.unavailable.toString());
            }
            if(contacts.getStatus().equalsIgnoreCase("Online"))
                contacts.setStatusMsg("online-green");
            else if(contacts.getStatus().equalsIgnoreCase("Away"))
                contacts.setStatusMsg("online-orange");
            else
                contacts.setStatusMsg("online-red");
                
            
           
            listOfUsers.add(contacts);
        }
        
        
        Collection<RosterGroup> rosterGroups = roster.getGroups();
        
//        sendMessageToUser(userName,new TextMessage((CharSequence) listOfUsers));
        this.template.convertAndSend("/topic/"+userName+"/displayusers", listOfUsers);
    }
    
    @Override
    public void stateChanged(Chat chat, ChatState state) {
        System.out.println(state +chat.getParticipant() );
        switch (state){
        case active:
            System.out.println("state active");
            break;
        case composing:
            System.out.println("state composing");
            break;
        case paused:
            System.out.println("state paused");
            break;
        case inactive:
            System.out.println("state inactive");
            break;
        case gone:
            System.out.println("state gone");
            break;
    }
        this.template.convertAndSend("/topic/statusmessage",new StatusListener(chat.getParticipant().split("/")[1],chat.getParticipant() + "is typing..."));
        System.out.println("Status message");
    }


    

    /**
     * If there are any exceptions thrown by any of the messaging infrastructure
     * then they can be sent to the end user on the <code>/queue/errors</code>
     * destination.
     * 
     * @param exception
     * @return
     */
    /*@MessageExceptionHandler
    @SendToUser("/queue/errors")
    public String handleException(Throwable exception) {
        
        System.out.println("exception:"+exception.getStackTrace());
        return exception.getMessage();
    }*/
    
    
}