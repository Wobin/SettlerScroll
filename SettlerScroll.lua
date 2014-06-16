-----------------------------------------------------------------------------------------------
-- Client Lua Script for SettlerScroll
-- Copyright (c) Wobin. All rights reserved
--
--
-- Thus, the queue itself will be the chiefest, shall be servant to the captain of the children 
-- of Israel, and all the various operations that we took as “primitive” in our discussion of 
-- compound data objects
--
--                      A reading from the Book of Markov - Chapter 21 Verses 2-14 
--                      Structure and Interpretation of Computer Programs - King James Version
--                                                                  http://tinyurl.com/o339h4m
-----------------------------------------------------------------------------------------------
 
require "Window"
 
local Container = {
					AnchorOffsets = { 224, 18, -30, -29 },
					AnchorPoints = { 0, 0, 1, 1 },
					RelativeToClient = true, 
					Template = "Control", 
					Name = "SelectionItemContainerCover", 					
					VScroll = true,				-- We don't want to be able to zoom camera at the same time	
					IgnoreMouse = true, 		-- Or block the buttons			
					Events = {
						MouseWheel = function(...) SettlerScroll:MouseWheel(...) end
					},
				}

-----------------------------------------------------------------------------------------------
-- SettlerScroll Module Definition
-----------------------------------------------------------------------------------------------
local bHasConfigureFunction = false	
local tDependencies = {"BuildMap", "Gemini:GUI-1.0"}	

SettlerScroll = Apollo.GetPackage("Gemini:Addon-1.1").tPackage:NewAddon("SettlerScroll", bHasConfigureFunction, tDependencies, "Gemini:Hook-1.0")


-----------------------------------------------------------------------------------------------
-- SettlerScroll OnLoad
-----------------------------------------------------------------------------------------------
function SettlerScroll:OnInitialize()  	
    self.Build = Apollo.GetAddon("BuildMap")
    self:PostHook(self.Build, "OnInvokeSettlerBuild")
end

local Scroll, Range

function SettlerScroll:MouseWheel(...)
	local nane, wndHandler, wndControl, nLastRelativeMouseX, nLastRelativeMouseY, fScrollAmount, bConsumeMouseWheel = ...
	if fScrollAmount < 0 then 
		-- scroll to the left to the left
		Scroll:SetHScrollPos(Scroll:GetHScrollPos() + Range/4)
	else
		-- scroll to the right
		Scroll:SetHScrollPos(Scroll:GetHScrollPos() - Range/4)
	end
end

function SettlerScroll:OnInvokeSettlerBuild(...)
    Scroll = self.Build.wndMain:FindChild("SelectionItemContainer")    
    local scrollContainer = Apollo.GetPackage("Gemini:GUI-1.0").tPackage:Create(Container):GetInstance(self, Scroll:GetParent())    
    scrollContainer:Show(true)
    Range = Scroll:GetHScrollRange()  	
end

