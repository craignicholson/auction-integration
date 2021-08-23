<#
.Synopsis
   This one script will handle four different web service posts to the Auction.com API.
   Bid Instructions, Sale Cancelatopons, Sale Postponements, and Sale Results. The user
   of this script is responsible for setting up the required folders to process these
   web service transactions.

   Go directly to Example to to see example to run this script.
.DESCRIPTION

   folder proposed parameters:
      BidInstructions
      SaleCancelations
      SalePostponements
      SaleResults

   Each Folder will have two subfolders: {Processed, Archive}
   Processed contains the response from the webservice
   Archive contains the file which contained the request.

      BidInstructions
         Processed
         Archive
      SaleCancelations
         Processed
         Archive
      SalePostponements
         Processed
         Archive
      SaleResults
         Processed
         Archive     
   
   The url has the following request parameter which is defined by Auction.com
   request accepted parameters:
      trustee-bidinstruction
      trustee-cancel
      trustee-postpone
      trustee-inbound-sales-results

.EXAMPLE
   .\Auction.Com-WebService-Prod.ps1 -account your-account -password ************************************** -request trustee-bidinstruction -folder BidInstructions
   .\Auction.Com-WebService-Prod.ps1 -account your-account -password ************************************** -request trustee-cancel -folder SaleCancelations
   .\Auction.Com-WebService-Prod.ps1 -account your-account -password ************************************** -request trustee-postpone -folder SalePostponements
   .\Auction.Com-WebService-Prod.ps1 -account your-account -password ************************************** -request trustee-inbound-sales-results -folder SaleResults

.INPUTS
   account: The account given to you by Auction.com
   password: The password given to you by Auction.com
   request: The request you are making, see DESCRITPION above for acceptable parameters.
   folder: The folder which contains the request xml files which need to be sent to Auction.com

   trustee-bidinstruction xml sample request
   <?xml version="1.0" encoding="utf-8"?>
   <service_call>
      <request>
         <parameters>
            <call_id>20111013153904-68d139</call_id>
            <trustee_id>Sample Trustee Corp</trustee_id>
            <trustee_reference_number>CA-11-123456-AB</trustee_reference_number>
            <trustee_reference_id>385820</trustee_reference_id>
            <bid_type>Specified</bid_type>
            <minimum_bid>200000.00</minimum_bid>
            <maximum_bid>100.00</maximum_bid>
            <bid_increment></bid_increment>
            <bid_expiration_date>2012-02-05</bid_expiration_date>
            <nos_amount>359852.24</nos_amount>
            <seller_value></seller_value>
            <bpo_value></bpo_value>
            <auto_value></auto_value>
            <net_present_value></net_present_value>
            <bid_source></bid_source>
            <mi_company></mi_company>
            <comments></comments>
         </parameters>
      </request>
   </service_call>

   trustee-cancel xml sample request
   <?xml version="1.0" encoding="utf-8"?>
   <service_call>
      <request>
         <parameters>
            <call_id>20111013153904-68d139</call_id>
            <pub_post_serve_id>01Auction</pub_post_serve_id>
            <pub_post_server_order_number>Auction#385820</pub_post_server_order_number>
            <pub_post_serve_reference_id>Auction#385820</pub_post_serve_reference_id>
            <trustee_id>Quality Loan Service Corporation</trustee_id>
            <transmit_date>2011-10-13T15:39:02</transmit_date>
            <trustee_reference_number>CA-11-422864-AB</trustee_reference_number>
            <trustee_reference_id>385820</trustee_reference_id>
            <sale_date_time>2011-11-29T09:00:00</sale_date_time>
            <reason>Sale cancelled due to close and bill instructions in LS</reason>
         </parameters>
      </request>
   </service_call>

   trustee-postpone xml sample request
   <?xml version="1.0" encoding="utf-8"?>
   <service_call>
      <request>
         <parameters>
            <call_id>20111013155452-08182b</call_id>
            <pub_post_serve_id>01Auction</pub_post_serve_id>
            <pub_post_server_order_number>Auction#411299</pub_post_server_order_number>
            <pub_post_serve_reference_id>Auction#411299</pub_post_serve_reference_id>
            <trustee_id>Quality Loan Service Corporation</trustee_id>
            <transmit_date>2013-10-13T15:54:52</transmit_date>
            <trustee_reference_number>CA-11-448360-TC</trustee_reference_number>
            <trustee_reference_id>411299</trustee_reference_id>
            <postponement_id>987049</postponement_id>
            <postponed_sale_date_time>2013-10-14T09:00:00</postponed_sale_date_time>
            <new_sale_date_time>2014-11-14T09:00:00</new_sale_date_time>
            <new_place_of_sale>At the Doubletree Hotel Los Angeles, Norwalk, 13111 Sycamore Drive, Norwalk, CA 90650 in the Vineyard Ballroom</new_place_of_sale>
            <reason>Bankruptcy</reason>
            <postponed_detail>In reference to our phone call</postponed_detail>
         </parameters>
      </request>
   </service_call>

   trustee-inbound-sales-results xml sample request
   <?xml version="1.0" encoding="UTF-8"?>
   <service_call>
   <request>
   <parameters>
      <trustee_reference_number>INBOUND031</trustee_reference_number>
      <trustee_reference_id>Test031</trustee_reference_id>
      <trustee_id>Test Firm</trustee_id>
      <call_id>201407150055538-bpg771</call_id>
      <result_of_sale>
         <sold_date>2014-08-02T09:00:00</sold_date>
         <sale_result>SOLDTOTHIRDPARTY</sale_result>
         <winning_bid>491160.00</winning_bid>
         <nos_amount>359852.24</nos_amount> 
         <seller_value>300000</seller_value> 
         <purchaser_name>Monica Smith</purchaser_name>
         <purchaser_companyname>Smith Realty</purchaser_companyname>
         <vesting>Smith Realty</vesting>
         <purchaser_bidder_street_1>7 Cherry South</purchaser_bidder_street_1>
         <purchaser_city>Irvine</purchaser_city>
         <purchaser_state>CA</purchaser_state>
         <purchaser_zip>92612</purchaser_zip>
         <purchaser_phone>(555)777-7777</purchaser_phone>
         <purchaser_email>MSmith@gmail.com</purchaser_email>
      </result_of_sale>
   </parameters>
   </request>
   </service_call>

.OUTPUTS
   Two files with the response from the webservice
   The files will be named the following schema:

   -RESPONSE

   -REPSOSE-CONTENT

.NOTES
   Example valid urls

   TEST
   01 - https://feeds.qa.auction.com/listener/dropbox/your-account/**************************************
   05 - https://feeds.qa.auction.com/listener/xml/?account=your-account&password=**************************************&request=trustee-postpone
   06 - https://feeds.qa.auction.com/listener/xml/?account=your-account&password=**************************************&request=trustee-cancel
   07 - OUTBOUND to customers endpoint from Auction.com [NOT USING]
   08 - https://feeds.qa.auction.com/listener/xml/?account=your-account&password=**************************************&request=trustee-bidinstruction
   09 - https://feeds.qa.auction.com/listener/xml/?account=account&password=password&request=trustee-inbound-sales-results

#>


# CODE: Auction.Com-WebService-Prod.ps1
# TODO: Note, it might be useful in long run for one script to take in the url for prod and dev instances
# For ease of management two diff .ps1 files is ok as wellso we don't push dev data to prod by mistake
# Dev:  https://feeds.qa.auction.com
# Prod: https://live.feeds.auction.com
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

# DEV-TEST URL
$Url = "https://feeds.qa.auction.com/listener/xml/?account=$account&password=$password&request=$request"

# *****************************************************************
Get-ChildItem .\$folder -Filter *.xml | 
Foreach-Object {

   # create a timestamp string for future use
   $timeStr = get-date -f 'yyyy-MM-dd-HH.mm.ss.fff'

   # Original fileName, saved as varible so we can append additional data to the filename w/o extension
   # Using this instead of io.path to get around error: PowerShell Script Not Digitally Signed
   # Assumes 3 char extension and a . {.xml} -> 4 chars
   $fileName = $_.Name.Substring(0,$_.Name.Length-4)

   # Read the data in the file into the body variable for the http post
   $body = Get-Content $_.FullName

   # PROCESS THE FILE
   # *****************************************************************

   # Create the headers for the Web Request
   $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
   $headers.Add("Content-Type", "text/xml")

   # write output to screen of the input data
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
   $status = 'SUCCESS'
   $errors = $xdoc.SelectNodes(('//errors'))

   foreach ($error in $errors) {
      # TODO: output more useful information
      if (-not ([string]::IsNullOrEmpty($error.InnerText))) {
         Write-Host '******************** FAILED ********************'
         Write-Host $error.InnerText
         $status = 'FAILED'
      }
   }

   # Save the output of the response to file with timestamp and original name 
   # We can even comment this block out at a later date if we are comfortable we
   # are no longer needing this file.
   # timestamp and status and call-id are parameters requested to be added to the file name
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '-' + 'RESPONSE.xml' 
   $response | Out-File -FilePath .\$folder\Processed\$timeStamp_FileName

   # write just the content of the file in same folder as ps1 file
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '-' + 'RESPONSE-CONTENT.xml' 
   $response.Content | Out-File -FilePath .\$folder\Processed\$timeStamp_FileName
    
   # write out the request to save in processed folder
   $timeStamp_FileName = $fileName + '-' + $timeStr + '-' + $call_id + $status + '.xml' 
   $body | Out-File -FilePath .\$folder\Processed\$timeStamp_FileName
   # Move the original file to a Archive folder - we can delete the file as well
   # Force and overwrite if the file already exists, probably should rename and increment
   # b/c the first file sent might have been different request than a second attempt, but with
   # this web service the output if preserved by Auction.com's web service which returns 
   # the data in the request back in the response. :->
   Move-Item $_.FullName -Destination .\$folder\Archive -Force
}