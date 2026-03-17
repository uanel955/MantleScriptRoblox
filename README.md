# Roblox Character Setup and Mantle System

A modular Luau system for Roblox that standardizes player avatars and adds a smooth parkour mantle mechanic.

## 🚀 Features

### 1. Character Stylization
* [cite_start]**Automatic Conversion:** Automatically removes clothing, accessories, and face decals when a player spawns[cite: 1].
* [cite_start]**Uniform Aesthetic:** Colors all body parts red and changes the material to `SmoothPlastic`[cite: 1].
* [cite_start]**Head Preservation:** Strips `DataModelMesh` instances from the body but specifically leaves the Head mesh intact so it stays round[cite: 1, 2].

### 2. Parkour Mantle System
* [cite_start]**Raycast Detection:** Uses forward and downward raycasts to accurately detect ledges[cite: 3].
* [cite_start]**Smooth Motion:** Uses `TweenService` to animate the arms reaching up and pulling the body onto the ledge[cite: 3, 4].
* [cite_start]**Input Context:** Triggered by pressing the `Space` key while the character is in the `Freefall` or `Jumping` state[cite: 5].

## 🛠️ Installation

1. **Server Setup (`CharacterSetup.luau`):**
   * [cite_start]Place this script inside `ServerScriptService`[cite: 1].
2. **Client Setup (`MantleScript.luau`):**
   * [cite_start]Place this LocalScript inside `StarterPlayer > StarterCharacterScripts`[cite: 3].

## 🎮 How to Use
* Jump toward a ledge.
* [cite_start]Press **Space** again while in mid-air to mantle onto the surface[cite: 5].
