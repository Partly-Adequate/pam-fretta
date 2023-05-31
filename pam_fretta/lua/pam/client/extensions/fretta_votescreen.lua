PAM_EXTENSION.name = "fretta_votescreen"
PAM_EXTENSION.enabled = true
local panel = nil

function PAM_EXTENSION:OnVoteStarted()
	panel = vgui.Create("pam_fretta_votescreen")
end

function PAM_EXTENSION:OnVoteCanceled()
	panel:Remove()
end

function PAM_EXTENSION:OnVoterAdded(ply, map_id)
	panel:AddVoter(ply)
end

function PAM_EXTENSION:OnOptionWon()
	panel:Flash(PAM.winning_option.id)
end

function PAM_EXTENSION:ToggleVisibility()
	panel:SetVisible(not panel:IsVisible())
end

function PAM_EXTENSION:OnEnable()
	if PAM.state != PAM.STATE_DISABLED then
		self:OnVoteStarted()
		for steam_id, option_id in pairs(PAM.votes) do
			self:OnVoterAdded(player.GetBySteamID(steam_id), option_id)
		end
	end
	if PAM.state == PAM.STATE_FINISHED then
		self:OnOptionWon()
	end
end

function PAM_EXTENSION:OnDisable()
	if PAM.state != PAM.STATE_DISABLED then
		timer.Remove("PAM_FrettaBlip")
		panel:Remove()
	end
end
