local display = false
local trecut = false
local cam1 = nil
local cam = nil
local gameplaycam = nil
incarcrusher = false
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP", "oxy_remat")
vRPccS = Tunnel.getInterface("oxy_remat", "oxy_remat")

local x, y, z = -1154.6042480469, -2716.0432128906, 19.887306213379

parkpos = { -1239.5611572266, -2895.1357421875, 13.938431739807 }

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(140, 140, 140, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

function job_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

Spawns = {
	[1] = { -979.05059814453, -3001.8859863281, 13.945061683655 },
	[2] = { -959.58239746094, -2969.2416992188, 13.944911956787 },
	[3] = { -1270.1726074219, -3389.2333984375, 13.940143585205 },
	[4] = { -1654.5528564453, -3145.90234375, 13.991992950439 }
}


Citizen.CreateThread(function()
	Wait(300)
	--SetDisplay(true)
	while true do

		tick = 500
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local ped = GetPlayerPed(-1)

		if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z, true) < 10.0) then
			tick = 0
			DrawText3D(x, y, z + 0.3, "~g~Job aviator", 2.0, 1)
			DrawMarker(7, x, y, z - 0.5, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 133, 133, 133, 255, true, 0, 0, true)
			if (GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 3) then
				DrawText3D(x, y, z + 0.5, "~g~Apasa E pentru a incepe job-ul!", 2.0, 1)
				if IsControlJustPressed(0, 38) then
					SetDisplay(true)
				end
			end
		end
		Citizen.Wait(tick)
	end
end)

delivery = { [1] = { 1719.7199707031, 3255.0456542969, 40.906280517578 },
	[2] = { 4510.8510742188, -4485.8823242188, 4.1861362457275 } }







vehs = { "Cuban800", "Luxor", "Nimbus", "Mammatus", "Velum", "Velum2", "Vestra", "Shamal" }


RegisterNUICallback("stlegal", function()
	SetDisplay(false)
	local ped = GetPlayerPed(-1)
	sppos = Spawns[math.random(1, #Spawns)]
	delivery = delivery[math.random(1, #delivery)]

	local mhash = GetHashKey(vehs[math.random(1, #vehs)])

	local i = 0
	DoScreenFadeOut(2000)
	Wait(3000)
	while not HasModelLoaded(mhash) and i < 10000 do
		RequestModel(mhash)
		Citizen.Wait(10)
		i = i + 1
	end
	nveh = CreateVehicle(mhash, sppos[1], sppos[2], sppos[3] + 0.5, 0.0, true, false)
	SetPedIntoVehicle(GetPlayerPed(-1), nveh, -1)
	SetNewWaypoint(delivery[1], delivery[2])
	notify("Ai setat locatia unde trebuie sa te duci!")

	pos = GetEntityCoords(GetPlayerPed(-1), true)
	Wait(3000)
	EndFade()
	damaged = false
	while ((GetDistanceBetweenCoords(delivery[1], delivery[2], delivery[3], pos.x, pos.y, pos.z, true) > 5) or
		GetEntitySpeed(nveh) < 1) and damaged == false do
		pos = GetEntityCoords(GetPlayerPed(-1), true)

		Wait(0)
		DrawText3D(delivery[1], delivery[2], delivery[3] + 0.5, "~g~Loc Livrare!", 2.0, 1)

		if GetEntityHealth(nveh) < 570 then
			notify("Ai stricat avionul!")
			SetEntityHealth(GetPlayerPed(-1), 200)
			DoScreenFadeOut(2000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			Wait(3000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			DeleteEntity(nveh)
			SetEntityCoords(GetPlayerPed(-1), -1154.6042480469, -2716.0432128906, 19.887306213379, 1, 0, 0, 1)
			SetEntityHealth(GetPlayerPed(-1), 200)
			Wait(3000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			EndFade()
			damaged = true
		end
	end

	DoScreenFadeOut(2000)
	Wait(3000)
	notify("Ai livrat cu succes, acum returneaza avionul!")
	Wait(3000)
	EndFade()
	SetNewWaypoint(parkpos[1], parkpos[2])
	while ((GetDistanceBetweenCoords(parkpos[1], parkpos[2], parkpos[3], pos.x, pos.y, pos.z, true) > 5) or
		GetEntitySpeed(nveh) < 1) and damaged == false do
		pos = GetEntityCoords(GetPlayerPed(-1), true)

		Wait(0)
		DrawText3D(parkpos[1], parkpos[2], parkpos[3] + 0.5, "~g~Loc returnare avion!", 2.0, 1)

		if GetEntityHealth(nveh) < 570 then
			notify("Ai stricat avionul!")
			SetEntityHealth(GetPlayerPed(-1), 200)
			DoScreenFadeOut(2000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			Wait(3000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			DeleteEntity(nveh)
			SetEntityCoords(GetPlayerPed(-1), -1154.6042480469, -2716.0432128906, 19.887306213379, 1, 0, 0, 1)
			SetEntityHealth(GetPlayerPed(-1), 200)
			Wait(3000)
			SetEntityHealth(GetPlayerPed(-1), 200)
			EndFade()
			damaged = true
		end
	end
	if damaged == false then
		notify("Ai returnat avionul cu succes!")
		DoScreenFadeOut(2000)
		Wait(3000)
		DeleteEntity(nveh)
		SetEntityCoords(GetPlayerPed(-1), -1154.6042480469, -2716.0432128906, 19.887306213379, 1, 0, 0, 1)
		TriggerServerEvent("payforit")
		Wait(3000)
		EndFade()
	end
end)

RegisterNUICallback("stilegal", function(data)
	SetDisplay(false)
end)








--very important cb
RegisterNUICallback("exit", function(data)
	TriggerEvent("iesi")
	SetDisplay(false)
end)



RegisterNUICallback("error", function(data)
	chat(data.error, { 255, 0, 0 })
	SetDisplay(false)
end)

function SetDisplay(bool)
	display = bool
	SetNuiFocus(bool, bool)
	SendNUIMessage({
		type = "ui",
		status = bool,
	})

end

function notify(string)
	vRP.notify({ string })
end

function EndFade()
	Citizen.CreateThread(function()
		ShutdownLoadingScreen()

		DoScreenFadeIn(1500)

		while IsScreenFadingIn() do
			Citizen.Wait(0)
		end
	end)
end
