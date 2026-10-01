$listOfGroups = Get-Content (Join-Path $PSScriptRoot 'apps-to-install' 'list.jsonc') -Raw | ConvertFrom-Json

$MarkdownLines = New-Object System.Collections.Generic.List[System.Object]
$Tags = New-Object System.Collections.Generic.List[System.Object]

foreach ($group in $listOfGroups) {
	Write-Host "$($group.Label):" -ForegroundColor Blue

	$MarkdownLines.Add(@"

### $($group.Label)

``````ps1
"@)

	foreach ($app in $group.Apps) {
		# Skip if app id and name are empty
		if ($null -eq $app.Id -and $null -eq $app.Name) {
			continue
		}

		Write-Host "  $($app.Id ? $app.Id : $app.Name)"

		$InstallScript = 'winget install '

		if ($null -ne $app.Id) {
			$InstallScript += "--id=$($app.Id)"
		}
		elseif ($null -ne $app.Name) {
			$InstallScript += "--name=`"$($app.Name)`""
		}

		if ($null -ne $app.Options) {
			$InstallScript += " $($app.Options)"
		}

		$MarkdownLines.Add($InstallScript)

		if ($app.Tags) {
			$app.Tags | ForEach-Object {
				$tag = $_
				if (!$Tags.Contains($tag)) {
					$Tags.Add($tag)
				}
			}
		}
	}

	$MarkdownLines.Add("``````")
}

$Tags = $Tags | Sort-Object

Write-Host "`nFound tags:" -ForegroundColor Blue
$Tags | ForEach-Object { Write-Host "  $($_)" }

# Update the README.md file

$CurrentContent = [System.IO.File]::ReadAllText((Join-Path $PSScriptRoot 'README.md'))

$TagsStartMarker = '<!-- TAGS START MARKER -->'
$TagsEndMarker = '<!-- TAGS END MARKER -->'
$TagsRegex = "(?s)$([regex]::Escape($TagsStartMarker)).*?$([regex]::Escape($TagsEndMarker))"

$TagsMarkdown = ($Tags | ForEach-Object { "- ``$_``" }) -join "`n"
$TagsSection = "$TagsStartMarker`n`n$TagsMarkdown`n`n$TagsEndMarker"

$NewContent = [regex]::Replace($CurrentContent, $TagsRegex, { $TagsSection })

$AppsMarker = '<!-- APPS LIST MARKER -->'
$AppsListMarkerIndex = $NewContent.IndexOf($AppsMarker) + $AppsMarker.Length + 1

$NewContent = $NewContent.Substring(0, $AppsListMarkerIndex)
$NewContent += ($MarkdownLines | Join-String -Separator "`n") + "`n"

[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot 'README.md'), $NewContent)
