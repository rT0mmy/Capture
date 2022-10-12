<div align="center">
	<h1>Capture</h1>
	<p> Lightweight Luau userinput capture and cleanup</p>
  
  ![Luau](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
  <br><br>
  Made by TommyRBLX
  
  <img src="https://img.shields.io/github/forks/rT0mmy/Capture?style=for-the-badge">

  <img src="https://img.shields.io/github/stars/rT0mmy/Capture?style=for-the-badge">

  <img src="https://img.shields.io/github/issues/rT0mmy/Capture?style=for-the-badge">

  <img src="https://img.shields.io/github/issues-pr/rT0mmy/Capture?style=for-the-badge">

  <img src="https://img.shields.io/github/license/rT0mmy/Capture?style=for-the-badge">
</div>

<br><br><br><br>

> **Warning** <br>
> Capture is still under development, major changes might occur.

> **Note** <br>
> This implementation does not feature maids, all scriptevents are handled by a separate API - [Event](https://github.com/rT0mmy/event)

<br><br><br><br>

## Why Capture?

Capture is a lightweight and easy to use UserInputService wrapper.

<br><br><br><br>

## API

```lua
local Capture = require(...)
```

<br><br>

```lua
Capture.KeyName -> Key
```
```lua
Capture.A
```

> Creates a new ```Key```

<br><br>

```lua
Key:Connect(f:()->any) -> Connection
```
```lua
Capture.A:Connect(function() print("Pressed A") end)
```

> Creates and returns a new ```Connection``` for ```Key```

<br><br>

```lua
Key:Bind(KeyName: string|Enum.KeyCode) -> Connection
```
```lua
Capture.A:Bind('F')
```

> Rebinds ```Key``` to a new ```KeyName```

<br><br>

```lua
Connection:Disconnect() -> nil
```
```lua
local Connection = Capture.A:Connect(...)
Connection:Disconnect()
```

> Disconnects the ```Connection``` Object for ```Key```

<br><br>

```lua
Key:Destroy() -> nil
```
```lua
Capture.A:Connect(function() print("Pressed A") end):Destroy()
```

> Destroys the ```Key``` Object and all it's ```Connection```s

## API Demo


```lua
local Capture = require(...)


local APress = Capture.A:Connect(function()
	warn('Pressed A')
end)

Capture.A:Bind('M')

Capture.W:Connect(function()
	warn('Pressed W')
end)

Capture.D:Connect(function()
	warn('Pressed D')
end)

APress:Disconnect()

warn(Capture.Keys)
```


