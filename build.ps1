Write-Host "--- Building 5-Language Polyglot Calculator for Windows ---" -ForegroundColor Cyan

Write-Host "`n1. Compiling C Library (Subtraction)..." -ForegroundColor Yellow
gcc -shared -o subtraction.dll subtraction.c

Write-Host "2. Compiling C# Executable (Multiplication)..." -ForegroundColor Yellow
dotnet publish CSharpMath/CSharpMath.csproj -c Release -r win-x64
Copy-Item -Path "CSharpMath\bin\Release\net*\win-x64\publish\multiplication.exe" -Destination "." -Force

Write-Host "3. Compiling Rust Library (Division)..." -ForegroundColor Yellow
Set-Location -Path "division"
cargo build --release
Set-Location -Path ".."
Copy-Item -Path "division\target\release\division.dll" -Destination "." -Force

Write-Host "4. Configuring Python Environment dynamically..." -ForegroundColor Yellow
# Auto-detect Python path and exact version
$PY_PATH = python -c "import sys; import os; print(os.path.dirname(sys.executable))"
$PY_LIB = python -c "import sys; print(f'python{sys.version_info.major}{sys.version_info.minor}')"

# Generate the C++ header file
$ESCAPED_PATH = $PY_PATH.Replace("\", "\\")
"const wchar_t* PYTHON_HOME_PATH = L`"$ESCAPED_PATH`";" | Out-File -Encoding ASCII python_config.h

# Copy the Python core DLL to the project folder
Copy-Item -Path "$PY_PATH\$PY_LIB.dll" -Destination "." -Force

Write-Host "5. Compiling C++ Orchestrator..." -ForegroundColor Yellow
# Wrapped flags in quotes to force PowerShell variable expansion
g++ calculator.cpp subtraction.dll division.dll -o main.exe "-I$PY_PATH\include" "-L$PY_PATH\libs" "-l$PY_LIB"

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[ERROR] C++ Compilation Failed! See the output above." -ForegroundColor Red
    exit
}

Write-Host "`n--- Build Complete! ---" -ForegroundColor Green
Write-Host "Run .\main.exe to start the calculator." -ForegroundColor White