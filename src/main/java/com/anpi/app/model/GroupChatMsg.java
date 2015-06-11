package com.anpi.app.model;

public class GroupChatMsg {
    
    private String user;
    private String message;
    private String groupName;
    public String getUser() {
        return user;
    }
    public void setUser(String user) {
        this.user = user;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
    public String getGroupName() {
        return groupName;
    }
    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
    public GroupChatMsg(String user, String message, String groupName) {
        super();
        this.user = user;
        this.message = message;
        this.groupName = groupName;
    }
    
    
    
    

}
