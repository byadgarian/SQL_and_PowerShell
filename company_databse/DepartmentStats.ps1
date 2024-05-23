##################################################################################################
#Please open Powershell in the directory that contains the Company.ps1 and 00. Company.sql files.#
##################################################################################################

###RETRIEVE THE STATS AND SAVE IN A .CSV FILE
Invoke-Sqlcmd -ServerInstance localhost -Database CPSC332 -Query "SELECT Tmp1.DepartmentName, SUM(Tmp2.Salary) AS SumOfSalary, AVG(Tmp2.Salary) AS AvgOfSalary, SUM(DISTINCT Tmp1.Hours) AS SumOfWorkingHours, SUM(DISTINCT Tmp1.Projects) AS TotalNumOfProjects
FROM   (SELECT D.Dname AS DepartmentName, SUM(W.Hours) AS Hours, COUNT(DISTINCT W.Pno) AS Projects
		FROM (dbo.EMPLOYEE AS E JOIN dbo.WORKS_ON AS W ON E.ssn = W.Essn) JOIN dbo.DEPARTMENT AS D ON D.Dnumber = E.Dno GROUP BY D.Dname) AS Tmp1
	   JOIN
	   (SELECT D.Dname AS DepartmentName, SUM(DISTINCT E.Salary) AS Salary FROM (dbo.EMPLOYEE AS E JOIN dbo.WORKS_ON AS W ON E.ssn = W.Essn) JOIN dbo.DEPARTMENT AS D ON D.Dnumber = E.Dno
		GROUP BY D.Dname, E.Ssn) AS Tmp2
	   ON Tmp1.DepartmentName = Tmp2.DepartmentName
GROUP BY Tmp1.DepartmentName;" |
Export-Csv -Path ./DepartmentStats.csv -NoTypeInformation;

###RETRIEVE AND PRINT THE STATS
Invoke-Sqlcmd -ServerInstance localhost -Database CPSC332 -Query "SELECT Tmp1.DepartmentName, SUM(Tmp2.Salary) AS SumOfSalary, AVG(Tmp2.Salary) AS AvgOfSalary, SUM(DISTINCT Tmp1.Hours) AS SumOfWorkingHours, SUM(DISTINCT Tmp1.Projects) AS TotalNumOfProjects
FROM   (SELECT D.Dname AS DepartmentName, SUM(W.Hours) AS Hours, COUNT(DISTINCT W.Pno) AS Projects
		FROM (dbo.EMPLOYEE AS E JOIN dbo.WORKS_ON AS W ON E.ssn = W.Essn) JOIN dbo.DEPARTMENT AS D ON D.Dnumber = E.Dno GROUP BY D.Dname) AS Tmp1
	   JOIN
	   (SELECT D.Dname AS DepartmentName, SUM(DISTINCT E.Salary) AS Salary FROM (dbo.EMPLOYEE AS E JOIN dbo.WORKS_ON AS W ON E.ssn = W.Essn) JOIN dbo.DEPARTMENT AS D ON D.Dnumber = E.Dno
		GROUP BY D.Dname, E.Ssn) AS Tmp2
	   ON Tmp1.DepartmentName = Tmp2.DepartmentName
GROUP BY Tmp1.DepartmentName;"

#alternatively use the folliwing commands to display the stats
#$SqlConnection = New-Object System.Data.SqlClient.SqlConnection;
#$SqlConnection.ConnectionString = "Server=localhost;Database=CPSC332;Integrated Security=True;";
#$SqlConnection.Open();
#$SqlCmd = New-Object System.Data.SqlClient.SqlCommand;
#$Sqlcmd.CommandTimeout = 0;
#$SqlCmd.Connection = $SqlConnection;
#$SqlCmd.CommandText = ""; #place the sql command above in this quotation mark
#$DataSet = $SqlCmd.ExecuteReader();
#While ($DataSet.Read()) {
#    Write-Host $DataSet["DepartmentName", "SumOfSalary", "AvgOfSalary", "SumOfWorkingHours", "TotalNumOfProjects"];
#};
#$SqlConnection.Close();