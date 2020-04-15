#!/bin/bash

# Inputs

if [ -z "$1" ]; then
    echo "Please specify the app name as an argument"
    exit 0
fi

APP_NAME=$1


# Variables

SLN_FOLDER=$APP_NAME/src
CONSOLE_PROJ_NAME=$APP_NAME
CLASSLIB_PROJ_NAME=$APP_NAME.Lib
TEST_PROJ_NAME=$APP_NAME.Lib.Tests


# Set up dotnet solution and projects

dotnet new sln -n $APP_NAME -o $SLN_FOLDER
dotnet new console -o $SLN_FOLDER/$CONSOLE_PROJ_NAME
dotnet new classlib -o $SLN_FOLDER/$CLASSLIB_PROJ_NAME
dotnet new xunit -o $SLN_FOLDER/$TEST_PROJ_NAME
dotnet sln $SLN_FOLDER add $SLN_FOLDER/$CONSOLE_PROJ_NAME/$CONSOLE_PROJ_NAME.csproj
dotnet sln $SLN_FOLDER add $SLN_FOLDER/$CLASSLIB_PROJ_NAME/$CLASSLIB_PROJ_NAME.csproj
dotnet sln $SLN_FOLDER add $SLN_FOLDER/$TEST_PROJ_NAME/$TEST_PROJ_NAME.csproj

# Link projects 

dotnet add $SLN_FOLDER/$CONSOLE_PROJ_NAME/$CONSOLE_PROJ_NAME.csproj reference $SLN_FOLDER/$CLASSLIB_PROJ_NAME/$CLASSLIB_PROJ_NAME.csproj
dotnet add $SLN_FOLDER/$TEST_PROJ_NAME/$TEST_PROJ_NAME.csproj reference $SLN_FOLDER/$CLASSLIB_PROJ_NAME/$CLASSLIB_PROJ_NAME.csproj


# Add packages

dotnet add $SLN_FOLDER/$TEST_PROJ_NAME/$TEST_PROJ_NAME.csproj package moq

# Create script to run api from root folder

echo dotnet run -p $APP_NAME > $SLN_FOLDER/run.sh
chmod +x $SLN_FOLDER/run.sh
