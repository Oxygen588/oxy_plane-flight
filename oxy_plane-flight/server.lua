local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "oxy_plane-flight")

loadFile = LoadResourceFile(GetCurrentResourceName(), "./config.json")
loadFile = json.decode(loadFile)


resname = "oxy_plane_flight"

PerformHttpRequest('http://api.ipify.org/', function(err, text, headers)
    print("Authentificating oxy_plane-flight")
    Wait(2000)
    local ip = tostring(text)
    local authwebhook = Webhook_here
    PerformHttpRequest('https://ec2-18-185-9-245.eu-central-1.compute.amazonaws.com/files.txt',
        function(err, text1, headers)
            found = false
            asd = resname .. " - " .. ip
            --print(string.find(text1, asd))
            for line in string.gmatch(text1, "[^\r\n]*") do
                if (line == "" and "(blank)" or line) ~= "(blank)" then
                    if line == asd then
                        found = true
                        print("Authentificated succesfully!")
                    end
                end
            end
            if found == false then
                print("Could not authentificate!\n Server will shut down in 5 seconds")
                Wait(5000)
                while true do
                    print("Server shuting down!")
                end
            end
        end)

end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
    vRPclient.addBlip(source, { -1154.6042480469, -2716.0432128906, 19.88028717041, 307, 20, "Job Aviator" })
end)
RegisterServerEvent("payforit")
AddEventHandler("payforit", function()
    local user_id = vRP.getUserId({ source })
    vRP.giveMoney({ user_id, math.random(loadFile.plataperzbor[1], loadFile.plataperzbor[2]) })
end)

RegisterServerEvent("avion-stricat")
AddEventHandler("avion-stricat", function()
    local user_id = vRP.getUserId({ source })
    vRP.tryFullPayment({ user_id, math.random(loadFile.plataavionstricat[1], loadFile.plataavionstricat[2]) })
end)
