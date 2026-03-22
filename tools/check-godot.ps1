param(
    [string]$Godot = $env:GODOT
)

function Resolve-GodotCommand {
    param(
        [string]$ConfiguredGodot
    )

    if ($ConfiguredGodot) {
        if (Test-Path $ConfiguredGodot) {
            return (Resolve-Path $ConfiguredGodot).Path
        }

        return $ConfiguredGodot
    }

    foreach ($name in @("godot", "godot4")) {
        $command = Get-Command $name -ErrorAction SilentlyContinue
        if ($command) {
            return $command.Source
        }
    }

    $patterns = @(
        "$env:ProgramFiles\\Godot\\Godot*.exe",
        "$env:LOCALAPPDATA\\Programs\\Godot\\Godot*.exe",
        "$env:USERPROFILE\\Downloads\\Godot*_win64*.exe"
    )

    $matches = foreach ($pattern in $patterns) {
        Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue
    }

    $latest = $matches | Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($latest) {
        return $latest.FullName
    }

    return $null
}

$command = Resolve-GodotCommand -ConfiguredGodot $Godot

if (-not $command) {
    Write-Error "Godot was not found. Add it to PATH, or set GODOT to the executable path."
    exit 1
}

try {
    $version = & $command --version 2>&1
}
catch {
    Write-Error "Found a Godot candidate at '$command', but it could not be executed."
    exit 1
}

Write-Output "Godot command: $command"
Write-Output "Version: $version"
Write-Output "Tip: once project.godot exists, validate with:"
Write-Output "  & '$command' --headless --quit"
