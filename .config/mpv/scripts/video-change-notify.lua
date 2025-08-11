local msg = require 'mp.msg'
local utils = require 'mp.utils'

-- Function to send desktop notification
local function notify(title, text)
    -- Customize this to your system if you don't have notify-send
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

-- Optional: Adjust caching to preload better
mp.set_property("cache-secs", "30")        -- cache 30 seconds ahead
mp.set_property("demuxer-max-bytes", "50000000") -- ~50MB max demux buffer
mp.set_property("demuxer-max-back-bytes", "20000000") -- ~20MB buffer behind

