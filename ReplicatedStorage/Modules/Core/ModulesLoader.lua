--[[
The provided code consists of a module management system with two primary functionalities:

Global Import Function (_G.import): This function allows for the dynamic importation 
	of modules by name. It supports both single and multiple module imports. It checks 
	the internal ModulesCache for the requested modules, loads them if they are ModuleScript 
	objects and not already loaded, and returns them for use. If a module is not found, it raises an error.

ModulesManager LoadLibrary Function: This function is responsible for preloading and caching 
	libraries or individual modules into the ModulesCache. It ensures that each ModuleScript 
	is only loaded once to prevent duplicate loading, enhancing performance and resource management.
]]

local ModulesManager = {ModulesCache = {}}

function _G.import(modules)
	modules = type(modules) == "table" and modules or {modules}
	
	local returns = {}
	
	for _, module_name in pairs(modules) do
		
		local returning_module = ModulesManager.ModulesCache[module_name]
		
		if returning_module then
			
			if type(returning_module) ~= "table" and returning_module:IsA("ModuleScript") then
				returning_module = require(returning_module)
			end
			
			table.insert(returns, returning_module)
			
		else
			
			error(module_name.." not found in modules_cache")
			
		end

	end
	

	return unpack(returns)


end

function ModulesManager.LoadLibrary(library)
	
	local temporary_cache = {}

	-- check if ModuleList is table, if not transfer to tables

	if library then
		if type(library) ~= "table" then
			assert(library:IsA("ModuleScript"))
			library = {library}
		end
	end

	assert(library, "library not provided in ModulesManager.LoadList(library)")

	-- Add to cache incase modules use _G.import

	
	
	for i, _module in pairs(library) do

		if _module:isA("ModuleScript") then

			assert(not ModulesManager.ModulesCache[_module.Name], "duplicated module: ".._module.Name)

			temporary_cache[_module.Name] = _module

		end

	end

	-- Load

	for name, unloaded in pairs(temporary_cache) do
	
		ModulesManager.ModulesCache[name] = require(unloaded)
	end

	return

end


return ModulesManager
