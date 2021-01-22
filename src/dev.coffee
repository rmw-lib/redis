import chalk from 'chalk'
import Redis from 'ioredis'

sendCommand = Redis::sendCommand

Redis::sendCommand = (command)->
  begin = new Date()
  log = =>
      t = [
        chalk.green("redis "+@_name)
        chalk.gray("<")
        chalk.greenBright command.name
        chalk.blueBright command.args.join(" ")
      ]
      cost = (new Date() - begin)
      if cost > 10
        t.push chalk.gray((cost / 1000) + " s")
      console.log  t.join(" ")
  try
      r = sendCommand.apply(@, arguments)
  finally
      log()
  return r


