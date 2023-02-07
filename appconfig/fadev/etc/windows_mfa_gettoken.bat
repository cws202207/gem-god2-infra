@echo off

set /p useCurrentToken="Refresh token? (y/n): "

if %useCurrentToken%==y (
    setlocal ENABLEDELAYEDEXPANSION
    set /p mfa="Please enter MFA One-Time-Password: "
    aws sts get-session-token --duration-seconds 86400 --serial-number arn:arn:aws:iam::660506286494:user/******* --token-code !mfa! --output json > temp.json
    endlocal
)

for /f "tokens=1,2 delims=:{} " %%A in (temp.json) do (
    If "%%~A"=="AccessKeyId" set accessKey=%%~B
    If "%%~A"=="SecretAccessKey" set secretAccessKey=%%~B
    If "%%~A"=="SessionToken" set sessionToken=%%~B
)

set accessKey=%accessKey:,=%
set accessKey=%accessKey:"=%
set secretAccessKey=%secretAccessKey:,=%
set secretAccessKey=%secretAccessKey:"=%
set sessionToken=%sessionToken:,=%
set sessionToken=%sessionToken:"=%

set AWS_ACCESS_KEY_ID=%accessKey%
set AWS_SECRET_ACCESS_KEY=%secretAccessKey%a
set AWS_SESSION_TOKEN=%sessionToken%

echo Token has been set into environment variables.

