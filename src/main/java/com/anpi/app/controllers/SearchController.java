package com.anpi.app.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jivesoftware.smack.XMPPException;
import org.jivesoftware.smack.provider.ProviderManager;
import org.jivesoftware.smackx.Form;
import org.jivesoftware.smackx.ReportedData.Row;
import org.jivesoftware.smackx.muc.HostedRoom;
import org.jivesoftware.smackx.muc.MultiUserChat;
import org.jivesoftware.smackx.muc.RoomInfo;
import org.jivesoftware.smackx.search.UserSearch;
import org.jivesoftware.smackx.search.UserSearchManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.anpi.app.model.Connection;



@Controller
public class SearchController {
	
    @RequestMapping(value = "/searchUser", method = RequestMethod.GET)
	@ResponseBody
	public List<String> getUsers(String searchString,HttpServletRequest request){
			 Connection connections = (Connection) request.getSession().getAttribute("connection");
	         ProviderManager.getInstance().addIQProvider("query","jabber:iq:search", new UserSearch.Provider());
	         List<String> list = new ArrayList<String>();
	         try {
	             UserSearchManager search = new UserSearchManager(connections.getConnection());  
	             Form searchForm = search.getSearchForm("search."+connections.getConnection().getServiceName());
	             Form answerForm = searchForm.createAnswerForm();  
	             answerForm.setAnswer("Username", true);  
	             answerForm.setAnswer("search", searchString);  
	             org.jivesoftware.smackx.ReportedData data = search.getSearchResults(answerForm,"search."+connections.getConnection().getServiceName());  

	             if(data.getRows() != null)
	             {
	                 java.util.Iterator<Row> it = data.getRows();
	                 while(it.hasNext())
	                 {
	                     Row row = it.next();
//	                     System.out.println(row);
	                     java.util.Iterator iterator = row.getValues("jid");
	                     if(iterator.hasNext())
	                     {
	                         String value = iterator.next().toString();
	                         list.add(value);
	                         System.out.println("Iteartor values......"+value);
	                     }
	                 }
	                 System.out.println("UserName Exists");

	             }
	         } catch (Exception e) {
	             System.out.println("Exception in Loading user search "+e);
	             e.printStackTrace();
	         }
	         return list;
		
	}
    
    
    @RequestMapping(value = "/getGroup", method = RequestMethod.GET)
    @ResponseBody
    public List<String> getGroup(HttpServletRequest request) throws XMPPException{
        List<String> groupList = new ArrayList<String>();
        Connection connections = (Connection) request.getSession().getAttribute("connection");
        for (String service: MultiUserChat.getServiceNames(connections.getConnection())) {
            System.out.println("Service name: " + service);
             //Get the list of rooms under this service
             for (HostedRoom room: MultiUserChat.getHostedRooms(connections.getConnection(), service)) {
                 System.out.println("\tName: " + room.getName());
                 System.out.println("\tRoom JID: " + room.getJid());
                 //Get the detail information on the room 
                 RoomInfo info = MultiUserChat.getRoomInfo(connections.getConnection(), room.getJid());
                 System.out.println("\tDescription: " + info.getDescription());
                 System.out.println("\tOccupant: " + info.getOccupantsCount());
                 System.out.println("\tPassword: " + info.isPasswordProtected());
                 groupList.add(room.getJid());
             }
         }
        return groupList;
    }

}
