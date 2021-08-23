# test file name strip of extension

Get-ChildItem .\SaleRequests -Filter *.xml | 
Foreach-Object {

    $fileName = $_.Name.Substring(0,$_.Name.Length-4)
    Write-Host 'filename stripped: ' + $fileName
}


Get-ChildItem .\SaleRequests -Filter *.xml | 
Foreach-Object {

    $fileName = [io.path]::GetFileNameWithoutExtension($_.FullName)
    Write-Host 'filename stripped using io.path: ' + $fileName
}
