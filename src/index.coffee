#!/usr/bin/env coffee

import config from './config'
import Redis from 'ioredis'

export default redis = new Redis(config)

redis.on 'error', (err)=>
  console.trace(err)
  return
