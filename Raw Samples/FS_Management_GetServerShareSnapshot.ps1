$sb={

#Get the file shares locally.

#Build Usage Report for File Server Shares

$shares=Get-WmiObject -Class Win32_Share -filter "type=0"

foreach ($share in $shares) {

    #Suppress any access denied error messages.

    Write-Host "Measuring $($share.path)" -ForegroundColor Green

    $stats=dir $share.path -Recurse -ErrorAction SilentlyContinue |

      Where {-Not $_.PSIscontainer} |

      Measure-Object -Property Length -Sum

      $hash=@{

      Computername=$env:Computername

      Path=$share.path

      Share=$share.Name

      SizeKB=[math]::Round(($stats.sum/1KB),2)

      Files=$stats.count

      }

      #Write a custom object to the pipeline for each share.

      New-Object -TypeName PSObject -Property $hash

    } #foreach $share

}#sb

$results = Invoke-Command -ScriptBlock $sb -ComputerName

  CHI-FP01 -HideComputerName