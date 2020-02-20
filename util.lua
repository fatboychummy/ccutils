local utils = {}

function utils.fileRead(filename)
  local h, err = io.open(filename, 'r')
  if h then
    local data = h:read("*a")
    h:close()
    return data
  end
  return false, err
end

function utils.fileWrite(filename, data)
  if type(data) == "table" then
    data = textutils.serialize(data)
  end
  local h, err = io.open(filename, 'w')
  if h then
    h:write(data):close()
    return true
  end
  return false, err
end

function utils.fileAppend(filename, data)
  if type(data) == "table" then
    data = textutils.serialize(data)
  end
  local h, err = io.open(filename, 'a')
  if h then
    h:write(data):close()
    return true
  end
  return false, err
end

function utils.httpGet(url)
  local h, err = http.get(url)
  if h then
    local data = h.readAll()
    h.close()
    return data
  end
  return false, err
end

function utils.dCopy(x)
  local ret = {}
  for k, v in pairs(x) do
    if type(v) == "table" then
      ret[k] = utils.dCopy(v)
    else
      ret[k] = v
    end
  end
  return ret
end

function funcs.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

return utils
