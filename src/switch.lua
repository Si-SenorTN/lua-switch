local function switch(value)
	local switchObj = {}
	local haultedExecution = false
	local defaultConsumed = false

	local function transformer(newValue)
		value = newValue
		return newValue
	end

	function switchObj:case(testingValue: any, callback: boolean?)
		if not haultedExecution and testingValue == value then
			local result = callback(transformer)

			if result == true then
				haultedExecution = true
			end
		end

		return switchObj
	end

	function switchObj:default(callback)
		if defaultConsumed then
			error("default option was already consumed in the switch statement", 2)
		end
		defaultConsumed = true

		if not haultedExecution then
			local result = callback()

			if result == true then
				haultedExecution = true
			end
		end

		return switchObj
	end
end

return switch