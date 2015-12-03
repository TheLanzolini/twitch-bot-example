#!/usr/bin/env ruby

require 'socket'

class SimpleIrcBot
  def initialize(server, port, channel)
    @channel = "thelanzolini"
    @socket = TCPSocket.open(server, port)
    
    @botname = "lanzobot"
    @pass = "oauth:00jmklgc4ibpmsyz45667qk064mlca"
    @onjoinstring = "Hello I am here!"
    
    
    say "PASS #{@pass}"
    say "NICK #{@botname}"
    say "JOIN ##{@channel}"
    say_to_chan "#{1.chr} #{@onjoinstring} #{1.chr}"
  end

  def say(msg)
    puts msg
    @socket.puts msg
  end

  def say_to_chan(msg)
    say "PRIVMSG ##{@channel} :#{msg}"
  end

  def run
    until @socket.eof? do
      msg = @socket.gets
      puts msg

      if msg.match(/PRIVMSG ##{@channel} :(.*)$/)
        unless msg.index('!').nil?
          user = msg.slice(0..(msg.index('!')))
          user = user[1..-2]
        end
        if msg.match('Hey Lanzobot')
          say_to_chan("Hey there #{user}.")
        end
        
        if msg.match("ping")
          say_to_chan("pong")
        end
        
      end

    end
  end

  def quit
    say_to_chan('SHUTTING DOWN BEEP BOOP')
    say "PART ##{@channel} :Daisy, Daisy, give me your answer do"
    say 'QUIT'
  end
end

bot = SimpleIrcBot.new("irc.twitch.tv", 6667, 'thelanzolini')

trap("INT"){ bot.quit }

bot.run