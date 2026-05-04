$inputString = Read-Host 'Enter a string' 
$wordArray = $inputString -split ' ' 
$wordCount = $wordArray.Count 
$charCount = $inputString.Length 
$reversedString = [string]::Join('', [char[]]::Reverse($inputString.ToCharArray())) 
$upperString = $inputString.ToUpper() 
$lowerString = $inputString.ToLower() 
$uniqueWords = $wordArray | Sort-Object -Unique 
$wordFrequency = @{} 
foreach ($word in $wordArray) { 
    if ($wordFrequency.ContainsKey($word)) { 
        $wordFrequency[$word]++ 
    } else { 
        $wordFrequency[$word] = 1 
    } 
} 
$longestWord = ($wordArray | Sort-Object Length -Descending | Select-Object -First 1) 
$shortestWord = ($wordArray | Sort-Object Length | Select-Object -First 1) 
$wordCountInfo = 'Total words: {0}, Total characters: {1}' -f $wordCount, $charCount 
$statistics = @{ 
    'TotalWords' = $wordCount 
    'TotalCharacters' = $charCount 
    'LongestWord' = $longestWord 
    'ShortestWord' = $shortestWord 
    'UniqueWords' = $uniqueWords.Count 
} 
$statistics | Format-Table 
$wordFrequency | Sort-Object Value -Descending | Format-Table 
$results = @{ 
    'OriginalString' = $inputString 
    'ReversedString' = $reversedString 
    'UppercaseString' = $upperString 
    'LowercaseString' = $lowerString 
} 
$results | Format-List 
$uniqueWords | ForEach-Object { 
    Write-Host $_ 
} 
Write-Host 'Processing complete.' 
Start-Sleep -Seconds 2 
Clear-Host
