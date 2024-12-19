$string = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
$pattern = "mul\(([0-9][0-9]?[0-9]?),([0-9][0-9]?[0-9]?)\)"  # Matches words with exactly 4 letters
$matches = [regex]::Matches($string, $pattern)

$sum = 0
foreach ($match in $matches) {
    $sum += [int]$match.Groups[1].Value * $match.Groups[2].Value
}
$sum