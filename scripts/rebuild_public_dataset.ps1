param(
    [string]$RepoRoot = "C:\Users\jdani\Documents\codex_sandbox\GitHub\database-neuroingenieriauc-main",
    [string]$OriginalsRoot = "C:\Users\jdani\Documents\codex_sandbox\Data Base\Originals"
)

$ErrorActionPreference = "Stop"

$SubjectMap = [ordered]@{
    "AP" = "S01"
    "CT" = "S02"
    "EA" = "S03"
    "EG" = "S04"
    "GA" = "S05"
    "IG" = "S06"
    "JB" = "S07"
    "LA" = "S08"
    "OI" = "S09"
    "TR" = "S10"
    "EZ" = "S11"
    "FM" = "S12"
    "MF" = "S13"
    "SS" = "S14"
}

$TaskConfigs = @(
    @{
        SourceSubdir = "Marcha"
        TargetTask = "gait"
        Protocol = "10MWT"
        OptionalFields = @("Speed (m/s)")
    },
    @{
        SourceSubdir = "Subir_Escaleras"
        TargetTask = "stair_ascent"
        Protocol = "9SAD"
        OptionalFields = @("Speed (m/s)", "Stair Time (s)", "Time Source", "Vertical Gain (m)")
    },
    @{
        SourceSubdir = "Bajar_Escaleras"
        TargetTask = "stair_descent"
        Protocol = "9SAD"
        OptionalFields = @("Speed (m/s)", "Stair Time (s)", "Time Source", "Vertical Drop (m)")
    }
)

$BaseMetadataOrder = @(
    "Operator",
    "Subject",
    "Clinical Description",
    "Age",
    "Height (cm)",
    "Weight (kg)",
    "Activity",
    "Inclination",
    "Instrumentation",
    "Reference Orientation",
    "Measurement",
    "Sensor Location",
    "Segmentation",
    "Sampling Frequency",
    "Number of Samples",
    "Description"
)

function Get-Initials {
    param([string]$Name)

    $matches = [regex]::Matches($Name, "\p{L}+")
    if ($matches.Count -eq 0) {
        throw "Could not derive initials from '$Name'."
    }

    return (($matches | ForEach-Object {
                $_.Value.Substring(0, 1).ToUpperInvariant()
            }) -join "")
}

function Get-MetadataMap {
    param([string[]]$MetadataLines)

    $metadata = [ordered]@{}
    foreach ($line in $MetadataLines) {
        $parts = $line -split ",", 2
        $key = $parts[0]
        $value = if ($parts.Count -gt 1) { $parts[1] } else { "" }
        $metadata[$key] = $value
    }

    return $metadata
}

function Format-Height {
    param([string]$Value)

    $height = 0.0
    if ([double]::TryParse($Value, [System.Globalization.NumberStyles]::Float, [System.Globalization.CultureInfo]::InvariantCulture, [ref]$height)) {
        if ($height -gt 0 -and $height -lt 10) {
            return ($height * 100).ToString("0.0", [System.Globalization.CultureInfo]::InvariantCulture)
        }
    }

    return $Value
}

function Format-DateTimeFromFilename {
    param([string]$FileName)

    if ($FileName -notmatch "^(?<stamp>\d{12})(?<initials>[A-Z]+)_") {
        throw "Unexpected original filename format: $FileName"
    }

    $dateTime = [datetime]::ParseExact(
        $matches["stamp"],
        "yyyyMMddHHmm",
        [System.Globalization.CultureInfo]::InvariantCulture
    )

    return @{
        SubjectInitials = $matches["initials"]
        TrialDateTime = $dateTime.ToString("yyyy-MM-ddTHH:mm")
    }
}

function Get-SampleCountValue {
    param(
        [System.Collections.Specialized.OrderedDictionary]$Metadata,
        [int]$ActualSampleCount
    )

    $rawValue = ""
    if ($Metadata.Contains("Number of Samples")) {
        $rawValue = $Metadata["Number of Samples"]
    }

    $sampleCount = 0
    if ([int]::TryParse($rawValue, [ref]$sampleCount)) {
        return $rawValue
    }

    return [string]$ActualSampleCount
}

function Get-MetadataValue {
    param(
        [System.Collections.Specialized.OrderedDictionary]$Metadata,
        [string]$Key,
        [string]$Task
    )

    if ($Metadata.Contains($Key)) {
        return $Metadata[$Key]
    }

    if ($Task -eq "stair_ascent" -and $Key -eq "Vertical Gain (m)") {
        return "1.530"
    }

    if ($Task -eq "stair_descent" -and $Key -eq "Vertical Drop (m)") {
        return "1.530"
    }

    return ""
}

function New-RebuiltCsvContent {
    param(
        [string]$SourceFilePath,
        [string]$SubjectId,
        [string]$Task,
        [string[]]$OptionalFields,
        [string]$TrialDateTime
    )

    $lines = Get-Content -LiteralPath $SourceFilePath
    $separatorIndex = [Array]::IndexOf($lines, "")
    if ($separatorIndex -lt 0) {
        throw "Missing blank metadata separator in $SourceFilePath"
    }

    $metadataLines = if ($separatorIndex -gt 0) { $lines[0..($separatorIndex - 1)] } else { @() }
    $dataLines = if ($separatorIndex + 1 -le $lines.Length - 1) { $lines[($separatorIndex + 1)..($lines.Length - 1)] } else { @() }
    $metadata = Get-MetadataMap -MetadataLines $metadataLines
    $actualSampleCount = [Math]::Max(0, $dataLines.Count - 1)

    $rebuilt = [ordered]@{}
    foreach ($key in $BaseMetadataOrder) {
        switch ($key) {
            "Operator" {
                $rebuilt[$key] = Get-Initials -Name (Get-MetadataValue -Metadata $metadata -Key $key -Task $Task)
            }
            "Subject" {
                $rebuilt[$key] = $SubjectId
            }
            "Height (cm)" {
                $rebuilt[$key] = Format-Height -Value (Get-MetadataValue -Metadata $metadata -Key $key -Task $Task)
            }
            "Number of Samples" {
                $rebuilt[$key] = Get-SampleCountValue -Metadata $metadata -ActualSampleCount $actualSampleCount
            }
            default {
                $rebuilt[$key] = Get-MetadataValue -Metadata $metadata -Key $key -Task $Task
            }
        }
    }

    foreach ($key in $OptionalFields) {
        $rebuilt[$key] = Get-MetadataValue -Metadata $metadata -Key $key -Task $Task
    }

    $outputLines = New-Object System.Collections.Generic.List[string]
    foreach ($entry in $rebuilt.GetEnumerator()) {
        $outputLines.Add(("{0},{1}" -f $entry.Key, $entry.Value))
    }
    $outputLines.Add(("Trial DateTime,{0}" -f $TrialDateTime))
    $outputLines.Add("")
    foreach ($line in $dataLines) {
        $outputLines.Add($line)
    }

    return $outputLines
}

function Write-Utf8NoBom {
    param(
        [string]$Path,
        [System.Collections.Generic.List[string]]$Lines
    )

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines($Path, $Lines, $utf8NoBom)
}

$rawRoot = Join-Path $RepoRoot "data\raw"
$stagingRoot = Join-Path $RepoRoot "data\_rebuilt_raw"

if (Test-Path -LiteralPath $stagingRoot) {
    Remove-Item -LiteralPath $stagingRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $stagingRoot | Out-Null

$summary = New-Object System.Collections.Generic.List[string]

foreach ($config in $TaskConfigs) {
    $sourceDir = Join-Path $OriginalsRoot $config.SourceSubdir
    $targetDir = Join-Path $stagingRoot $config.TargetTask
    New-Item -ItemType Directory -Path $targetDir | Out-Null

    $files = Get-ChildItem -LiteralPath $sourceDir -Filter "*.csv"
    $filesBySubject = $files | Group-Object {
        (Format-DateTimeFromFilename -FileName $_.Name).SubjectInitials
    }

    foreach ($subjectGroup in $filesBySubject) {
        $subjectInitials = $subjectGroup.Name
        if (-not $SubjectMap.Contains($subjectInitials)) {
            throw "Missing global subject mapping for '$subjectInitials'."
        }

        $subjectId = $SubjectMap[$subjectInitials]
        $trialFiles = $subjectGroup.Group | Sort-Object Name
        if ($trialFiles.Count -ne 3) {
            throw "Expected 3 trials for $subjectInitials in $($config.SourceSubdir), found $($trialFiles.Count)."
        }

        for ($index = 0; $index -lt $trialFiles.Count; $index++) {
            $sourceFile = $trialFiles[$index]
            $nameInfo = Format-DateTimeFromFilename -FileName $sourceFile.Name
            $trialNumber = "{0:D2}" -f ($index + 1)
            $targetFileName = "{0}_{1}_{2}_{3}.csv" -f $subjectId, $config.TargetTask, $config.Protocol, $trialNumber
            $targetPath = Join-Path $targetDir $targetFileName

            $content = New-RebuiltCsvContent `
                -SourceFilePath $sourceFile.FullName `
                -SubjectId $subjectId `
                -Task $config.TargetTask `
                -OptionalFields $config.OptionalFields `
                -TrialDateTime $nameInfo.TrialDateTime

            Write-Utf8NoBom -Path $targetPath -Lines $content
            $summary.Add(("{0} -> {1}" -f $sourceFile.Name, $targetFileName))
        }
    }
}

$rebuiltCsvCount = (Get-ChildItem -LiteralPath $stagingRoot -Recurse -Filter "*.csv").Count
if ($rebuiltCsvCount -ne 90) {
    throw "Expected 90 rebuilt CSV files, found $rebuiltCsvCount."
}

foreach ($taskDir in Get-ChildItem -LiteralPath $rawRoot -Directory) {
    Get-ChildItem -LiteralPath $taskDir.FullName -Filter "*.csv" | Remove-Item -Force
}

foreach ($rebuiltTaskDir in Get-ChildItem -LiteralPath $stagingRoot -Directory) {
    Get-ChildItem -LiteralPath $rebuiltTaskDir.FullName -Filter "*.csv" | Move-Item -Destination (Join-Path $rawRoot $rebuiltTaskDir.Name)
}

Remove-Item -LiteralPath $stagingRoot -Recurse -Force

Write-Host "Rebuilt $rebuiltCsvCount CSV files from originals."
foreach ($line in $summary | Sort-Object) {
    Write-Host $line
}
