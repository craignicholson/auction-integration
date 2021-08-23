<#
parameter-test.ps1 -account fein-such -password ba655298a42d2a74082abd147a1bb731 -request trustee-bidinstruction -folder BidInstructions
#>
# testing parameters
Param(
    [Parameter(Position = 1)]
    [string]$account,
  
    [Parameter(Position = 2)]
    [string]$password ,
 
    [Parameter(Position = 3)]
    [string]$request,

    [Parameter(Position = 4)]
    [string]$folder
)

Write-Host $account
Write-Host $password
Write-Host $request
Write-Host $folder

$Url = "https://feeds.qa.auction.com/listener/xml/?account=$account&password=$password&request=$request"

Write-Host $Url