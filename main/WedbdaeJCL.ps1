$inputPath = 'C:\input.txt'
$outputPath = 'C:\output.txt'
$delimiter = ','
$lines = Get-Content $inputPath
$results = @()
foreach ($line in $lines) {
    $fields = $line -split $delimiter
    $result = [PSCustomObject]@{}
    for ($i = 0; $i -lt $fields.Length; $i++) {
        $result | Add-Member -MemberType NoteProperty -Name "Column$i" -Value $fields[$i]
    }
    $results += $result
}
$results | Export-Csv -Path $outputPath -NoTypeInformation
$summary = @{}
$summary.TotalLines = $results.Count
$summary.Columns = $results[0].PSObject.Properties.Name.Count
$summary | ConvertTo-Json | Out-File 'C:\summary.json'
$filteredResults = $results | Where-Object { $_.Column0 -ne '' }
$filteredResults | Export-Csv -Path 'C:\filtered_output.csv' -NoTypeInformation
$distinctValues = $results.Column0 | Select-Object -Unique
$distinctValues | Out-File 'C:\distinct_values.txt'
foreach ($value in $distinctValues) {
    $count = ($results | Where-Object { $_.Column0 -eq $value }).Count
    Add-Content 'C:\value_counts.txt' "$value: $count"
}
$topValues = $results | Group-Object Column0 | Sort-Object Count -Descending | Select-Object -First 10
$topValues | Export-Csv -Path 'C:\top_values.csv' -NoTypeInformation
$results | ForEach-Object { $_.Column0 = $_.Column0.ToUpper() }
$results | Export-Csv -Path 'C:\uppercase_output.csv' -NoTypeInformation
$results | ForEach-Object { $_.Column0 = $_.Column0.ToLower() }
$results | Export-Csv -Path 'C:\lowercase_output.csv' -NoTypeInformation
$results | ForEach-Object { $_.Column0 = $_.Column0.Trim() }
$results | Export-Csv -Path 'C:\trimmed_output.csv' -NoTypeInformation
$results | ForEach-Object { $_.Column0 = $_.Column0.Replace('old','new') }
$results | Export-Csv -Path 'C:\replaced_output.csv' -NoTypeInformation
$results | ForEach-Object { if ($_.Column0.Length -gt 5) { $_.Column0 = 'LongValue' } }
$results | Export-Csv -Path 'C:\modified_output.csv' -NoTypeInformation
