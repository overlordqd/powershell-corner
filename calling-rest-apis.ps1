$_countryResolveUrl = "https://restcountries.eu/rest/v2/alpha/"
$_airportResolveUrl = "https://www.air-port-codes.com/api/v1/autocomplete"

Get-Content C:\Users\b.akcay\Documents\country-codes.txt | Where-Object {$_ -ne ""} | ForEach-Object {
    $countryName = $countryCode
    $airportName = $airportCode
    $countryCode = ($_ -split "	")[0]
    $airportCode = ($_ -split "	")[1]
    $countryUrl = $_countryResolveUrl + $countryCode
    try{
        $airportBody = @{"limit"="1"; "term"= $airportCode; }
        $restAirportAnswer = Invoke-RestMethod -Method 'Post' -Body $airportBody -Uri $_airportResolveUrl -Headers @{'Content-Type' = 'application/x-www-form-urlencoded'; 'APC-Auth' = '96dc04b3fb'; 'Referer'= 'https://www.air-port-codes.com/'}
        $airportName = $restAirportAnswer.airports[0].name
    }
    catch{
        
    }

    try{
        $restCountryAnswer = Invoke-RestMethod -Method 'Get' -Uri $countryUrl
        $cityName = $restCountryAnswer.name        
    }
    catch{
        
    }

    Write-Host $cityName $airportName
}