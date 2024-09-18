$ServerInstance = "backups"
$DatabaseName = "Rimi_KristoferValk.sql"
$BackupDir = "C:\users\backups\databases"
$BackupFile = "${BackupDir}\${DatabaseName}"

$T = @{
  Frequency="Daily"
  At="4:00AM"
}
$O = @{
  WakeToRun=$true
  StartIfNotIdle=$false
  MultipleInstancePolicy="Queue"
}
Register-ScheduledJob -Trigger $T -ScheduledJobOption $O -scriptblock {
    mysqldump -u root -pPassw0rd rimi-database > $DatabaseName
    pscp -pw PASSWORD $DatabaseName USERNAME@BACKUPSERVER:$BackupFile
}
