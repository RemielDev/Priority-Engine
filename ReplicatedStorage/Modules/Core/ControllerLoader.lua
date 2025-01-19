--[[

Similar to the modules loader but multithreaded to priority groups

The ControllerManager system initializes and executes ModuleScripts (controllers) 
	based on priority levels, organizing them into priority groups for concurrent execution 
	within each group to ensure structured and efficient initialization.
]]

local ControllerManager = {}

-- Declarations

local PriorityGroups = {}


function ControllerManager.run(Controllers)

	local Controllers = Controllers or script:GetDescendants()

	for index, controller in pairs(Controllers) do
		if controller:IsA("ModuleScript") then

			local initialization = require(controller)

			assert( type(initialization) == "table" )

			if initialization._ignored then
				continue
			end

			if not initialization.Priority then

				initialization.Priority = 5

			end

			local priority = initialization.Priority

			if not PriorityGroups[priority] then
				PriorityGroups[priority] = {}
			end

			table.insert(PriorityGroups[priority], initialization.run)

		end
	end
	
	--// MULTI-THREADING GROUPS
	
	-- create priority tables for missing groups
	for i = 0, 5, 1 do
		if not PriorityGroups[i] then
			PriorityGroups[i] = {}
		end
	end

	
	for i = 0, #PriorityGroups, 1 do -- Loop through groups
		
		if #PriorityGroups[i] > 0 then -- Check if group has controllers
			local threads = {} -- Create list to store running threads in priority group

			for index, run_function in pairs(PriorityGroups[i]) do -- loop through priority group run functions

				local co = coroutine.create(run_function) -- wrap run functions in coroutine thread
				threads[index] = co -- start thread
				coroutine.resume(co)
			end

			local completed_threads = 0 -- declare 0 int to count how many threads have been completed

			local thread_yield = coroutine.create(function() -- asynch function that will add to completed_threads for each completed function/thread
				while task.wait() do
					for _, thread in pairs(threads) do -- loop through stored threads
						if coroutine.status(thread) == "dead" then -- check if thread function is complete/ dead
							completed_threads += 1 -- initialize another completed thread to the completed_threads int by ++1
						end
					end
				end
			end)

			coroutine.resume(thread_yield) -- start thread checking asynchronously

			repeat task.wait() -- while checking the threads asynch, run a yield on the module

			until completed_threads >= #PriorityGroups[i] -- wait for the all the threads in the group to be completed

			coroutine.close(thread_yield) -- end asynch thread checker
			
			-- Continue to next priority group
			
		end
	end
end

return ControllerManager
