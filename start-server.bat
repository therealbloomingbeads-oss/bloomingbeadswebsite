@echo off
echo Starting Blooming Beads Website Server...
echo.
echo Your website will be available at: http://localhost:8080
echo Press Ctrl+C to stop the server
echo.
powershell -Command "& {Add-Type -AssemblyName System.Web; $listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:8080/'); $listener.Start(); Write-Host 'Server started at http://localhost:8080/'; while ($listener.IsListening) { $context = $listener.GetContext(); $request = $context.Request; $response = $context.Response; $localPath = $request.Url.LocalPath; $localPath = $localPath -replace '/', '\'; if ($localPath -eq '\') { $localPath = '\index.html'; } $filePath = (Get-Location).Path + $localPath; if (Test-Path $filePath -PathType Leaf) { $content = [System.IO.File]::ReadAllBytes($filePath); $response.ContentLength64 = $content.Length; $response.OutputStream.Write($content, 0, $content.Length); } else { $response.StatusCode = 404; $notFound = [System.Text.Encoding]::UTF8.GetBytes('File not found'); $response.ContentLength64 = $notFound.Length; $response.OutputStream.Write($notFound, 0, $notFound.Length); } $response.Close(); } }"
pause
