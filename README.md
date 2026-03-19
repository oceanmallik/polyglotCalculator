> [!NOTE]
> ONLY ARM64 WORKS FOR NOW
To compile the c: 
```bash
gcc -shared -o subtraction.so -fPIC subtraction.c
```

To commpile the C#: 
```bash
dotnet publish CSharpMath/CSharpMath.csproj -c Release -r linux-arm64
cp CSharpMath/bin/Release/net10.0/linux-arm64/publish/multiplication .
```

### 4. Compile the C++ Orchestrator (The Brain)
*(This command automatically detects your architecture and links the Python environment)*
```bash
g++ calculator.cpp subtraction.so -o main -Wl,-rpath,. $(python3-config --cflags --embed --libs)
```

### 5. Run the Project
```bash
./main
```
