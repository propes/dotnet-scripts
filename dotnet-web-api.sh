#!/bin/bash

# Inputs

if [ -z "$1" ]; then
    echo "Please specify the app name as an argument"
    exit 0
fi

APP_NAME=$1


# Variables

SLN_FOLDER=$APP_NAME/src
API_PROJ_NAME=$APP_NAME.Api
TEST_PROJ_NAME=$APP_NAME.Api.Tests


# Set up dotnet solution and projects

dotnet new sln -n $APP_NAME -o $SLN_FOLDER
dotnet new webapi -o $SLN_FOLDER/$API_PROJ_NAME
dotnet new xunit -o $SLN_FOLDER/$TEST_PROJ_NAME
dotnet sln $SLN_FOLDER add $SLN_FOLDER/$API_PROJ_NAME/$API_PROJ_NAME.csproj
dotnet sln $SLN_FOLDER add $SLN_FOLDER/$TEST_PROJ_NAME/$TEST_PROJ_NAME.csproj


# Create script to run api from root folder

echo dotnet run -p $API_PROJ_NAME > $SLN_FOLDER/dotnet-run.sh

