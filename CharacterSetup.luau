-- ServerScriptService > CharacterSetup

local Players = game:GetService("Players")

local RED = Color3.fromRGB(210, 40, 40)

local BODY_PARTS = {
	"Head",
	"Torso",
	"Left Arm",
	"Right Arm",
	"Left Leg",
	"Right Leg",
}

local function cleanAndColorCharacter(character)
	-- Remove clothing, accessories, etc.
	for _, obj in ipairs(character:GetChildren()) do
		if obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("ShirtGraphic") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") then
			obj:Destroy()
		end
	end

	-- Remove face decals
	local head = character:FindFirstChild("Head")
	if head then
		for _, child in ipairs(head:GetChildren()) do
			if child:IsA("Decal") or child:IsA("Texture") then
				child:Destroy()
			end
		end
	end

	-- Color parts and remove meshes
	for _, partName in ipairs(BODY_PARTS) do
		local part = character:FindFirstChild(partName)
		if part and part:IsA("BasePart") then
			-- Strip special meshes ONLY from the body, leave the Head mesh so it stays round
			if part.Name ~= "Head" then
				for _, child in ipairs(part:GetChildren()) do
					if child:IsA("DataModelMesh") then
						child:Destroy()
					end
				end
			end

			part.Color = RED
			part.Material = Enum.Material.SmoothPlastic
			part.CastShadow = true
		end
	end
end

local function onPlayerAdded(player)
	player.CharacterAppearanceLoaded:Connect(function(character)
		cleanAndColorCharacter(character)
	end)
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in ipairs(Players:GetPlayers()) do
	onPlayerAdded(player)
end