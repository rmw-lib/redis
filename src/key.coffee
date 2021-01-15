import {strict as assert} from 'assert'

export default (r)=>
  if process.NODE_ENV != "production"
    _proxy = (k, prefix)=>
      _R = k
      k = new Proxy(
        _R
        get:(self, attr)=>
          if attr of self
            return self[attr]
          throw new Error("redis key '#{prefix}#{attr}' not define in #{`import.meta`.url[7..]}\n")
      )

    objmap = (o, prefix)=>
      for i of o
        if typeof(o[i]) == 'object'
          o[i] = objmap(o[i],prefix+i+".")
      _proxy o, prefix

    r = objmap r,"R."
  Object.freeze r
