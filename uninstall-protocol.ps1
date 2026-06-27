Add-Type -AssemblyName PresentationFramework

$targetDir = Join-Path $env:USERPROFILE ".am-clinica-exocad"
$protocolName = "am-clinica-exocad"
$registryPath = "HKCU:\Software\Classes\$protocolName"

try {
    # 1. Eliminar el registro del protocolo personalizado
    if (Test-Path $registryPath) {
        Remove-Item -Path $registryPath -Recurse -Force
        $registryRemoved = $true
    } else {
        $registryRemoved = $false
    }

    # 2. Eliminar el directorio de configuración local
    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force
        $dirRemoved = $true
    } else {
        $dirRemoved = $false
    }

    $msg = "Desinstalación de la integración de Exocad completada:`n`n"
    if ($registryRemoved) { $msg += "- Registro de protocolo am-clinica-exocad:// eliminado.`n" }
    if ($dirRemoved) { $msg += "- Archivos y carpetas de configuración locales eliminados ($targetDir).`n" }
    if (-not $registryRemoved -and -not $dirRemoved) { $msg += "No se encontraron elementos activos de la instalación anterior." }

    [System.Windows.MessageBox]::Show($msg, "Desinstalación Exitosa", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
} catch {
    [System.Windows.MessageBox]::Show("Error durante la desinstalación: $_", "Error", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Error)
}
