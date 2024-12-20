[String[]]$data = Get-Content .\day7.txt

$sum = 0
foreach ($line in $data) {
    $part = $line.split(":")
    $numPart = $part[1].split(" ")
    $result = $part[0]
    $numbers = $numPart[1..$($numPart.Count-1)]
    $posibilities = [math]::Pow(2,($numbers.count - 1))
    $found = $false;
    for ($i = 0; $i -lt $posibilities; $i++) {
        [long]$calc = $numbers[0]
        for ($pos = 1; $pos -lt $numbers.Count; $pos++) {
            $mask = [math]::Pow(2,($pos -1))
            [int]$op = ($i -band $mask) / $mask
            switch ($op) {
                0 {
                    $calc = $calc + $numbers[$pos]
                }
                1 {
                    $calc = $calc * $numbers[$pos]
                }
                default {
                    echo "$op not found"
                }
            }
            
        }
        if ($calc -eq $result) {
            $found = $true
            $sum += $result
            break
        }
    }
}
echo "Sum: $sum"