Add-PSSnapIn Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue | Out-Null
 
$web = Get-SPWeb "<add your SharePoint url here>"
$list = $web.Lists["<Add your SharePoint List name here"]
$caml=""
#optional filter
#<Where><Eq><FieldRef Name=""ContentType"" /><Value Type=""Text"">Form</Value></Eq></Where>"
 
$query=new-object Microsoft.SharePoint.SPQuery
$query.ViewAttributes = "Scope='Recursive'"
$query.Query=$caml
 
$items=$list.GetItems($query)
Write-Host $items.Count
 
$items | % { $list.GetItemById($_.Id).Delete() }
 
$web.Dispose()
$site.Dispose()

