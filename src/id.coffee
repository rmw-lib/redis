import redis from './index'

# redis.log(redis.LOG_WARNING, "id = "..tostring(id))
redis.defineCommand("id", {
  numberOfKeys: 1
  lua: """
local key = KEYS[1]
local value = ARGV[1]
local idkey = key .. ".id"
local id = redis.call("zscore",key,value)
if id == false then
  id = redis.call("incr", idkey)
  redis.call("zadd",key,id,value)
end
return id
"""
})

