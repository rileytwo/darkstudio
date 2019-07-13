#!/usr/bin/env pwsh

New-Item -ItemType SymbolicLink `
    -Value "./custom_styles.css" `
    -Path "C:\Program Files\RStudio\Resources\www\custom_styles.css" `
    -Force

New-Item -ItemType SymbolicLink `
    -Value "./index.htm" `
    -Path "C:\Program Files\RStudio\Resources\www\index.htm" `
    -Force
