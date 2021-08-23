# capture the value in the "call_id" element
$xdoc = [xml] (get-content .\response-test_content.xml)
$call_id = $xdoc.SelectSingleNode(('//call_id'))
Write-Host 'call_id: ' + $call_id.InnerText