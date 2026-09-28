param (
  [string[]]$Tags,
  [switch]$Dryrun
)

. (Join-Path $PSScriptRoot 'apps-to-install', 'list.ps1')

function HasTag {
  param (
    [string[]] $AppTags
  )

  if ($AppTags.Count -eq 0) {
    return $false
  }

  if ($Tags.Count -eq 0) {
    return $true
  }

  return @($AppTags | Where-Object { $Tags -contains $_ }).Count -eq 0
}

foreach ($group in $listOfGroups) {
  Write-Host "$($group.Label):" -ForegroundColor Blue

  foreach ($app in $group.Apps) {
    if ($null -eq $app.Id -and $null -eq $app.Name) {
      continue
    }

    if (HasTag -AppTags $app.Tags) {
      continue
    }

    Write-Host  "  Installing: $($app.Id ? $app.Id : $app.Name)" -NoNewline

    # Show list of significant tags
    $SignificantTags = $app.Tags | Where-Object { $_ -ne 'all' }
    if ($SignificantTags.Count -ne 0) {
      Write-Host " (Tags: $($SignificantTags | Join-String $_ -Separator ' ' -SingleQuote))" -ForegroundColor Yellow
    }
    else {
      Write-Host ''
    }

    if ($Dryrun -eq $false) {
      if ($app.Id) {
        winget install --id=$($app.Id) $($app.Options)
      }
      else {
        winget install --name=$($app.Name) $($app.Options)
      }
    }
  }
}
