import chalk from 'chalk'
import Redis from 'ioredis'

sendCommand = Redis::sendCommand

Redis::sendCommand = (command)->
  {host,port,db} = @options
  ps = "#{host}:#{port} #{db}"
  begin = new Date()
  log = =>
      t = [
        chalk.gray(ps)
        chalk.greenBright command.name
        chalk.blueBright command.args.join(" ")
      ]
      cost = (new Date() - begin)
      t.push chalk.gray((cost / 1000) + " s")
      process.stdout.write t.join(" ")
  try
      r = sendCommand.apply(@, arguments)
  finally
      log()
  return r


