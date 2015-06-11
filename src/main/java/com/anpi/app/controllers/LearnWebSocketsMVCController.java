package com.anpi.app.controllers;

import java.security.Principal;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.jivesoftware.smack.XMPPConnection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.anpi.app.util.Util;

@Controller
@Scope("request")
public class LearnWebSocketsMVCController {
    
    @Autowired
   private HttpServletRequest request;
    
    private XMPPConnection connection;

    private static final Logger LOG = LoggerFactory
            .getLogger(LearnWebSocketsMVCController.class);

    @RequestMapping("/loginPage")
    public String handleIndexPage(Model model, Locale locale) {
        LOG.info("Request for default / url processed at {}",
                Util.getSimpleDate());
        return "loginPage";
    }

    /**
     * Method is executed when there is a call to the <code>/logoutPage</code>
     * url.
     * 
     * @return
     */
    @RequestMapping(value = "/logoutPage", method = RequestMethod.GET)
    public String logoutPage() {
        LOG.info("Request for /logoutPage url processed at {}",
                Util.getSimpleDate());
        return "logoutPage";
    }

    /*private HttpServletRequest getRemoteAddress() {
        System.out.println();
        RequestAttributes attribs = RequestContextHolder.getRequestAttributes();
        if (attribs instanceof NativeWebRequest) {
            HttpServletRequest request = (HttpServletRequest) ((NativeWebRequest) attribs).getNativeRequest();
            System.out.println(request.getRemoteAddr());
            return request;
        }
        return null;
    }*/
    
    /**
     * Method is executed when there is a call to the <code>/loginPage</code>
     * url. On successful login, the user is re-directed to the
     * <code>/secured/myPage</code> url.
     * 
     * @return
     * @throws XMPPException 
     */
    /*@RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginPage(String username,String password) throws XMPPException {
        LOG.info("Request for /loginPage url processed at {}",
                Util.getSimpleDate());
        ConnectionConfiguration config = new ConnectionConfiguration("10.5.3.217");
        connection = new XMPPConnection(config);
        connection.connect();
        connection.login(username, password);

        System.out.println("Success");
        Connection connections = new Connection();
        connections.setConnection(connection);
         PacketFilter filter = new MessageTypeFilter(Message.Type.chat);
            connection.addPacketListener(this,filter);
        Presence p = new Presence(Presence.Type.available, "Online", 42, Mode.available);
        connection.sendPacket(p);
        request.getSession().setAttribute("connection", connections);
        Connection connections2 = (Connection) request.getSession().getAttribute("connection");
        System.out.println(connections2.getConnection().getConnectionID());
//        request.getSession().setAttribute("userName", userName);
//        return "chat";
        return "secured/socketConnection";
    }*/

    /**
     * Method gets executed when there are requests to the
     * <code>/secured/basicWebsockets</code> url. This url is called after a
     * successful login.
     * 
     * @param model
     * @param principal
     * @param locale
     * @return
     */
    @RequestMapping("/secured/basicWebsockets")
    public String basicWebsocketsPage(Model model, Principal principal,
            Locale locale) {

        System.out.println("Entering secured websockets");
        // Get a simple human readable date and time
        String formattedDate = Util.getSimpleDate(locale);

        // Get the logged in user's name
        String userName = "testuser";
                //principal.getName();

        // Set some sample messages to show on the landing 'basicWebsockets.jsp'
        // page.
        model.addAttribute("username", userName);
        model.addAttribute("time", formattedDate);

        LOG.info(
                "Request from user:{} for /secured/basicWebsockets url processed at time:{}",
                userName, formattedDate);

        return "secured/socketConnection";
    }
}