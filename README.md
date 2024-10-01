# Mechanic Tool 🤳🔧

This is what we use on Sundown as the go to mechanic tool and used for some other stuff. Mainly used for enabling a performance overlay (and opening renzu stancer if you use that). You can toggle if the script requires jobs to be used in the config.

The repo includes one item, an [OBD scanner](https://rollr.io/blog/what-obd-scanner-why-you-need-one/#:~:text=Auto%20mechanics%20are%20able%20to,or%20change%20in%20oxygen%20levels) (you can rename this and change it to whatever that matches in the Config). Two extra images are included if you want variants, but the Inventory stuff isn't included here. We use them as loot + tool for hotwiring modern cars. You can figure that out yourself. 

Made for OX inventory, QB might work also but we have no idea if it does cause we're too lazy to try. You can change which inventory it uses in the config

# Preview 📽
[![YOUTUBE VIDEO](http://img.youtube.com/vi/H5hmJkF5dtI/0.jpg)](https://youtu.be/H5hmJkF5dtI)

# Links
### ⭐ Check out our [Tebex store](https://cw-scripts.tebex.io/category/2523396) for some cheap scripts ⭐


### [More free scripts](https://github.com/stars/Coffeelot/lists/cw-scripts)  👈

### Support, updates and script previews:

<a href="https://discord.gg/FJY4mtjaKr"> <img src="https://media.discordapp.net/attachments/1202695794537537568/1285652389080334337/discord.png?ex=66eb0c97&is=66e9bb17&hm=b1b2c17715f169f57cf646bb9785b0bf833b2e4037ef47609100ec8e902371df&=&format=webp" width="200"></a>


### If you want to support what we do, you can buy us a coffee here:

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
		description = "A tool used by mechanics to diagnose vehicles"
	},
```
