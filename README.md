# Hubot: hubot-rivescript

Provides a RiveScript chatbot personality for Hubot, using the
[rivescript](https://github.com/aichaos/rivescript-js) JS module.

RiveScript is a simple scripting language for chatbots. See
[RiveScript.com](https://www.rivescript.com/) to learn more about it.

See [`src/rivescript.coffee`](src/rivescript.coffee) for full documentation.

## Installation

In your hubot project repo, run:

`npm install --save hubot-rivescript`

Then add **hubot-rivescript** to your `external-scripts.json`:

```json
[
  "hubot-rivescript"
]
```

## Configuration

Use the following environment variables to configure your RiveScript bot:

* **HUBOT_RIVESCRIPT_BRAIN** - the path on disk to a directory containing
  RiveScript files (`*.rive`). The default is to look in a folder named
  "./brain" relative to the current working directory.
* **HUBOT_RIVESCRIPT_PREFIX** - by default, this script responds to *all*
  messages directed at the bot (by mentioning its username). This can overlap
  with other scripts you may have configured; so you can set this variable to
  require an additional prefix. For example, with
  `HUBOT_RIVESCRIPT_PREFIX="rs"` a user must say "hubot rs hello" to get the
  RiveScript bot to respond rather than just "hubot hello".
* **HUBOT_RIVESCRIPT_UTF8** - enable or disable UTF-8 mode in RiveScript. By
  default this is **off** and you can enable it by doing
  `HUBOT_RIVESCRIPT_UTF8=1`.

  By default all punctuation and symbols are stripped from the user's input
  message, and RiveScript triggers can't contain Unicode symbols. Enable UTF-8
  mode to lift these restrictions if you have to support non-English users.

## Sample Interaction

```
user1> hubot hello bot
hubot> Hello human!

user1> hubot my name is Alice
hubot> Alice, I'll call you that from now on.

user2> hubot call me Bob
hubot> I'll remember that your name is Bob.

user1> hubot who am I?
hubot> Your name is Alice.

user2> hubot what's my name?
hubot> You told me your name is Bob.
```

## NPM Module

https://www.npmjs.com/package/hubot-rivescript

## Author

Noah Petherbridge, [@kirsle](https://github.com/kirsle)
