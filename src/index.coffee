#!/usr/bin/env coffee

import CONFIG from './config'
import Redis from 'ioredis'
import throttle from 'lodash/throttle'

redis = new Redis(CONFIG)
export default redis

redis.on 'error', throttle(
  (err)=>
    console.log(err)
    (await import('./pm2')).restart()
  15000
  {
    trailing:false
  }
)
