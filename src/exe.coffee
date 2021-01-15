import CONFIG from "@rmw/config"
import fs from 'fs'

export default =>

  redis_exe = (CONFIG.redis or {}).exe or process.env.RMW_REDIS

  if redis_exe and fs.existsSync(redis_exe)
    return redis_exe

  if "win32" != process.platform
    for i in ["usr/local","usr",""]
      redis_exe = "/#{i}/bin/redis-server"
      if fs.existsSync redis_exe
        return redis_exe
  throw Error("redis-server not exist")

