# Get size report from top-level folders

$share=Get-WmiObject -Class Win32_Share -ComputerName

  CHI-FP01 -filter "name='Sales'"

$sb={

Param ($path)

dir $path | where {$_.PSIscontainer} |

foreach {

  $stats=dir $_.Fullname -recurse -errorAction

  "SilentlyContinue" | where {-NOT $_.PSIscontainer} |

  Measure-object -Property Length -sum

  New-Object -TypeName PSObject -Property @{

    Computername=$env:Computername

    Path=$_.Name

    Fullname=$_.Fullname

    SizeKB=[math]::Round(($stats.sum/1KB),2)

    NumberFiles=$stats.count

  } #property

  } #foreach

} #sb

 

$results=Invoke-Command -ScriptBlock $sb -ComputerName

  $share.__SERVER -ArgumentList @($share.path)

  -HideComputerName