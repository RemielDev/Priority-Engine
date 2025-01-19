# Priority-Engine

## What is it?
A simple Roblox framework module/controller loader which is designed to streamline and organize the process of initializing and managing game components, ensuring a smooth and efficient game operation. The loader operates in two primary phases: module initialization and controller loading; with the added functionality of _G.import().

## Module Initialization
In the first phase, the loader starts by initializing modules, which are foundational elements containing reusable code that can be employed across various parts of the game. These modules might include libraries, utilities, or any standalone functionalities that do not directly interact with the game’s client or server scripts but provide essential services or data structures required by the controllers.

## Controller Loading
Following the module initialization, the loader transitions to handling controllers. Controllers are more specialized scripts that directly manage the game’s logic and interactions, divided into client and server categories to respect the game’s networking model. The client controllers handle the user interface, input, and other client-side functionalities, while the server controllers manage game states, player data, and other server-side operations.

## Priority aka Dependencies
The loader is designed to consider priorities during the controller loading phase. This means that controllers that are marked as different priorities (0, 1, 2, 3…) will run on grouped threads and will yield until threads are completed before continuing to the next priority group. This dependency management ensures that any controller relying on the functionalities or data provided by another controller will only be loaded once its previous priorities have been satisfied, preventing errors and ensuring a coherent load order.

## `_G.import` Functionality
The _G.import function can accept either a list of module names or a specific module name as its argument. This flexibility allows developers to either bulk-import multiple modules in a single call or retrieve a specific module as needed, thereby catering to various use cases and improving code organization.

## Usage in Modules and Controllers
When invoked within a module or a controller, _G.import dynamically searches for the specified modules within the cached loaded modules. This search mechanism is intelligent enough to differentiate between client-side and server-side modules, ensuring that only the appropriate modules are loaded depending on the context in which _G.import is called.
`_G.import({"module1", "module2"} or "module1") : returning unpacked table of requested modules.`

## Benefits
The introduction of _G.import in the framework offers several key benefits:

- Enhanced Code Reusability: By facilitating easy access to shared modules, _G.import encourages code reusability, allowing developers to write more modular and maintainable code.
- Improved Project Organization: Centralizing module imports through a single function helps maintain a cleaner and more organized codebase, making it easier to manage complex projects.
- Streamlined Development Workflow: The ability to import multiple modules or specific modules as needed simplifies the development workflow, enabling developers to focus more on building features and less on writing module paths.
## Outcome
The result is a structured and efficient loading process that ensures all game components are initialized and ready in a logical order, enhancing the game’s performance and reliability. By separating the initialization of modules from the loading of controllers and respecting priorities and dependencies, the framework provides a robust foundation for building complex and scalable Roblox games.
