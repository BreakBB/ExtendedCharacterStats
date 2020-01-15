---@class ECSLoader
ECSLoader = {}

---@class Module
local module = {}
module.private = {}

-- ["ModuleName"] = moduleReference
---@type table<string, Module>
local modules = {}

---@return Module @Module reference
local function _CreateBlankModule()
    local ret = {}
    ret.private = {}
    return ret
end

---@param name string @Module name
---@return Module @Module reference
function ECSLoader:CreateModule(name)
  if not modules[name] then
    modules[name] = _CreateBlankModule()
    return modules[name]
  else
    return modules[name]
  end
end

---@param name string @Module name
---@return Module @Module reference
function ECSLoader:ImportModule(name)
  if not modules[name] then
    modules[name] = _CreateBlankModule()
    return modules[name]
  else
    return modules[name]
  end
end