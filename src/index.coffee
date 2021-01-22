#!/usr/bin/env coffee

import config from './config'
import Redis from 'ioredis'

do =>
  if process.env.NODE_ENV == "development"
    import('./dev.coffee')

export default redis = new Redis(config)

redis.on 'error', (err)=>
  console.trace(err)
  return
