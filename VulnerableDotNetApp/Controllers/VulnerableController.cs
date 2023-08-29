// using Microsoft.AspNetCore.Mvc;

// namespace VulnerableDotNetApp.Controllers
// {
//     [ApiController]
//     [Route("[controller]")]
//     public class VulnerableController : ControllerBase
//     {
//         [HttpGet("sqlinjection")]
//         public IActionResult SqlInjection(string input)
//         {
//             // Simulate vulnerable SQL query
//             return Ok("Simulated SQL Injection");
//         }

//         [HttpGet("commandinjection")]
//         public IActionResult CommandInjection(string cmd)
//         {
//             // Simulate vulnerable command execution
//             return Ok("Simulated Command Injection");
//         }

//         [HttpGet("health")]
//         public IActionResult Health()
//         {
//             return Ok("Status: OK");
//         }
//     }
// }

using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.Sqlite;
using System;
using System.Diagnostics;

namespace VulnerableApp.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VulnerableController : ControllerBase
    {
        [HttpGet("sqlinjection")]
        public string SqlInjection(string query)
        {
            string result = "Query executed! Result: ";
            using (var connection = new SqliteConnection(@"Data Source=mydb.db"))
            {
                connection.Open();
                using (var command = new SqliteCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            result += reader.GetString(0) + ", ";
                        }
                    }
                }
            }
            return result;
        }

        [HttpGet("commandinjection")]
        public string CommandInjection(string cmd)
        {
            string output;
            try
            {
                Process proc = new Process
                {
                    StartInfo = new ProcessStartInfo
                    {
                        FileName = "/bin/bash",
                        Arguments = $"-c \"{cmd}\"",
                        RedirectStandardOutput = true,
                        UseShellExecute = false,
                        CreateNoWindow = true,
                    }
                };

                proc.Start();
                output = "Command executed! Result: " + proc.StandardOutput.ReadToEnd();
                proc.WaitForExit();
            }
            catch (Exception e)
            {
                output = $"Error: {e.Message}";
            }
            return output;
        }

        [HttpGet("health")]
        public string Health()
        {
            return "Status OK";
        }
    }
}
