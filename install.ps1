$targetPath = "$home\Documents\WindowsPowerShell\Modules\Primer-DSL\";

if(-not (Test-Path $targetPath)) {
    md $targetPath
}
cp ".\Primer-DSL.psm1" $targetPath -Force