local Controller = {
	Priority = 0;
	_ignored = false;
}

--[[ Controller Description: 

]]

-- Initialization


function Controller.run()
	-- This is where code will run
	-- Yielding on the the run function will yield the continuation of loading the next priority threads until suspended/finished
	--     It will not yield threads on the same priority level

end

return Controller
