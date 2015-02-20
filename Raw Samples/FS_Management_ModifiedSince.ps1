#Determine File Modification Ages

$path="F:\dgray"

#Get some other properties in case we want to further

#break down each bucket.

$files=dir $path -recurse |

Select Fullname,CreationTime,LastWriteTime,Length,

@{Name="Age";Expression={(Get-Date)-$_.LastWriteTime}},

@{Name="Days";Expression={[int]((Get-Date)

  -$_.LastWriteTime).TotalDays}}

 

$hash=@{

Path=$path

Over=      ($files | Where {$_.Days -gt 365} | Measure-Object).Count

'365Days'= ($files | Where {$_.Days -gt 180 -AND

  $_.Days -le 365} | Measure-Object).Count

'180Days'= ($files | Where {$_.Days -gt 90 -AND

  $_.Days -le 180} | Measure-Object).Count

'90Days'=  ($files | Where {$_.Days -gt 30 -AND

  $_.Days -le 90} | Measure-Object).Count

'30Days'=  ($files | Where {$_.Days -gt 7 -AND

  $_.Days -le 30} | Measure-Object).Count

'7Days'=   ($files | Where {$_.Days -gt 0 -AND

  $_.Days -le 7} | Measure-Object).Count

}

New-Object -TypeName PSObject -Property $hash |

Select Path,Over,365Days,180Days,90Days,30Days,7Days