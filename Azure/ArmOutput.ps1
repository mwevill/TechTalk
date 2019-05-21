
param (
    [Parameter(Mandatory=$true)][string]$ARMOutput
    )

#region Convert from json
$json = $ARMOutput | convertfrom-json
#endregion

foreach ($OutputName in ($json | Get-Member -MemberType NoteProperty).name) {
    # ---- Get the type and value for each output
    $OutTypeValue = $json | Select-Object -ExpandProperty $OutputName
    $OutType = $OutTypeValue.type
    $OutValue = $OutTypeValue.value

    # Set Azure DevOps variable
    Write-Output "Setting $OutputName"
    Write-Output "##vso[task.setvariable variable=$OutputName;issecret=true]$OutValue"
}