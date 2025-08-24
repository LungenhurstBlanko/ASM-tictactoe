@echo off
setlocal enabledelayedexpansion


if not exist bin mkdir bin

for %%f in (*.asm) do (
    echo Assembling %%f ...
    nasm -f win64 %%f -o bin\%%~nf.obj
)
for %%f in (bin\*.obj) do (
    echo Linking %%f into main.exe ...
)
gcc bin\*.obj -o bin\main.exe

