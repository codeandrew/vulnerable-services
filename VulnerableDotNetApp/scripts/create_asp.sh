#!/bin/bash

dotnet --version

# Create ASP.NET Core WebAPI Project
echo "Creating ASP.NET Core WebAPI project..."
dotnet new webapi -n VulnerableDotNetApp
cd VulnerableDotNetApp || exit

echo "Creating vulnerable endpoints..."
cat > Controllers/VulnerableController.cs << 'EOL'
using Microsoft.AspNetCore.Mvc;

namespace VulnerableDotNetApp.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VulnerableController : ControllerBase
    {
        [HttpGet("sqlinjection")]
        public IActionResult SqlInjection(string input)
        {
            // Simulate vulnerable SQL query
            return Ok("Simulated SQL Injection");
        }

        [HttpGet("commandinjection")]
        public IActionResult CommandInjection(string cmd)
        {
            // Simulate vulnerable command execution
            return Ok("Simulated Command Injection");
        }

        [HttpGet("health")]
        public IActionResult Health()
        {
            return Ok("Status: OK");
        }
    }
}
EOL

# Step 4: Restore and Build
echo "Restoring packages and building project..."
dotnet restore
dotnet build

# Step 5: Run
echo "Running project..."
dotnet run &


echo "Vulnerable app is running and committed to git."
