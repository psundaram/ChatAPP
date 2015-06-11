package com.anpi.app.model;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class main {

    public static void main(String args[]) throws JsonParseException, JsonMappingException, IOException{
        String text = "testuser@conference.mouli/testuser";
        String name=text.substring(0,text.indexOf("/"));
        System.out.println(name);
        String from = text.split("/")[1];
        System.out.println(from);
        
        /*String text ="{\"user\":\"mouli\",\"message\":\"hai\"}";
        ObjectMapper objectMapper = new ObjectMapper();
        com.blogspot.sunitkatkar.model.Message messageObj = objectMapper.readValue(text, com.blogspot.sunitkatkar.model.Message.class);
        System.out.println("messageObj: "+messageObj.toString());*/
    }
}
