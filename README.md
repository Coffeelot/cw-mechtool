# Mechanic Tool 🤳🔧

### **See the script in action on [Sundown RP](https://discord.gg/CZNh8kcSGK) 🌆**
A companion tool for [CW-PERFORMANCE](https://github.com/Coffeelot/cw-performance). This is what we use on Sundown as the go to mechanic tool and used for some other stuff. Mainly used for enabling a performance overlay (and opening renzu stancer if you use that). You can toggle if the script requires jobs to be used in the config.

The repo includes one item, an [OBD scanner](https://rollr.io/blog/what-obd-scanner-why-you-need-one/#:~:text=Auto%20mechanics%20are%20able%20to,or%20change%20in%20oxygen%20levels) (you can rename this and change it to whatever that matches in the Config). Two extra images are included if you want variants, but the Inventory stuff isn't included here. We use them as loot + tool for hotwiring modern cars. You can figure that out yourself. 

Made for OX inventory, QB might work also but we have no idea if it does cause we're too lazy to try. You can change which inventory it uses in the config

# Preview 📽
[![YOUTUBE VIDEO](http://img.youtube.com/vi/aAG3tMogf04/0.jpg)](https://youtu.be/aAG3tMogf04)

# Developed by Coffeelot and Wuggie
[More scripts by us](https://github.com/stars/Coffeelot/lists/cw-scripts)  👈

**Support, updates and script previews**:

[![Join The discord!](https://cdn.discordapp.com/attachments/977876510620909579/1013102122985857064/discordJoin.png)](https://discord.gg/FJY4mtjaKr )

**All our scripts are and will remain free**. If you want to support what we do, you can buy us a coffee here:

[![Buy Us a Coffee](https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg)](https://www.buymeacoffee.com/cwscriptbois )

# Setup 🔧

This is kinda useless without [CW-PERFORMANCE](https://github.com/Coffeelot/cw-performance).

Also has a button to open [Renzu Stancer](https://github.com/renzuzu/renzu_stancer) by default. You'll either have to remove/change that option or get this script.

## QB INV ❗📦
Items to add to qb-core>shared>items.lua 
```
	-- CW mechtool
	["obd_scanner"] =          {["name"] = "obd_scanner",         ["label"] = "OBD Scanner",                  ["weight"] = 300, ["type"] = "item", ["image"] = "obd_scanner.png", ["unique"] = false, ["useable"] = true, ['shouldClose'] = false, ["combinable"] = nil, ["description"] = "A tool used by mechanics to diagnose vehicles"},
```

## OX INV ❗📦
This one has a degrade of about 2 weeks. So users will need to buy new ones

```
	['obd_scanner'] = {
		label = 'OBD scanner',
		weight = 100,
		stack = true,
		close = false,
		allowArmed = true,
		description = "A tool used by mechanics to diagnose vehicles"
	},
```
