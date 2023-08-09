# Juli 2023
## 24 Juli 2023 

First day, learn dotnet with c#, focused on ASP.NET.

-------
Path Leraning From mail: 
1. ASP .net core fundamental
https://app.pluralsight.com/library/courses/asp-dot-net-core-6-big-picture/table-of-contents
https://app.pluralsight.com/library/courses/asp-dot-net-core-6-fundamentals/table-of-contents

2. ASP. Net core API 
https://app.pluralsight.com/library/courses/asp-dot-net-core-6-web-api-fundamentals/table-of-contents

3. Dapper
https://app.pluralsight.com/library/courses/getting-started-dapper/table-of-contents

4. Training Project
Create new .net core project that will handle crud functionality for employee entity. Please build an API for employee
  - GET /employees return all employee
  - GET /employees/:id return specified employees
  - POST /employees add employee
  - PUT /employees/:id edit specified employee
  - DELETE /employees/:id delete specified employee

------
## 28 Juli 2023
first week, learning aspnet core fundamental, aspnet webapi fundametal, intro dapper database.
> last on webapi **04. Manipulating Resource and Validating Input**  
> last on aspnet core **08. Working With Form and Model Bindings**  
> last on intro dapper **Finish**  

note about ole db driver error: 
- https://stackoverflow.com/questions/71857345/error-when-installing-microsoft-sql-server-2019-cannot-find-the-microsoft-ole-d
- https://stackoverflow.com/questions/12534454/how-to-connect-to-localdb

## 31 juli 2023
- untuk menambahkan **exception** saat proses _development_ dapat digunakan `usedeveloperexception();`
- jika API yang direquest simple, dapat digunakan _one line_ dengan menggunakan minimal api, method dari `controllerbase` class
  ```C#
  app.mapGet("/error",
              () => Result.Problem();
            );
  ```

  API untuk training sudah dibuat, dengan menggunakan _Dapper_ dan _Stored Procedure_ dari T-SQL dari SQL server.


## 7 Agustus 2023
projek CRUD sudah diganti menggunakan dapper dan hanya memberikan backend saja(tanpa UI).
dari masukan yang didapatkan, 
 - `program.cs` harus dipahami perbarisnya
 - database yang telah dipelajari masih sangat kurang,
 - umpamakan penggunaan backend dengan sebuah UI
 - gunakan dokumentasi dari microsoft untuk mempelajari setiap class, method, dan properties dari program yang digunakan
 - pelajari build system dari ASP.NET (penggunaan *.json, environtment variable, dll)
 - autentifikasi, dan authorisasi yang telah dipelajari masih sangat basic, dan tidak benar" paham.

## 9 agustus 2023
karena pemahan SQL masih sangat basic, diberikan course dari pluralsight 

  - https://app.pluralsight.com/library/courses/introduction-to-sql/table-of-contents
  - https://app.pluralsight.com/library/courses/sql-server-database-programming-stored-procedures/table-of-contents
