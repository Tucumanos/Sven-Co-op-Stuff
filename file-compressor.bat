@echo off
SETLOCAL DisableDelayedExpansion

:: If you want to use custom extensions, change this
set extension=svenzip
:Start
PushD %~pd1
If [%1==[ Goto :EOF
for /r %1 %%g in (*.*) do (
if exist %%~ng.%extension% (
    echo "Skipping %%g, already compressed..." 
    ) else (
        "C:\Program Files\7-Zip\7z.exe" u -tgzip -mx=9 "%%g".%extension% "%%g" -x!*%extension%
        if exist "%%g".%extension% (
            :: WARNING: THIS WILL DELETE UNCOMPRESSED FILES AFTER COMPRESSION.
            :: If you don't want this, add 'rem' before in the two next lines
            echo "WARNING! DELETING ORIGIN FILE %%g"
            del "%%g"
            ) else (
            echo "Compression failed! File %%g"
        )
    )
)
Shift
PopD
Goto Start
pause
exit
