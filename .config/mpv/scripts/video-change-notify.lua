local msg = require 'mp.msg'
local utils = require 'mp.utils'

-- Function to send desktop notification
local function notify(title, text)
    local args = {"notify-send", title, text}
    utils.subprocess({args = args})
end

-- Show notification on video loaded
mp.register_event("file-loaded", function()
    local path = mp.get_property("path")
    local title = mp.get_property("media-title") or "Unknown title"
    msg.info("Now playing: " .. title)
    notify("Now Playing", title)
end)


