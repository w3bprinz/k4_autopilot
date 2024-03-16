local autopilotEnabled = false
local isBlocked = false
local blipX = 0.0
local blipY = 0.0
local blipZ = 0.0

RegisterNetEvent("k4_autopilot:autopilotStart")
AddEventHandler("k4_autopilot:autopilotStart", function(source)
  local player = PlayerPedId()

  if IsPedInAnyVehicle(player) then
    local vehicle = GetVehiclePedIsIn(player, false)
    local vehicleClass = GetVehicleClass(vehicle)

    for _, blockedClass in ipairs(Config.BlockedVehicles) do
      if vehicleClass == blockedClass then
          isBlocked = true
          break
      end
    end

    if not isBlocked then

      local model = GetEntityModel(vehicle)
      local displaytext = GetDisplayNameFromVehicleModel(model)
      local blip = GetFirstBlipInfoId(8)

      if (blip ~= nil and blip ~= 0) then
          local coord = GetBlipCoords(blip)
          blipX = coord.x
          blipY = coord.y
          blipZ = coord.z
          TaskVehicleDriveToCoordLongrange(player, vehicle, blipX, blipY, blipZ, Config.AutopilotSpeed, 447, 2.0)
          autopilotEnabled = true
      else
          k4_Notification(Translate('no_destination'))
      end
    else
      k4_Notification(Translate('autopilot_blocked'))
    end
  else
    k4_Notification(Translate('not_in_vehicle'))
  end
end)

RegisterNetEvent("k4_autopilot:autopilotStop")
AddEventHandler("k4_autopilot:autopilotStop", function(source)
  local player = PlayerPedId()
  
  if IsPedInAnyVehicle(player) then
    local vehicle = GetVehiclePedIsIn(player, false)
    ClearPedTasks(player)
    SetVehicleForwardSpeed(vehicle, 19.0)
    Citizen.Wait(200)
    SetVehicleForwardSpeed(vehicle, 15.0)
    Citizen.Wait(200)
    SetVehicleForwardSpeed(vehicle, 11.0)
    Citizen.Wait(200)
    SetVehicleForwardSpeed(vehicle, 6.0)
    Citizen.Wait(200)
    SetVehicleForwardSpeed(vehicle, 0.0)
    k4_Notification(Translate('autopilot_disabled'))
    autopilotEnabled = false
  else
    k4_Notification(Translate('not_in_vehicle'))
  end
  
end)

RegisterNetEvent("k4_autopilot:triggerAutopilot")
AddEventHandler("k4_autopilot:triggerAutopilot", function(source)
  if not autopilotEnabled then
    TriggerEvent('k4_autopilot:autopilotStart')
  else 
    TriggerEvent('k4_autopilot:autopilotStop')
  end
end)

function k4_Notification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(200) -- no need to check it every frame
      if autopilotEnabled then
           local coords = GetEntityCoords(PlayerPedId())
           local blip = GetFirstBlipInfoId(8)
           local dist = Vdist(coords.x, coords.y, coords.z, blipX, blipY, coords.z)
           if dist <= 10 then
              local player = PlayerPedId()
              local vehicle = GetVehiclePedIsIn(player, false)
              ClearPedTasks(player)
              SetVehicleForwardSpeed(vehicle,19.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,15.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,11.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,6.0)
              Citizen.Wait(200)
              SetVehicleForwardSpeed(vehicle,0.0)
              k4_Notification(Translate('destination_reached'))
              autopilotEnabled = false
           end
      end
    end
end)

if not Config.ESXanimations then
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if IsControlJustReleased(0, 73) and IsUsingKeyboard(0) and not isDead then
        ClearPedTasks(PlayerPedId())
      end
    end
  end)
end