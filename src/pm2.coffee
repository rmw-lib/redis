#!/usr/bin/env coffee

import {thisdir} from "@rmw/thisfile"
import {dirname} from 'path'
import redis_exe from './exe'
ROOT = dirname thisdir(`import.meta`)

import DIR from "@rmw/dir"
import {writeFile, readFile} from 'fs/promises'
import fs from 'fs'
import onExit from 'async-exit-hook'
import _pm2 from 'pm2'
import tenjin from 'tenjin'
import {join} from 'path'

redis = "redis"
name = "rmw-"+redis
redis_conf = redis+".conf"
{rmw} = DIR
config = join(rmw,redis_conf)

_N = 0
pm2 = new Proxy(
  _pm2
  {
    get:(self, attr)=>
      (args, func)->
        new Promise (resolve, reject)=>
          ++_N
          self.connect (err)=>
            err and reject err
            self[attr] args, (err)=>
              err and reject err
              if func
                try
                  await func.apply @,arguments
                catch err
                  reject err
                  return
              setTimeout resolve
              if not --_N
                self.disconnect()
  }
)

pm2_redis = (action)=>
  script = undefined
  =>
    script = script or await redis_exe()
    if not fs.existsSync(config)

      txt = tenjin.render(
        await readFile join(ROOT, redis_conf), "utf8"
        {
          dir:rmw
          ...(await import('./config')).default
        }
      )
      await writeFile config, txt
    await pm2[action] {
      name
      script
      pid_file: join(rmw,"redis.pid")
      args:config
    }

onExit (resolve)=>
  pm2.stop name, (err, proc)=>
    resolve()

export restart = pm2_redis 'restart'
export default pm2_redis 'start'


