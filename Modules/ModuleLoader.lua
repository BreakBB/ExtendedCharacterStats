---@class ECSLoader
ECSLoader = {}

---@class Module
---@field public private table -- TODO: We need to re-think the "private" module part

---@type table<string, Module>
local modules = {}

---@generic T : Module
---@param name `T` @Module name
---@return T @Module reference
function ECSLoader:CreateModule(name)
  if not modules[name] then
    modules[name] = { private = {} }
    return modules[name]
  else
    return modules[name]
  end
end

---@generic T : Module
---@param name `T` @Module name
---@return T @Module reference
function ECSLoader:ImportModule(name)
  if not modules[name] then
    modules[name] = { private = {} }
    return modules[name]
  else
    return modules[name]
  end
end