$obj = Import-Clixml "$env:USERPROFILE\.ps\homebridge.cred"
$rootURL = $obj.rootURL

$body = @{
    "username" = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($obj.username))
    "password" = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($obj.password))
} | ConvertTo-Json

Try {
    $accessToken = (Invoke-RestMethod -Uri "$rootURL/api/auth/login" -Body $body -Method Post -ContentType "application/json").access_token
} Catch {
    Write-Warning "Failed Authentication!"
    return
} Finally {
    Remove-Variable body  #remove the plaintext content
}

$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type" = "application/json"
}

$uuid = "261507a682a8745b0dce9c963b7ddbc6b158b73b45aabae18168bc40a1900c79"
$body = @{
    "characteristicType" = "On"
    "value" = 0
} | ConvertTo-Json

Try {
    Invoke-RestMethod -Uri "$rootURL/api/accessories/$uuid" -Headers $headers -Method Put -Body $body | Out-Null
    Write-Information "Success!"
} Catch {
    Write-Warning "Failed Operation!"
}