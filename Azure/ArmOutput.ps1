$ARMOutput = Get-VstsInput -Name "ARMOutputs" -Require

# ---- Output from ARM template is a JSON document
$JsonVars = $ARMOutput | ConvertFrom-Json

# ---- The outputs will be of type noteproperty, get a list of all of them
foreach ($OutputName in ($JsonVars | Get-Member -MemberType NoteProperty).name) {
    # ---- Get the type and value for each output
    $OutTypeValue = $JsonVars | Select-Object -ExpandProperty $OutputName
    $OutType = $OutTypeValue.type
    $OutValue = $OutTypeValue.value

    # Set Azure DevOps variable
    Write-Output "Setting $OutputName"
    Write-Output "##vso[task.setvariable variable=$OutputName;issecret=true]$OutValue"
}