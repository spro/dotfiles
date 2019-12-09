-- Menubar utilities
--------------------------------------------------------------------------------

-- Bitcoin menubar item
-- Displays current price
-- Click to open Cryptowatch

btc_menuitem = hs.menubar.new()
last_price = nil
function updateBitcoinMenuitem()
    maiaCommand('what is the price of bitcoin', function(response)
        local price = response.response.price
        last_price = price
        btc_menuitem:setTitle(string.format("%.2f", price))
    end)
end

function clickBitcoinMenuitem()
    hs.urlevent.openURLWithBundle('https://cryptowat.ch/coinbase/btcusd/2h', 'com.google.chrome')
end

btc_menuitem:setClickCallback(clickBitcoinMenuitem)

hs.timer.doEvery(60*5, updateBitcoinMenuitem)

updateBitcoinMenuitem()

-- Office light menubar item 
-- Displays current status of office light (on or off)
-- Click to toggle status

light_menuitem = hs.menubar.new()
light_on = false

function toggleLight(cb)
    light_on = not light_on
    light_str = 'off'
    if light_on then
        light_str = 'on'
    end
    maiaCommand('turn the office light ' .. light_str, function(response)
        cb()
    end)
end

function updateLightMenuitem()
    maiaCommand('is the office light on?', function(response)
        print('got response', response, response.response.on)
        light_on = response.response.on
        if light_on then
            light_menuitem:setIcon(icons.lightbulb)
        else
            light_menuitem:setIcon(icons.lightbulb_off)
        end
    end)
end

function clickLightMenuitem()
    toggleLight(function()
        updateLightMenuitem()
    end)
end

light_menuitem:setClickCallback(clickLightMenuitem)

hs.timer.doEvery(60*30, updateLightMenuitem)

updateLightMenuitem()
