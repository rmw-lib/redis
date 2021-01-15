<!-- 本文件由 ./readme.make.md 自动生成，请不要直接修改此文件 -->

# @rmw/redis

##  安装

```
yarn add @rmw/redis
```

或者

```
npm install @rmw/redis
```

## 使用

```coffee
#!/usr/bin/env coffee
import redisStart from '@rmw/redis/pm2'

do =>
  console.log 1
  await redisStart()
  console.log 2

  redis = (await import('@rmw/redis')).default
  console.log await redis.info()

```

## 关于

本项目隶属于**人民网络([rmw.link](//rmw.link))** 代码计划。

![人民网络](https://raw.githubusercontent.com/rmw-link/logo/master/rmw.red.bg.svg)
