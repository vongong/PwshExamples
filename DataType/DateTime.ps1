
## Get Current Date Time
Get-Date

## Date Time Components
$now = Get-Date
$now.Year
$now.Month
$now.Day
$now.Hour
$now.Minute
$now.Second
$now.Millisecond

## Format Date
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

## Set Date
$StartDate = [datetime]"02/25/2024 13:13"

## Date Span
$StartDate = [datetime]"01/01/2024 00:00"
$EndDate = (GET-DATE)
New-TimeSpan -Start $StartDate -End $EndDate

## Add time
# To add or subtract time, use the AddDays, AddHours, AddMinutes, or AddSeconds methods.
(Get-Date).AddDays(1)
(Get-Date).AddHours(-2)
