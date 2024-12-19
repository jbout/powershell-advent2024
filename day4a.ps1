$toFind = "XMAS"
[int[][]]$directions = (-1,-1),(-1,0),(-1,1),(0,-1),(0,1),(1,-1),(1,0),(1,1)
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
    for ($i=0 ; $i -lt $toFind.Length ; $i++) {
        if (
            ($x + ($dx * $i) -ge 0) -and
            ($y + ($dy * $i) -ge 0) -and
            ($x + ($dx * $i) -lt $maxX) -and
            ($y + ($dy * $i) -lt $maxY) -and
            ((getChar $field ($x + ($dx * $i)) ($y + ($dy * $i))) -ne $toFind[$i])
        ) {
            #$test = (getChar $field ($x + ($dx * $i)) ($y + ($dy * $i)))
            #echo "failed at ($x + ($dx * $i)) + ($y + ($dy * $i)) $test"  >> c:\log.txt
            return 0
        }
    }
    return 1;
}

function getChar {
    param (
        [String[]] $field,
        [int] $x,
        [int] $y
    )
    return $field[$y][$x]
 }

[int]$count = 0
for ($x=0 ; $x -lt $maxX ; $x++) {
    for ($y=0 ; $y -lt $maxY ; $y++) {
        $count += testPos $sample $x $y
    }
}
$count