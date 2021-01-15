#!/usr/bin/env coffee
import redisStart from '@rmw/redis/pm2'

do =>
  console.log 1
  await redisStart()
  console.log 2

  redis = (await import('@rmw/redis')).default
  console.log await redis.info()
