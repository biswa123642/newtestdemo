Get-ChildItem 'kustomization.yaml' -Recurse | ForEach {
     (Get-Content $_ | ForEach  { $_ -replace '{{BUILD_NUMBER}}', '$BUILD_NUMBER' })
}
