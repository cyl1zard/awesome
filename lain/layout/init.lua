
local wrequire     = require("lain.helpers").wrequire
local setmetatable = setmetatable

local layout       = { _NAME = "lain.layout" }

return setmetatable(layout, { __index = wrequire })
