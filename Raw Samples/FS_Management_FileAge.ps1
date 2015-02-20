# Determine File Age

PS C:\work> get-item wishlist.txt | format-list name,

  CreationTime,LastWriteTime,

>> @{Name="Age";Expression={(Get-Date)-$_.LastWriteTime}},

>> @{Name="Days";Expression={((Get-Date)

  -$_.LastWriteTime).TotalDays}}

>>

 

Name          : wishlist.txt

CreationTime  : 11/23/2010 10:31:10 PM

LastWriteTime : 2/15/2011 7:36:34 AM

Age           : 511.06:42:17.4251748

Days          : 511.279372271039