param (  
  [int] $debugLevel = 0
)

$arrOld = @(
    "aa"
    "ccc"
    "bb"
    "ddd"
    ""
    # "hh"
    "ii"
)
$arrNew = @(
    "ccc"
    "ee"
    "ddd"
    "ff"
    "gg"
)

$arrOld = $arrOld | Sort-Object -Unique | Where-Object {$_.Length -gt 0}
$arrNew = $arrNew | Sort-Object -Unique | Where-Object {$_.Length -gt 0}

$oldMax = $arrOld.count
$oldIdx = 0
$newMax = $arrNew.count
$newIdx = 0

$finalHash = [ordered]@{}

if ($debugLevel -ge 1) {
    Write-Output "DEBUG: oldMax=$($oldMax) newMax=$($newMax)"
}
while (($oldIdx -lt $oldMax) -and ($newIdx -lt $newMax)) {
    if ($debugLevel -ge 1) {
        Write-Output "DEBUG: oldIdx=$($oldIdx) newIdx=$($newIdx) oldVal=$($arrOld[$oldIdx]) newVal=$($arrNew[$newIdx])"
    }
    if ($arrOld[$oldIdx] -eq $arrNew[$NewIdx]) {
        if ($debugLevel -ge 2) {
            Write-Output "Match: $($arrOld[$oldIdx])"
        }
        $finalHash.Add($arrOld[$oldIdx],"Match")
        $oldIdx++
        $newIdx++
        continue
    }
    if ($arrOld[$oldIdx] -lt $arrNew[$NewIdx]) {
        if ($debugLevel -ge 2) {
            Write-Output "Not In New: $($arrOld[$oldIdx])"
        }
        $finalHash.Add($arrOld[$oldIdx],"NotInNew")
        $oldIdx++
        continue
    }
    if ($debugLevel -ge 2) {
        Write-Output "Not In Old: $($arrNew[$newIdx])"
    }
    $finalHash.Add($arrNew[$newIdx],"NotInOld")
    $newIdx++
}

for ($i = $oldIdx; $i -lt $oldMax; $i++) {
    if ($debugLevel -ge 2) {
        Write-Output "Not In New: $($arrOld[$i])"
    }
    $finalHash.Add($arrOld[$i],"NotInNew")
}
for ($i = $newIdx; $i -lt $newMax; $i++) {
    if ($debugLevel -ge 2) {
        Write-Output "Not In Old: $($arrNew[$i])"
    }
    $finalHash.Add($arrNew[$i],"NotInOld")
}

Write-Host "Final List:"
foreach ($key in $finalHash.Keys) {
    Write-Host "  - $key $($finalHash[$key])"
}