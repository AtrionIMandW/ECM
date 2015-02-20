# Group Output by Owner

$sb={

Param($path)

$data=dir $path |

  where {-not $_.PSIsContainer} |

  select name, @{Name="Owner";Expression=

  {(Get-ACL $_.fullname).Owner}},length

  $data | group -property owner |

  Select @{Name="Computername";Expression={$env:computername}},

  @{Name="Path";Expression={$path}},Name,Count,@{Name=

  "Size";Expression={

  ($_.Group | Measure-Object -Property Length -sum).Sum}}

} #sb

 

<#

Run the command remotely and suppress the RunspaceID since we

don't really need it.

#>

Invoke-Command -ScriptBlock $sb -ComputerName CHI-FP01

  -ArgumentList @("c:\shares\public") -HideComputerName |

  Select * -ExcludeProperty RunspaceID