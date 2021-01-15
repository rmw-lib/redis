import CONFIG from "@rmw/config"
import {randomBytes} from 'crypto'
import BASE64 from 'urlsafe-base64'

export default config = {}

do =>
  Object.assign(
    config , CONFIG.redis or {}
  )

  if not config.password
    config.password = BASE64.encode(randomBytes(16))
    CONFIG.redis = {...config}

  for k,v of {
    host : "127.0.0.1"
    port : 14100
    db : 0
  }
    if k not of config
      config[k] = v

  return

