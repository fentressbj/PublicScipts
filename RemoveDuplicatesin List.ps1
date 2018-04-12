Add-PSSnapin microsoft.sharepoint.powershell 
$web = Get-SPWeb -Identity "<insert SharePoint url here>" 
$list = $web.Lists["<insert SharePoint list name here"]

$AllDuplicates = $list.Items.GetDataTable() | Group-Object PrimaryKey ##this is the name of the column you want to compare
 | where {$_.count -gt 1} 
$count = 1 
$max = $AllDuplicates.Count 
foreach($duplicate in $AllDuplicates) 
{ 
$duplicate.group | Select-Object -Skip 1 | % {$list.GetItemById($_.ID).Delete()} 
Write-Progress -PercentComplete ($count / $max * 100) -Activity "$count duplicates removed" -Status "In Progress" 
$count++ 
} 