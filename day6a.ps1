$map = Get-Content .\day6.txt
$maxX = $map[0].Length
$maxY = $map.Count

[int[][]]$directions = (0,-1),(1,0),(0,1),(-1,0)
$currentDir = 0
$flags = New-Object 'bool[,]' $maxX, $maxY

for ($x = 0; $x -lt $maxX; $x++) {
    for ($y = 0; $y -lt $maxY; $y++) {
        if ($map[$y][$x] -eq "^") {
            $currentPos = ($x, $y)
        }
    }
}


$inside = $true;
while ($inside) {
    $flags[$currentPos[0],$currentPos[1]] = $true
    $nextPos = ($($currentPos[0] + $directions[$currentDir][0]), $($currentPos[1] + $directions[$currentDir][1]))
    if ($nextPos[0] -lt 0 -or $nextPos[0] -ge $maxX -or $nextPos[1] -lt 0 -or $nextPos[1] -ge $maxY) {
        $inside = $false;
        break;
    }
    if ($map[$nextPos[1]][$nextPos[0]] -eq '#') {
        #wall
        $currentDir = ($currentDir + 1) % 4
    } else {
        $currentPos = $nextPos
    }
    #write-host $nextPos[0],$nextPos[1]  facing $currentDir
}

$count = 0
foreach ($flag in $flags) {
    if ($flag) {
        $count ++;
    }
}
echo $count