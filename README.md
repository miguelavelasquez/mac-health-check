# Mac Health Check

A read-only Bash script that prints a quick health report for a Mac. It uses only built-in macOS commands, needs no admin rights, and changes nothing on the system.

## What it checks

| Section  | Details                                   |
|----------|-------------------------------------------|
| System   | macOS version and build, model, chip, memory, uptime |
| Storage  | Free disk space on the startup drive      |
| Security | FileVault status, firewall status         |
| Battery  | Cycle count, condition, maximum capacity (laptops only) |

## Usage

```bash
chmod +x healthcheck.sh
./healthcheck.sh
```

## Example output

```
--- Security ---
FileVault: On
Firewall:  disabled

--- Battery ---
Cycles:       537
Condition:    Normal
Max capacity: 90%
```

## How it works

Each check runs a built-in macOS command (`sw_vers`, `system_profiler`, `df`, `fdesetup`, `socketfilterfw`) and uses `awk` to pull out only the line that matters. Debug output from `system_profiler` is discarded, and the battery section is skipped on desktop Macs.

## What I learned

- How to check a Mac's storage and security status from the command line, beyond what System Settings shows
- How to read battery health data: cycle count, condition, and maximum capacity
- To handle identifying information like serial numbers carefully before sharing output
- To understand a command before running it

## Planned for v2

- Warnings for low disk space, firewall off, or battery service recommended
- Check for pending software updates
- Save each report to a timestamped file

## Notes

Built as a guided learning project with AI assistance (Claude). I ran and reviewed each command on its own before adding it to the script, and I can explain every line.

Tested on macOS 26.6.2 (MacBook Pro, Apple M4 Pro).
