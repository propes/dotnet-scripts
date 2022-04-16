## Dotnet project setup scripts

A collection of scripts for automating the setup of common dotnet projects.

Scripts:
- `dotnet-console.sh`: creates a console project with a class library and an xunit test project
- `dotnet-lib.sh`: creates a class library project with an xunit test project
- `dotnet-web-api.sh`: creates a web api project with a domain library and corresponding xunit projects
- `dotnet-web-api-ee.sh`: creates an enterprise web api project with a domain, data and service layers and correspodning xunit projects


Usage:

```sh
sh dotnet-web-api.sh test-app
```
