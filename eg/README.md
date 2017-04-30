# Hubot-RiveScript Example

This is an example Hubot that uses the `hubot-rivescript` module. It uses the
shell adapter, and is designed for local development of the `hubot-rivescript`
project.

## Running the Example

From a fresh clone of the `hubot-rivescript` repo:

```bash
% cd eg/
% make
```

The `make` command will install dependencies (including an "update" to
`hubot-rivescript` from the parent directory), and run the Hubot. See
[Makefile Commands](#makefile-commands) for more information about the
`make` command and its options.

You'll see some start up output and a prompt:

```
[Sat Feb 28 2015 12:38:27 GMT+0000 (GMT)] INFO Using default redis on localhost:6379
hubot>
```

And you can interact with RiveScript by prefixing a message with the bot's name:

```
hubot> hubot My name is Noah
Noah, nice to meet you.
```

## Makefile Commands

For convenience, a GNU Makefile can run these commands:

* `make` runs `make setup` and `make run`
* `make setup` installs dependencies for the Hubot, including an "update" to
  `hubot-rivescript` from the parent directory. So, if you're actively working
  on this plugin, you can run the latest code in this example bot.
* `make run` runs the Hubot using `../brain` for the brain and UTF-8 mode enabled.
* `make run.sync` is like `make run`, but uses synchronous replies (i.e., using
  `rs.reply()` instead of `rs.replyAsync()`).
* `make debug` is like `make run`, but enables debug mode within RiveScript.
