param (
  [string[]]$Tags,
  [string[]]$InstallTags,
  [switch]$Dryrun,
  [switch]$Debug
)

. (Join-Path $PSScriptRoot 'apps-to-install', 'list.ps1')

function HasTag {
  param (
    [string[]] $AppTags
  )

  if ($InstallTags.Count -ne 0) {
    return @($AppTags | Where-Object { $InstallTags -contains $_ }).Count -eq 0
  }

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

    $argv = New-Object System.Collections.Generic.List[System.Object]

    if ($app.Id) {
      Write-Host  "  Installing: $($app.Id)" -NoNewline
      $argv.Add("--id=$($app.Id)")
    }
    else {
      Write-Host  "  Installing: $($app.Name)" -NoNewline
      $argv.Add("--name=$($app.Name)")
    }

    # Show list of significant tags
    $SignificantTags = $app.Tags | Where-Object { $_ -ne 'all' }
    if ($SignificantTags.Count -ne 0) {
      Write-Host " (Tags: $($SignificantTags | Join-String $_ -Separator ' ' -SingleQuote))" -ForegroundColor Yellow -NoNewline
    }

    Write-Host '' # Add newline

    if ($app.Options) {
      $app.Options | ForEach-Object { $argv.Add($_) }
    }

    if ($Debug) {
      Write-Host "    Install command: winget install $($argv)" -ForegroundColor DarkMagenta
    }

    if ($Dryrun -eq $false) {
      winget install @argv
    }
  }
}
