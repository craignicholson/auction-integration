
# Access all files in SaleRequests Folder with an extension of .xml
Get-ChildItem .\ -Filter *.xml | 
Foreach-Object {

    # read the data in the file
    $content = Get-Content $_.FullName

    # Do some work on the data - like send a Web Request
    Write-Host $_.Name
    Write-Host $_.FullName
    Write-Host $content

}
