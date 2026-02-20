-- autocrop.lua
-- Automatically enables panscan to crop 16:9 video to 21:9 when in fullscreen.
require "mp.msg"

function check_and_apply_panscan()
    -- This function will run whenever fullscreen state changes or a new file is loaded.
    local is_fullscreen = mp.get_property_native("fullscreen")
    
    -- If we are not in fullscreen, make sure panscan is disabled and do nothing else.
    if not is_fullscreen then
        mp.set_property("panscan", 0.0)
        return
    end

    local video_aspect = mp.get_property_native("video-params/aspect")
    if not video_aspect then
        mp.msg.warn("Autocrop: Could not get video aspect ratio.")
        return
    end
    
    local screen_width = 3440
    local screen_height = 1440
    local screen_aspect = screen_width / screen_height

    mp.msg.info(string.format("Autocrop: Checking video (%.2f) against screen (%.2f) in fullscreen.", video_aspect, screen_aspect))

    -- Add a tolerance. If video is narrower than the screen, enable panscan.
    if video_aspect < (screen_aspect * 0.99) then
        mp.msg.info("Autocrop: Video is narrow, enabling panscan.")
        mp.set_property("panscan", 1.0)
        mp.osd_message("Autocrop: Enabled 21:9 panscan", 3)
    else
        -- If video is wide enough, ensure panscan is off.
        mp.msg.info("Autocrop: Video is not narrow, disabling panscan.")
        mp.set_property("panscan", 0.0)
    end
end

-- This function runs once when a new file is loaded.
-- It gives the player a moment to initialize before checking the state.
function on_new_file()
    mp.add_timeout(0.2, check_and_apply_panscan)
end

-- Register the functions to run on the correct events.
mp.register_event("file-loaded", on_new_file)
mp.observe_property("fullscreen", "native", check_and_apply_panscan)
