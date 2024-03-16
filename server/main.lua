AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end
  print('^6[K4.dev]^7 Script ^6' .. resourceName .. '^7 has been started.')
end)

RegisterCommand("autopilot", function(source, args, raw)
    local src = source
    TriggerClientEvent("k4_autopilot:triggerAutopilot", src)
end)