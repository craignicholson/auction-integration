<# Example to try and write to an existing table

If a file has yet to be created... use this
OPEN #5: “Name=auctionmarriagefile,  NEW, recl=256”: INTERNAL, OUTPUT, RELATIVE ERROR errorhandling
WRITE #5, USING “N 128, C 128”: $trustee-refereance-id, $call_id 
CLOSE #3:

If the file already exists use this
OPEN #5: “NAME=AUCTIONMARRIAGEFILE.INT”,INTERNAL,OUTPUT,SEQUENTIAL
WRITE #5 $trustee-refereance-id, $call_id
CLOSE #5

#>

Write-Host 'Example 01 ******************************************'
Write-Host `n

cmd.exe --% /c dir /w 
Write-Host `n


Write-Host 'Example 02 ******************************************'
Write-Host `n

# This might the way to open the brules Command Console Application
# Note this just flashes on screen since it runs in cmd console
# -FilePath is the path to the .exe you need to run
#Start-Process -FilePath "$env:comspec" -ArgumentList "/c dir `"%systemdrive%\program files`""
Start-Process -FilePath "$env:comspec" -ArgumentList "/c","dir","Auction-Development"  
Write-Host `n

Write-Host 'Example 03 ******************************************'
Write-Host `n

$trustee_reference_number = "888888888888888-8888808-0000"
$call_id = "ututututututuutuutuutu"
$open = 'OPEN #5: "NAME=AUCTIONMARRIAGEFILE.INT",INTERNAL,OUTPUT,SEQUENTIAL'
$write = "WRITE #5 $trustee_reference_number, $call_id"
$close = 'CLOSE #5'

Write-Host $open
Write-Host $write
Write-Host $close
Write-Host `n

# It would be something like ... this (I have not idea what the name of the app is)
Start-Process -FilePath "C:\brules.....\command-console.exe" -ArgumentList $open
Start-Process -FilePath "C:\brules.....\command-console.exe" -ArgumentList $write
Start-Process -FilePath "C:\brules.....\command-console.exe" -ArgumentList $close

Write-Host `n

