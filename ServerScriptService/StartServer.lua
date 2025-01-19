-- This script loads server and shared libraries/controllers


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService('ServerStorage')

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Server_Modules, Shared_Modules = ServerStorage:WaitForChild("ServerModules"):GetDescendants(), Modules:WaitForChild("Shared"):GetDescendants()

local ServerControllers = ServerStorage:WaitForChild("ServerControllers"):GetDescendants()

-- Refrence Library/Controllers Loader
local CoreModules = Modules:WaitForChild("Core")
local ModulesLoader = require(CoreModules:WaitForChild("ModulesLoader"))
local ControllersLoader = require(CoreModules:WaitForChild("ControllerLoader"))

-- Load the Libraries/Controllers

local _sharedModulesCache = ModulesLoader.LoadLibrary(Shared_Modules);
local _serverModulesCache = ModulesLoader.LoadLibrary(Server_Modules);

-- Run server controllers

ControllersLoader.run(ServerControllers)

