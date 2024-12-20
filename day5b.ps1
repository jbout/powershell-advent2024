$all = Get-Content .\day5.txt

$notAfter = @{}
$updates = New-Object System.Collections.ArrayList
$readRules = $true
foreach ($line in $all) {
    if ($line.Length -eq 0) {
        $readRules = $false
        continue
    }
    if ($readRules) {
        $rule = $line.Split("|")
        if (-not $notAfter.ContainsKey($rule[1])) {
            $notAfter[$rule[1]] = New-Object System.Collections.ArrayList
        }
        $notAfter[$rule[1]].Add($rule[0]) | Out-Null
    } else {
        $updates.Add($line) | Out-Null
    }
}

function hasIntersec {
    Param (
        $arr1,
        $arr2
    )
    $count = 0
    foreach($test in $arr1) {
        if ($arr2.Contains($test)) {
            return $true;
        }
    }
    return $false
}

function getIntersec {
    Param (
        $arr1,
        $arr2
    )
    $count = 0
    foreach($test in $arr1) {
        if ($arr2.Contains($test)) {
            return $true;
        }
    }
    return $false
}

function getMiddle {
    Param (
        $arr
    )
    return $arr[($arr.Count - 1) / 2]
}

function reorder {
    Param (
        $notAfter,
        $arr
    )
    $done = New-Object System.Collections.ArrayList
    $remaining = New-Object System.Collections.ArrayList
    $remaining.AddRange($arr)
    while ($remaining.Count -gt 0) {
        $element = $remaining[0]
        $remaining.RemoveAt(0)
        $ok = $true;
        if ($notAfter.ContainsKey($element)) {
            $pos = 0
            foreach($toTest in $remaining) {
                if ($notAfter[$element].Contains($toTest)) {
                    $ok = $false;
                    $remaining.Insert($pos+1, $element)
                    break;
                }
                $pos++
            }
        }
        if ($ok) {
            $done.Add($element) | out-null
        }
    }
    return $done.ToArray()
}


$count = 0
foreach ($line in $updates) {
    $list = $line.Split(",");
    $remaining = New-Object System.Collections.ArrayList
    $remaining.AddRange($list)
    $ok = $true
    while ($remaining.Count -gt 0) {
        $element = $remaining[0]
        $remaining.RemoveAt(0)
        if ($notAfter.ContainsKey($element)) {
            if (hasIntersec $notAfter[$element] $remaining) {
                $ok = $false;
                break;
            }
        }
    }
    if (-not $ok) {
        $corrected = reorder $notAfter $list
        write-host $($list -join " ") " to " $($corrected -join " ") " adding " $(getMiddle($corrected))
        $count += getMiddle($corrected)
    }
}
echo Total $count
