$toFind = "XMAS"
[int[][]]$directions = (-1,0),(+1,0),(0,+1),(0,-1)
$maxX = $sample[0].Length
$maxY = $sample.Count

function testPos {
    param (
        [String[]] $field,
        [int] $x,
        [int] $y
    )
    $count = 0
    foreach ($dir in $directions) {
        $count += testPosDir $field $x $y $dir[0] $dir[1]
    }
    return $count
}

function testPosDir {
    param (
        [String[]] $field,
        [int] $x,
        [int] $y,
        [int] $dx,
        [int] $dy
    )
    if (
        ((getChar $field ($x)                     ($y)                     ) -ne "M") -or
        ((getChar $field ($x + ($dx * 2))         ($y + ($dy * 2))         ) -ne "M") -or
        ((getChar $field ($x + ($dx - $dy))       ($y + ($dx + $dy))       ) -ne "A") -or
        ((getChar $field ($x - ($dy * 2))         ($y + ($dx * 2))         ) -ne "S") -or
        ((getChar $field ($x + (($dx - $dy) * 2)) ($y + (($dx + $dy) * 2)) ) -ne "S")
    ) {
        return 0
    }
    echo "found at $x,$y in dir $dx,$dy"  >> c:\log.txt
    return 1;
}

function getChar {
    param (
        [String[]] $field,
        [int] $x,
        [int] $y
    )
    if (($x -lt 0) -or ($y -lt 0) -or ($x -ge $maxX) -or ($y -ge $maxY)) {
        return ""
    }
    return $field[$y][$x]
 }

[int]$count = 0
for ($x=0 ; $x -lt $maxX ; $x++) {
    for ($y=0 ; $y -lt $maxY ; $y++) {
        $count += testPos $sample $x $y
    }
}
$count