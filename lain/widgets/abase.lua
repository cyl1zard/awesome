
local helpers      = require("lain.helpers")
local wibox        = require("wibox")
local setmetatable = setmetatable

-- Basic template for custom widgets (asynchronous version)
-- lain.widgets.abase

local function worker(args)
    local abase     = helpers.make_widget_textbox()
    local args      = args or {}
    local timeout   = args.timeout or 5
    local nostart   = args.nostart or false
    local stoppable = args.stoppable or false
    local cmd       = args.cmd or ""
    local settings  = args.settings or function() end

    function abase.update()
        helpers.async(cmd, function(f)
            output = f
            if output ~= abase.prev then
                widget = abase.widget
                settings()
                abase.prev = output
            end
        end)
    end

    abase.timer = helpers.newtimer(cmd, timeout, abase.update, nostart, stoppable)

    return setmetatable(abase, { __index = abase.widget })
end

return setmetatable({}, { __call = function(_, ...) return worker(...) end })
