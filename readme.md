# lua-switch

<!--
<img align="right" src="docs/images/switch_icon.svg" width="120em" style="margin-left: 2em">
-->

# Usage
lua switch works similarly to the [javascript version](https://www.w3schools.com/js/js_switch.asp) of the switch statement.

its syntax is similar to the [lua implementation of promises](https://github.com/evaera/roblox-lua-promise)

```lua
local switch = require(somewhere.switch)
local randomValue = 45

switch(randomValue)
	:case(45, function()
		print("this prints")
	end)
	:case(12, function()
		print("this will never print")
	end)
	:default(function()
		print("this will always print")
	end)
```

As it's shown, switch statements are very similar to if statements. `case` uses the `==` operator to compare values. If a match is made the callback function runs. `default` runs no matter what, as long as the switch execution isnt haulted before it's chained, which we will cover next.

```lua
switch(1)
	:case(1, function()
		return true
	end)
	:case(1, function()
		error("we never reach this point")
	end)
	:default(function()
		error("we never reach this point either")
	end)

switch(1)
	:default(function()
		print("position in the chain matters")
		return true
	end)
	:case(1, function()
		error("we never reach this point")
	end)
```

by returning `true` within a case callback, the switch execution will then be haulted. `default` blocks work identically to cases in the sense that returning true will hault the execution

*unlike javascript, omitting the return statement does **not** execute the next case regardless of evaluation*

Something different than javascript is switched values can be transformed. Lets revisit the first example and this time use our transformer function to see if we can get a different result.

```lua
local randomValue = 45

switch(randomValue)
	:case(45, function(transform)
		print("this prints")
		local newValue = transform(12)
		-- the transformer function also returns the new transformed value
	end)
	:case(12, function()
		print("this will print now")
	end)
	:default(function()
		print("this will always print")
	end)
```

By chaining our cases, we will vist each case in order testing our value, making the transformer function valuable for downstream cases.

*the transformer function is not present for use within a default block*