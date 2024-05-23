##################################################################################################
#Please open Powershell in the directory that contains the Company.ps1 and 00. Company.sql files.#
##################################################################################################

###CREATE THE CPSC332 DATABASE
Invoke-Sqlcmd -ServerInstance localhost -Database master -Query "CREATE DATABASE CPSC332";   #use the default master database to create a new database

#alternatively use the following commands to create the CPSC332 database
#$SqlConnection = New-Object System.Data.SqlClient.SqlConnection;
#$SqlConnection.ConnectionString = "Server=localhost;Database=master;Integrated Security=True;";
#$SqlConnection.Open();
#$SqlCmd = New-Object System.Data.SqlClient.SqlCommand;
#$Sqlcmd.CommandTimeout = 0;
#$SqlCmd.Connection = $SqlConnection;
#$SqlCmd.CommandText = "CREATE DATABASE CPSC332;";
#$SqlCmd.ExecuteReader();
#$SqlConnection.Close();

###IMPORT COMPANY STRUCTURE INTO CPSC332 DATABASE
Invoke-Sqlcmd -ServerInstance localhost -Database CPSC332 -InputFile ".\00. Company.sql" -ErrorAction Stop;