$string = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
$pattern = "mul\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\)|do\(\)|don\'t\(\)"  # Matches words with exactly 4 letters
$matches = [regex]::Matches($day3, $pattern)

$sum = 0
$enabled = $true;
foreach ($match in $matches) {
    $match.Groups[0].Value
    switch ($match.Groups[0].Value.Substring(0,3)) {
        "do(" {$enabled = $true}
        "don" {$enabled = $false}
        "mul" {
            if ($enabled) {
                $sum += [int]$match.Groups[1].Value * $match.Groups[2].Value
            }
        }
    }
}
$sum