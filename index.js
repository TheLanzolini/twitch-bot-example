// Do NOT include this line if you are using the built js version!
var irc = require("twitch-irc");

var options = {
    options: {
        debug: true
    },
    connection: {
        random: "chat",
        reconnect: true
    },
    identity: {
        username: "Lanzobot",
        password: "oauth:00jmklgc4ibpmsyz45667qk064mlca"
    },
    channels: ["#thelanzolini"]
};

var client = new irc.client(options);

// Connect the client to the server..
client.connect();

client.on('chat', function(channel, user, message){
  console.log(channel + ' : ' + user.username + ' : ' + message);
  
  if(message.indexOf('!ping') > -1){
    client.say(channel, "pong");
  }
  
});