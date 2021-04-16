#!/bin/bash

# Inputs

if [ -z "$1" ]; then
    echo "Please specify the app name as an argument"
    exit 0
fi

APP_NAME=$1


# Variables

SLN_FOLDER=$APP_NAME/src
DOMAIN_PROJ_NAME=$APP_NAME.domain
DOMAIN_TEST_PROJ_NAME=$DOMAIN_PROJ_NAME.tests
API_PROJ_NAME=$APP_NAME.api
API_TEST_PROJ_NAME=$API_PROJ_NAME.tests

DOMAIN_PROJ_FOLDER=$SLN_FOLDER/$DOMAIN_PROJ_NAME
DOMAIN_TEST_PROJ_FOLDER=$SLN_FOLDER/$DOMAIN_TEST_PROJ_NAME
API_PROJ_FOLDER=$SLN_FOLDER/$API_PROJ_NAME
API_TEST_PROJ_FOLDER=$SLN_FOLDER/$API_TEST_PROJ_NAME

DOMAIN_PROJ_FILE=$DOMAIN_PROJ_FOLDER/$DOMAIN_PROJ_NAME.csproj
DOMAIN_TEST_PROJ_FILE=$DOMAIN_TEST_PROJ_FOLDER/$DOMAIN_TEST_PROJ_NAME.csproj
API_PROJ_FILE=$API_PROJ_FOLDER/$API_PROJ_NAME.csproj
API_TEST_PROJ_FILE=$API_TEST_PROJ_FOLDER/$API_TEST_PROJ_NAME.csproj

# Set up dotnet solution and projects

dotnet new sln -n $APP_NAME -o $SLN_FOLDER
dotnet new classlib -o $DOMAIN_PROJ_FOLDER
dotnet new xunit -o $DOMAIN_TEST_PROJ_FOLDER
dotnet new webapi -o $API_PROJ_FOLDER
dotnet new xunit -o $API_TEST_PROJ_FOLDER
dotnet sln $SLN_FOLDER add \
    $DOMAIN_PROJ_FILE \
    $DOMAIN_TEST_PROJ_FILE \
    $API_PROJ_FILE \
    $API_TEST_PROJ_FILE

# Link projects 

dotnet add $API_PROJ_FILE reference $DOMAIN_PROJ_FILE
dotnet add $DOMAIN_TEST_PROJ_FILE reference $DOMAIN_PROJ_FILE
dotnet add $API_TEST_PROJ_FILE reference $API_PROJ_FILE $DOMAIN_PROJ_FILE

# Add packages

dotnet add $DOMAIN_TEST_PROJ_FILE package moq
dotnet add $DOMAIN_TEST_PROJ_FILE package fluentassertions
dotnet add $API_TEST_PROJ_FILE package moq
dotnet add $API_TEST_PROJ_FILE package fluentassertions

# Download .gitignore
wget https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore \
    -O $SLN_FOLDER/.gitignore

# Download azure pipelines file
wget https://raw.githubusercontent.com/microsoft/azure-pipelines-yaml/master/templates/asp.net-core.yml \
    -O $SLN_FOLDER/azure-pipelines.yml

# Create script to run api from root folder

echo dotnet run -p $API_PROJ_NAME > $SLN_FOLDER/dotnet-run.sh
chmod +x $SLN_FOLDER/dotnet-run.sh
