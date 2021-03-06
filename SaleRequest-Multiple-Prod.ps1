<#
.Synopsis
   SaleRequest-Multiple-Prod.ps1 sends http post of a Sale Request to Auction.com
   for multiple files in a directory.

   Go directly to Example to to see example to run this script.
.DESCRIPTION
   This script will scan a subfolder (SaleRequests) inside of the same folder the script exists.
   
   Xml files are expected to contain a SaleRequest (Auction.com). Each file will have
   the file contents read into a variable and sent in a HTTP POST body to Auction.com.
   
   The user (account) and password are included in the URL's path.\

   The request is a xml payload, see the Auction.com specification. The response is also a copy 
   of the payload you sent, with additional fields including the call_id which is to be used on 
   all other subsequent API calls when referning to a particular Sale Request. 
   
   Proposed Folder Setup for Auction.Com scripts for this script file:
   \Auction folder will contain one script for each Web API Request
   Inside of the \Auction folder we will have multiple folders for each Web API Request
   Example Folders {SaleRequests, BidInstructions, SalePostponements, SaleCancelations, SaleResults}
   Each of the folders listed in Example Folders will contain a Processed and Archive folder
   Processed will contain the output of the request (1 file) and the response (2 files). Each file name will be timestamped.
   Archive will contain the original file processed (1 file) with the original file name.

   Setup to run every {X} minutes in Windows Task Scheduler, use the Full file path instead of just the filename.
   'powershell -File SaleRequest-Multiple-Prod.ps1 -WindowStyle Hidden'

.EXAMPLE
   Run the Command from Powershell
      PS:> .\SaleRequest-Multiple-Prod.ps1

   Run the Command from cmd for automation with Windows Task Scheduler
         'powershell -File SaleRequest-Multiple-Prod.ps1 -WindowStyle Hidden'
 
   Example Folder Setup
   \Auction\SaleRequest-Multiple-Prod.ps1
   \Auction\SaleRequests\{files generated by you}
   \Auction\SaleRequests\Archive
   \Auction\SaleRequests\Processed

   PS C:\AuctionTest> ls

      Directory: C:\AuctionTest

   Mode                 LastWriteTime         Length Name
   ----                 -------------         ------ ----
   d-----         5/25/2021   1:18 PM                BidInstructions
   d-----         5/25/2021   1:19 PM                SaleCancelations
   d-----         5/25/2021   1:18 PM                SalePostponements
   d-----         5/25/2021   1:32 PM                SaleRequests
   d-----         5/25/2021   1:19 PM                SaleResults
   -a----         5/25/2021   1:30 PM           6542 SaleRequest-Multiple-Prod.ps1

   PS C:\AuctionTest> gci -Recurse -Directory

      Directory: C:\AuctionTest

   Mode                 LastWriteTime         Length Name
   ----                 -------------         ------ ----
   d-----         5/25/2021   1:18 PM                BidInstructions
   d-----         5/25/2021   1:19 PM                SaleCancelations
   d-----         5/25/2021   1:18 PM                SalePostponements
   d-----         5/25/2021   1:32 PM                SaleRequests
   d-----         5/25/2021   1:19 PM                SaleResults

      Directory: C:\AuctionTest\SaleRequests

   Mode                 LastWriteTime         Length Name
   ----                 -------------         ------ ----
   d-----         5/25/2021   1:32 PM                Archive
   d-----         5/25/2021   1:32 PM                Processed
.INPUTS
   Correctly formatted xml file based on the web api call being used.

   Example xml body for message:
   <?xml version="1.0" encoding="utf-8"?>
   <service_call>
      <parameters>
         <trustee_id>Sample Trustee Fullname</trustee_id>
         <transmit_date>2015-10-13T15:10:08</transmit_date>
         <trustee_reference_number>CA-10-401406-EV</trustee_reference_number>
         <trustee_reference_id>364553</trustee_reference_id>
         <beneficiary_name>Saxon Special Servicing</beneficiary_name>
         <beneficiary_loan_number>2000543784</beneficiary_loan_number>
         <servicer_name>Saxon Special Servicing</servicer_name>
         <servicer_loan_number>2000543784</servicer_loan_number>
         <servicer_phone>800-594-8422</servicer_phone>
         <occupancy_status>Occupied</occupancy_status>
         <auction_date>2015-11-12</auction_date>
         <auction_time>09:00:00</auction_time>
         <apn>169-445-24</apn>
         <property_address_1>1716  LANDING DRIVE</property_address_1>
         <property_address_2/>
         <property_address_3/>
         <property_city>VISTA</property_city>
         <property_county>SAN DIEGO</property_county>
         <property_state>CA</property_state>
         <property_zip_code>92081</property_zip_code>
         <trustor>CECILIA SMITH, A SINGLE WOMAN</trustor>
         <trustor_deed_of_trust_date>2011-04-05</trustor_deed_of_trust_date>
         <upb>400000.00</upb>
         <nos_amount>444681.92</nos_amount>
         <nod_date>2015-08-04</nod_date>
         <nod_expiration_date>2015-03-04</nod_expiration_date>
         <nos_date>2015-08-04</nos_date>
         <trustee_firm_name>Home Auction Service Corporation</trustee_firm_name>
         <trustee_phone>619-243-3956</trustee_phone>
         <trustee_email/>
         <pub_post_company_name>IQR Pub Service</pub_post_company_name>
         <pub_post_company_phone/>
         <publication_date>2015-11-10</publication_date>
         <title_underwriter>LPS Default Title &amp; Closing - CA II</title_underwriter>
         <title_tsg_date>2014-08-04</title_tsg_date>
         <mi_company>GENWORTH MORTGAGE INSURANCE CORP</mi_company>
         <sale_location>Sale will be held at Auction.com - Sale Location, Auction.com Room, San Francisco, CA</sale_location>
         <payee_name>Robert Ballard</payee_name>
         <dot_recording_doc>VOLUME 10713, PAGE 0709, DOCUMENT NO. 20040095074; File No. 2006041025</dot_recording_doc>
         <dot_date>2015-10-25</dot_date>
         <loan_type>FHA</loan_type>
         <client_id>Bank of America</client_id>
         <legal_description>Lot 73 of Evergreen Terrace as recorded in Volume 20 of Plats page 25, in Thurston County, Washington.</legal_description>
         <original_beneficiary>Washington Mutual Bank</original_beneficiary>
         <original_principal_amount>150000.00</original_principal_amount>
         <final_judgment_amount>150000.00</final_judgment_amount>
         <fha_case_number>varchar(25)</fha_case_number>
         <lenstar_id>123894536</lenstar_id>
         <sale_agent>Sheriff</sale_agent>
         <gse_investor>FHLMC</gse_investor>
      </parameters>
   </service_call>
.OUTPUTS
   Screen: request sent, response recieved, call_id received, any errors returned from Auction.com
   Files: response.xml, response-content.xml, MARRIAGE-FILE.csv

   response.xml contains more information about the web request and the body of the response can be
   truncated, so we add a second file containing the entire repsonse content.

   response-content contains just the xml response (Verbose)

   MARRIAGE-FILE contains the trustee-reference-id, call_id
.NOTES
   General notes
#>

# Add Account and Password as parameters
$account = "account-number"
$password = "*********************************************"

# Access all files in SaleRequests Folder with an extension of .xml
# Edit this line to change your folder name 'Get-ChildItem .\SaleRequests -Filter *.xml' 
# *****************************************************************
Get-ChildItem .\SaleRequests -Filter *.xml | 
Foreach-Object {

   # Create a timestamp string for future use
   $timeStr = get-date -f 'yyyy-MM-dd-HH.mm.ss.fff'

   # Original fileName, saved as varible so we can append additional data to the filename w/o extension
   # Using this instead of io.path to get around error: PowerShell Script Not Digitally Signed
   # Assumes 3 char extension and a . {.xml} -> 4 chars
   $fileName = $_.Name.Substring(0,$_.Name.Length-4)

   # Read the data in the file into the body varibale for the http post
   $body = Get-Content $_.FullName

   # PROCESS THE FILE
   # *****************************************************************

   # Create the headers for the Web Request
   $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
   $headers.Add("Content-Type", "text/xml")
   #$headers.Add("Cookie", "PHPSESSID=sdudh9140tqhs4m0dbsjtn7tm3; segment_reskin=new")

   # PRODUCTION
   $Url = "https://live.feeds.auction.com/listener/dropbox/$account/$password"

   # Write output to screen of the input data
   Write-Host '******************** REQUEST ********************'
   Write-Host $body

   # Send the web request for the request xml file
   $response = Invoke-WebRequest $Url -Method 'POST' -Headers $headers -Body $body

   # ERRORS REPORTED DURING TESTING
   # <service_response><request><response>failed</response><errors>No XML Posted to Listener</errors></request></service_response>
   # <service_response><request><response>failed</response><errors>Authentication Failure</errors></request></service_response>
   # <service_response><request><response>failed</response><errors>Invalid XML Format</errors></request></service_response>
   Write-Host '******************** RESPONSE ********************'
   Write-Host $response.Content

   # Load the data into xml document
   $xdoc = [xml] $response.Content

   # Check if the response failed
   $errors = $xdoc.SelectNodes(('//errors'))

   foreach ($error in $errors) {
      # Later on output more useful information
      if (-not ([string]::IsNullOrEmpty($error.InnerText))) {
         Write-Host '******************** FAILED ********************'
         Write-Host $error.InnerText
      }
   }

   # Get the call_id and trustee_reference_number, and write to screen if we have it, if we don't
   # something happend, and report a status of failed
   $status = 'FAILED'
   $call_id = $xdoc.SelectSingleNode(('//call_id'))
   $trustee_reference_number = $xdoc.SelectSingleNode(('//trustee_reference_number'))
   if (-not ([string]::IsNullOrEmpty($call_id.InnerText))) {
      # Output some variables to the screen for testing
      Write-Host '******************** call_id ********************'
      Write-Host 'call_id: '$call_id.InnerText
      Write-Host 'trustee_reference_number: '$trustee_reference_number.InnerText
      Write-Host 'Timestamp: '$timeStr
      $status = 'SUCCESS'

      # Parse out the trustee_reference_id as well and then write
      # this data to a database, or just append to some file
      # business rules - trustee_reference_number, call_id
      $database_FileName = $fileName + '-' + $timeStr + '-MARRIAGE-FILE.csv' 
      $row = $trustee_reference_number.InnerText+', '+ $call_id.InnerText
      $row | Out-File -FilePath .\SaleRequests\MarriageFiles\$database_FileName

      # Prep the call_id to be added to the filename
      $call_id = '{' + $call_id.InnerText + '}-'
   }
   else {
      Write-Host '******************** MISSING call_id MISSING ********************'
      # Send an alert about a failure
   }

   # Save the output of the response to file with timestamp and original name 
   # We can even comment this block out at a later date if we are comfortable we
   # are no longer needing this file.
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '-' + 'RESPONSE.xml' 
   $response | Out-File -FilePath .\SaleRequests\Processed\$timeStamp_FileName

   # write just the content of the file in same folder as ps1 file
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '-' + 'RESPONSE-CONTENT.xml' 
   $response.Content | Out-File -FilePath .\SaleRequests\Processed\$timeStamp_FileName
    
   # write out the request to save in processed folder
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '.xml' 
   $body | Out-File -FilePath .\SaleRequests\Processed\$timeStamp_FileName
   # Move the original file to a Archive folder - we can delete the file as well
   # Force and overwrite if the file already exists, probably should rename and increment
   # b/c the first file sent might have been different than a second attempt, but with
   # this web service the output if preserved by Auction.com's web service which returns 
   # the data in the request back in the response. :->
   Move-Item $_.FullName -Destination .\SaleRequests\Archive -Force
}