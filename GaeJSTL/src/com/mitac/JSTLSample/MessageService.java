package com.mitac.JSTLSample;

public class MessageService {
    private Message[] fakeMessages;
    public MessageService() {
        fakeMessages = new Message[3];
         fakeMessages[0] = 
             new Message("sunny", "sunny's message!");
        fakeMessages[1] = 
             new Message("simon", "Simon's message!");
        fakeMessages[2] = 
             new Message("jack", "Jack's message!");
    }
    public Message[] getMessages() {
        return fakeMessages;
    }
} 
