---@class ECSLoader
ECSLoader = {}

-- ["ModuleName"] = moduleReference
---@type table<string, Module>
local modules = {}

---@return Module @Module reference
local function _CreateBlankModule()
    ---@class Module
    local module = {}
    module.private = {}
    return module
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