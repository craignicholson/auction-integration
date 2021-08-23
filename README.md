# AUCTION.COM Web Services

## Description

This is a quick script using Powershell to send data to Auction.com. Project was a two day
work up to help a friend is kinda production friendly. :-)

User of this script should review folder WebServiceXML-Samples for the request examples.

### Techniques & Tools Used

- Loop a folder and read data from a file
- Send a web request with the body containing data from the file
- Write the repsonse from the web request output to a file
- Parse xml for a errors and  results
- Using script input parameters
- VS Code, Powershell

(We did have a few issues with person who needed these scripts had to be signed by them on their machine. Weird... maybe it was VSCode or something we never determined the root cause of needing to be digitally signed, see below for resultions and notes)

## Files & Folders

### Files used to send data to Auction site

SaleRequest-Multiple-Dev-Test.ps1
SaleRequest-Multiple-Prod.ps1
  Script used to make the initial sales request.

Auction.Com-WebService-Dev-Test.ps1
Auction.Com-WebService-Prod.ps1
  This one script will handle four different web service posts to the Auction.com API.
  Bid Instructions, Sale Cancelatopons, Sale Postponements, and Sale Results

These files are the same, we just keep dev and prod seperated to help folks from running dev tests on prod.

WebServiceXML-Samples Folder: request and response xml samples for each web service

### Example Test files

file-name-strip-extension-example.ps1
get-call-Id-example.ps1
parameter-example.ps1
scan-folder-file-example.ps1

### Folder Structure Creation

Create-folder-structure-auction-prod.ps1
Create-folder-structure-auction-test.ps1

Production Environment
> .\Create-folder-structure-auction-prod.com.ps1

Dev-Test Environment
> .\Create-folder-structure-auction-test.com.ps1

You can edit these files to put the folders anywhere you would like them to exist.

The top level folder should contain all the .ps1 files. You can run the .ps1 files from this location.

### Sale Request

Sale Request will produce the call_id, see the Descrition in the files below for more information.

SaleRequest-Multiple-Prod.ps1
SaleRequest-Multiple-Dev-Test.ps1

User will need to change or update the $account and $password variables in these two files.

See Description in files above for more information.

> .\SaleRequest-Multiple-Prod.ps1
> .\SaleRequest-Multiple-Dev-Test.ps1

### Auction.com Web Services

These script handles 4 methods

-BidInstructions
-SaleCancelations
-SalePostponements
-SaleResults

Auction.Com-WebService-Dev-Test.ps1
Auction.Com-WebService-Prod.ps1

See Description in files above for more information.

BidInstructions
> .\Auction.Com-WebService-Prod.ps1 -account your-account -password *********** -request trustee-bidinstruction -folder BidInstructions

SaleCancelations
> .\Auction.Com-WebService-Prod.ps1 -account your-account -password *********** -request trustee-cancel -folder SaleCancelations

SalePostponements
> .\Auction.Com-WebService-Prod.ps1 -account your-account -password *********** -request trustee-postpone -folder SalePostponements

SaleResults
>.\Auction.Com-WebService-Prod.ps1 -account your-account -password *********** -request trustee-inbound-sales-results -folder SaleResults

## SaleRequest-Multiple-Prod.ps1 is not digitally signed. The script will not execute on the system

We are getting this error on a machine (locally) when running this script. The script was not created on this users machine.

I wonder if it is because these files were created with VS Code or is it the content of the code which causes windows to determine

### Fix 0

<https://www.hanselman.com/blog/signing-powershell-scripts>

<https://www.opentechguides.com/how-to/article/powershell/105/powershel-security-error.html>

### Fix 1

Change the execution policy

> PS C:\Auction-Development> get-ExecutionPolicy -list

```ps
        Scope ExecutionPolicy
        ----- ---------------
MachinePolicy       Undefined
   UserPolicy       Undefined
      Process       Undefined
  CurrentUser       Undefined
 LocalMachine    RemoteSigned
```

> PS C:\Auction-Development>  Set-ExecutionPolicy unrestricted

Enter Y for yes.

```ps
PS C:\WINDOWS\system32>  Set-ExecutionPolicy unrestricted

Execution Policy Change
The execution policy helps protect you from scripts that you do not trust. Changing the execution policy might expose
you to the security risks described in the about_Execution_Policies help topic at
https:/go.microsoft.com/fwlink/?LinkID=135170. Do you want to change the execution policy?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): Y

```

Reset the execution policy back to original setting

> PS C:\Auction-Development>  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

### Fix 2

> PS C:\Auction-Development> Unblock-File -Path C:\Auction-Development\ScriptGivingUsIssues.ps1

### Fix 3

User on local machine creates a new ps1 file.
Copy the code from the not digitally signed file to your new file.

### Fix 4

 <https://adamtheautomator.com/how-to-sign-powershell-script/>

## Notes

 Eventually we just signed these scripts on the users machine

## BRules Info

Attempt to find a way to make calls to BRules from powershell

http://brwiki2.brulescorp.com/index.php?title=Fast_Track_2

The OPEN #3 example above creates a NEW file with a record length of 256 characters.
What other values can be in place of NEW

3 NEW - NEW indicates that the file to be opened must also be newly created. In the place of NEW, there are two other options: NEW or REPLACE.The USE parameter indicates that an existing file by the specified name should be opened. If a file by the specified name does not exist, Business Rules will create a new file for it.

> 500 open #5: "Name=Checkbook.int, recl=63,new", internal, output, sequential  

<http://www.brwiki.com/index.php?title=Chapter_14>

> OPEN #3: “Name=auctionmarriagefile,  NEW, recl=256”: INTERNAL, OUTPUT, RELATIVE ERROR errorhandling
> OPEN #3: “Name=auctionmarriagefile,  USE, recl=256”: INTERNAL, OUTPUT, RELATIVE ERROR errorhandling
> WRITE #3, USING “N 128, C 128”: $trustee-refereance-id, $call_id 
> CLOSE #3:

## Using the OPEN statement for an existing file.

<http://www.brwiki.com/index.php?title=Chapter_14#14.4_Using_the_OPEN_statement_for_an_existing_file.>

OPEN #7: “NAME=AUCTIONMARRIAGEFILE.INT”,INTERNAL,OUTPUT,SEQUENTIAL
WRITE #7 $trustee-refereance-id, $call_id
CLOSE #7

How to send a command to the Command Console in BR rules

editors
<http://www.brwiki.com/index.php?title=Category:External_Editors>