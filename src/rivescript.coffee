# Description:
#   Provides a RiveScript chatbot for Hubot. This bot will respond to all
#   messages directed at it by using a RiveScript brain.
#
# Dependencies:
#   "rivescript": "^1.13.0"
#
# Configuration:
#   HUBOT_RIVESCRIPT_BRAIN -  The path to a folder containing RiveScript files
#       (with the *.rive file extensions).
#   HUBOT_RIVESCRIPT_PREFIX - If you don't want your Hubot to answer all
#       messages using RiveScript, set this string to be a prefix, e.g. with
#       the value "rs" a user must say "hubot rs hello" for the bot to answer
#       their "hello" message.
#   HUBOT_RIVESCRIPT_UTF8  - Boolean to enable UTF-8 mode, 1 or 0, default 1
#
# Commands:
#   hubot [rs] <message> - Retrieve a response from RiveScript.
#
# Author:
#   Noah Petherbridge, https://github.com/kirsle

RiveScript = require "rivescript"

module.exports = (robot) ->
  # Configuration parameters.
  debug  = "#{process.env.HUBOT_RIVESCRIPT_DEBUG}" is "1" or false
  brain  = process.env.HUBOT_RIVESCRIPT_BRAIN or "./brain"
  prefix = if process.env.HUBOT_RIVESCRIPT_PREFIX then "#{process.env.HUBOT_RIVESCRIPT_PREFIX}\\s+" else "\\s*"
  utf8   = "#{process.env.HUBOT_RIVESCRIPT_UTF8}" is "1" or false
  sync   = "#{process.env.HUBOT_RIVESCRIPT_SYNC}" is "1" or false

  # The matcher regexp.
  regexp = new RegExp("#{prefix}(.*)", "i")

  # Initialize the RiveScript brain.
  @bot = new RiveScript({
    debug: debug,
    utf8: utf8
  })

  # Save user variables after each interaction.
  @saveUservars = (user) ->
    userData = robot.brain.get("rivescript") or {}
    userData[user.name] = @bot.getUservars(user.name)
    robot.brain.set("rivescript", userData)

  @bot.loadDirectory(brain, ->
    @bot.sortReplies()

    # Load user variables from hubot brain into rivebot, when ready
    robot.brain.on 'loaded', =>
      userData = robot.brain.get("rivescript") or {}
      for user, data of userData
        @bot.setUservars user, data

    robot.respond regexp, (res) =>
      if sync
        reply = @bot.reply(res.message.user.name, res.match[1], @)
        if reply
          res.send reply
          @saveUservars(res.message.user)
      else
        reply = @bot.replyAsync(res.message.user.name, res.match[1], @).then (reply) ->
          if reply
            res.send reply
            @saveUservars(res.message.user)

  , (err) ->
    console.error "Couldn't load RiveScript replies: #{err}"
  )
