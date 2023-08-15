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

## 11 Agustus 2023, Training Palador Phase 2

- React Big Picture: https://app.pluralsight.com/library/courses/react-big-picture/table-of-contents
- React Basic: https://app.pluralsight.com/library/courses/react-js-getting-started/table-of-contents
- React with Typescript: https://app.pluralsight.com/library/courses/react-apps-typescript-building/table-of-contents
- Mobx: https://mobx.js.org/react-integration.html
- Project `Create new project that will handle crud functionality for employee entity. The Api will be the one that is created using .net core.`

### Note tentant `Issuer` dan `Audience` pada JWT
pemahaman yang didapat dari SO: https://security.stackexchange.com/questions/256794/should-i-specify-jwt-audience-and-issuer-if-i-have-only-one-spa-client

- `issuer` adalah informasi (link ) yang bertanggung jawab mengeluarkan/menerbitkan token (dapat berupa URL dari website yg mengeluarkan token). yang digunakan untuk menentukan kemanakah authentikasi dilakukan/dikirimkan.
- `Audience` adalah informasi untuk siapakah/apakah token diperuntukan. sehingga token untuk _weba.com_ tidak akan diproses di _webb.com_ jika pengirim mengirimkan token tersebut ke _weba.com_


(**contoh kasus karangan sendiri**), jika sebuah web authentifikasi sebut **AUTH** digunakan **client** untuk melakukan authentifikasi, dan client ingin mengakses beberapa resource dari web yang berbeda, maka informasi _issuer_ dapat digunakan web **resource** untuk memastikan user benar" seperti yang dia katakan (asli ter-**authentifikasi AUTH** ), dan _audience_ dapat digunakan client harus kemanakah client melakukan **authorisasi** resource berdasarkan **authentifikasi** yang telah client dapatkan.

## 13 Agustus 2023
### referensi UI 
![1aba1bf763237b0ad08614a884ff05c3](https://github.com/ahsanu123/learnNote/assets/81602442/e67abbfe-9ccc-4485-b938-c2182891b735)

## 14 Agustus 2023
###  Error: Cross Origin Request Blocked
`Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at https://localhost:7099/Employee. (Reason: CORS header ‘Access-Control-Allow-Origin’ missing). Status code: 200.`
ref: https://code-maze.com/enabling-cors-in-asp-net-core/

error ini terjadi karena **service** CORS belum diaktifkan **dan** mungkin jika menggunakan authentifikasi, harus ditambahkan atribut `[EnableCors("corsName")]` pada setiap class controller yang direquest


  ## 15 Agustus 2023
  ### note
  penggunaan fungsi seperti `fetch` maupun `axios` tidak sama dengan javascript, object harus memiliki struktur lengkap (membutuhkan Interface atau class). 
  **lebih dari 4 jam mempelajari assert(casting saat compile) di typescript**
  terakhir dapat mengubah response dari server ke objek seperti berikut:
```typescript
interface IEmployeDataStructure {
  empid: number,
  firstname: string,
  lastname: string,
  title: string,
  titleofcourtesy: string,
  birthdate: Date,
  hiredate: Date,
  address: string,
  city: string,
  region: string,
  postalcode: string,
  country: string,
  phone: string
}

class EmployeeDataStructure implements IEmployeDataStructure {
  empid: number = 0;
  firstname: string = "";
  lastname: string = "";
  title: string = "";
  titleofcourtesy: string = "";
  birthdate: Date = new Date();
  hiredate: Date = new Date();
  address: string = "";
  city: string = "";
  region: string = "";
  postalcode: string = "";
  country: string = "";
  phone: string = "";
}

.......
async function DoFetch(): Promise<IEmployeDataStructure[]> {

  var response = fetch('https://localhost:7099/Employee')
    .then(res => res.json())
    .then((empArr: Array<EmployeeDataStructure>) => empArr.map(
      (emp) => Object.assign(new EmployeeDataStructure(), emp)
    ))
  return response;
}
........
  useEffect(() => {
    DoFetch().then((emp: Array<EmployeeDataStructure>) => {
      SetEmployeeData(emp);
    });
  });

```


### note tentang MobX
observable diawasi oleh observer dibagi menjari 3: autorun, reaction, dan when

 - observable --> mengawasi variable dan memberi notifikasi ke observer jika variable berubah.
 - autorun --> memiliki sebuah input fungsi, jika dalam autorun memiliki variable(observable), dan variable tersebut berubah, maka action akan di re-execute
 - reaction  --> memiliki 2 buah argument (_ValueTracked, Callback_), ketika _ValueTracked_ berubah callback akan dipanggil, **berbeda dengan autorun kita bisa memilih tracked variable**
 - when --> memiliki 2 argument (_Predicate, Callback_) predicate mengharapkan return value boolean, jika _predicate_ bernilai **true** maka side-effect atau callback akan dipanggil, berbeda dengan autorun maupun reaction, setelah callback dari when dipanggil, when otomatis dibuang.
 - action --> untuk mengubah variable observable **_sangat disarankan menggunakan action_**, untuk memaksa pengubahan variable menggunakan **_action_** dapat digunakan `Configure({enforceaction: true})`
 - **HOC(High Order Component)** --> wrap react component to automaticly update on change observable state
 - **Inject** --> membuat bind **_HOC_** dr variable observable ke react component 
 - **Provider** --> menghubungkan observable dr inject ke variable/class tersebut

10 minutes guide: https://mobx.js.org/getting-started


1. First of all, there is the application state. Graphs of objects, arrays, primitives, references that forms the model of your application. These values are the “data cells” of your application.
2. Secondly there are derivations. Basically, any value that can be computed automatically from the state of your application. These derivations, or computed values, can range from simple values, like the number of unfinished todos, to complex stuff like a visual HTML representation of your todos. In spreadsheet terms: these are the formulas and charts of your application.
3. Reactions are very similar to derivations. The main difference is these functions don't produce a value. Instead, they run automatically to perform some task. Usually this is I/O related. They make sure that the DOM is updated or that network requests are made automatically at the right time.

4.Finally there are actions. Actions are all the things that alter the state. MobX will make sure that all changes to the application state caused by your actions are automatically processed by all derivations and reactions. Synchronously and glitch-free.

### note tentang **Observable**
terdapat beberapa tipe observable: observable.deep(atau observable saja), observable.shallow, observable.ref, observable.struct. **_penjelasan singkat lihat gambar_**
 - @observable, sama dengan @observable.deep
 - @observable.shallow = hanya memantau top level dari object (seperti array dsb)
 - @observable.ref = tidak memantau struktur dari object (seperti array) dan hanya melihat perubahan nilai
 - @observable.struct = hanya memantau pada struktunya dan akan memanggil reaction ketika terjadi perubahan nilai pada strukturnya, jika berubah namun nilai sama, reaction tidak akan dipanggil.
![image](https://github.com/ahsanu123/learnNote/assets/81602442/af1ad4c7-a7d0-4c2c-8c1a-a474a1c90140)

### note tentang `<Provider />` MobX
pada top leve, `<Provider/>` digunakan untuk memastikan koneksi antara variable _observable_ dan fungsi _inject_. secara internal **Providerr** menggunakan react context untuk menyebarkan _variable observable_ melalui decorator `Inject()`

### note tentang `Babel transpiller`
jika transpiller (babel dsb) belum support decorator, dapat menggunakan API dari MobX.
 - decorate() --> decorate(target, decorator-object)
 ```typescript
import { action, computed, decorate, observable } from 'mobx';
class BookSearchStore {
term = 'javascript';
status = '';
results = [];
totalCount = 0;
get isEmpty() {
return this.results.length === 0;
}
setTerm(value) {
this.term = value;
}
async search() {}
}
decorate(BookSearchStore, {
term: observable,
status: observable,
results: observable.shallow,
totalCount: observable,
isEmpty: computed,
setTerm: action.bound,
search: action.bound,
});
decorate(target, decorator-object)
``` 
 
 - observable() --> observable(target, decorator, option) dimana option adalah _debug friendly option_ dapat digunakan untuk memberikan nama dan pengaturan seperti **_deep_** yang berguna saat debuging, seperti penggunaan saat console.log
 - untuk **menambahkan observable** saat runtime dapat digunakan `extendObservable` --> extendObservable(target, object, decorator)
```typescript
import { observable, action, extendObservable } from 'mobx';
const cart = observable({
/* ... */
});
function applyFestiveOffer(cart) {
extendObservable(
cart,
{
coupons: ['OFF50FORU'],
get hasCoupons() {
return this.coupons && this.coupons.length > 0;
},
addCoupon(coupon) {
this.coupons.push(coupon);
},
},
{
coupons: observable.shallow,
addCoupon: action,
},
);
}
extendObservable(target, object, decorators)
```
