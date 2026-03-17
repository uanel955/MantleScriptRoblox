-- StarterPlayer > StarterCharacterScripts > MantleScript

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local torso = character:WaitForChild("Torso")

-- Grab the shoulder joints so we can animate them
local leftShoulder = torso:WaitForChild("Left Shoulder")
local rightShoulder = torso:WaitForChild("Right Shoulder")

-- Save their default resting positions
local origLeftC0 = leftShoulder.C0
local origRightC0 = rightShoulder.C0

local isMantling = false

local function attemptMantle()
	if isMantling then return end

	local params = RaycastParams.new()
	params.FilterDescendantsInstances = {character}
	params.FilterType = Enum.RaycastFilterType.Exclude

	local forwardRay = workspace:Raycast(rootPart.Position, rootPart.CFrame.LookVector * 3, params)

	if forwardRay then
		local topOrigin = forwardRay.Position + Vector3.new(0, 5, 0) + (rootPart.CFrame.LookVector * 1.5)
		local downRay = workspace:Raycast(topOrigin, Vector3.new(0, -6, 0), params)

		if downRay then
			isMantling = true

			rootPart.AssemblyLinearVelocity = Vector3.zero
			rootPart.Anchored = true

			local targetPosition = downRay.Position + Vector3.new(0, 3, 0)
			local targetCFrame = CFrame.new(targetPosition, targetPosition + rootPart.CFrame.LookVector)
			-- 1. ANIMATE ARMS UP (Reach for the ledge)
			local armTweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			-- Rotate on the Z-axis instead of X! One is negative, one is positive.
			local leftArmUp = TweenService:Create(leftShoulder, armTweenInfo, {C0 = origLeftC0 * CFrame.Angles(0, 0, math.rad(-150))})
			local rightArmUp = TweenService:Create(rightShoulder, armTweenInfo, {C0 = origRightC0 * CFrame.Angles(0, 0, math.rad(150))})

			leftArmUp:Play()
			rightArmUp:Play()

			-- Wait a split second for the arms to swing up
			task.wait(0.1)

			-- 2. PULL THE BODY UP
			local bodyTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			local bodyTween = TweenService:Create(rootPart, bodyTweenInfo, {CFrame = targetCFrame})

			bodyTween:Play()
			bodyTween.Completed:Wait()

			-- 3. ANIMATE ARMS BACK DOWN
			local armDownInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			TweenService:Create(leftShoulder, armDownInfo, {C0 = origLeftC0}):Play()
			TweenService:Create(rightShoulder, armDownInfo, {C0 = origRightC0}):Play()

			rootPart.Anchored = false
			task.wait(0.2) 
			isMantling = false
		end
	end
end

UserInputService.InputBegan:Connect(function(input)
	if UserInputService:GetFocusedTextBox() then return end

	if input.KeyCode == Enum.KeyCode.Space then
		local currentState = humanoid:GetState()
		if currentState == Enum.HumanoidStateType.Freefall or currentState == Enum.HumanoidStateType.Jumping then
			attemptMantle()
		end
	end
end)