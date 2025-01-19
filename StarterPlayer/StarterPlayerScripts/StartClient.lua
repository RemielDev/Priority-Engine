-- This script loads server and shared libraries/controllers


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Shared_Modules, Client_Modules = Modules:WaitForChild("Shared"):GetDescendants(), Modules:WaitForChild("Client"):GetDescendants()

local ClientControllers = ReplicatedStorage:WaitForChild("ClientControllers"):GetDescendants()

-- Refrence Library/Controllers Loader
local CoreModules = Modules:WaitForChild("Core")
local ModulesLoader = require(CoreModules:WaitForChild("ModulesLoader"))
local ControllersLoader = require(CoreModules:WaitForChild("ControllerLoader"))

-- Load the Libraries/Controllers

local _sharedModulesCache = ModulesLoader.LoadLibrary(Shared_Modules);
local _clientModulesCache = ModulesLoader.LoadLibrary(Client_Modules);

-- Run server controllers

ControllersLoader.run(ClientControllers)

