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
 ## 15 Agustus 2023
### note penggunaan `parameter` di typescript yang belum familiar
di typescript argument pada fungsi harus diberi tipe (seperti di c/c++), namun **_mungkin_**(pemikiran sendiri), ketika argument adalah instance dari sebuah class tertentu, penulisan argument harus menggunakan object dari sebuah class yang memiliki nama yang sama `{todoList}:{todoList: TodoList}`
```typescript
import { TodoList, Todo } from "../model/TodoList"
export const TodoListView = observer(({ todoList }: { todoList: TodoList }) => (
  <div>
    <ul>
      {todoList.todos.map(todo => (
        <TodoView todo={todo} key={todo.id} />
      ))}
    </ul>
    Tasks left: {todoList.unfinishedTodoCount}
  </div>
));

const TodoView = observer(({ todo }: { todo: Todo }) => (
  <li>
    <input
      type="checkbox"
      checked={todo.finished}
      onClick={() => todo.toggle()}
    />
    {todo.title}
  </li>
));

```

## 23 Agustus 2023
### Note React Hook
1. **useState** --> manage state (memorize field like button/input in component)
2. **useReducer** --> manage complex state instead of using multiple usestate
3. **usecontext** --> pass value deep to the tree (need a provider on top level tree)
4. **useeffect** --> synchronize component to external system, like API, etc
5. **usetransition** --> keep component responsive on middleof **_re-render_**, ex: when open tab with delay (or maybe animation) user can change to other tab without need to wait animation or delay to complete re-render

note: dispatch --> mengirim/menyuruh/mengurus

## 28 Agustus 2023
### Konversi JSON ke Map jika key tidak sama dengan employee id 

listing to convert JSON employee with id _mencar-mencar_
```typescript
const resjson = `[{"empid":1,"firstname":"Sara","lastname":"Davis","title":"CEO","titleofcourtesy":"-","birthdate":"1968-12-08T00:00:00","hiredate":"2020-05-01T00:00:00","address":"7890 - 20th Ave. E., Apt. 2A","city":"Seattle","region":"WA","postalcode":"10003","country":"USA","phone":"206 5550101"},{"empid":2,"firstname":"Doni","lastname":"Funk","title":"Vice President, Sales","titleofcourtesy":"-","birthdate":"1972-02-19T00:00:00","hiredate":"2020-08-14T00:00:00","address":"9012 W. Capital Way","city":"Tacoma","region":"WA","postalcode":"10001","country":"USA","phone":"206 5550100"},{"empid":3,"firstname":"Judy","lastname":"Lewis","title":"Sales Manager","titleofcourtesy":"-","birthdate":"1983-08-30T00:00:00","hiredate":"2020-04-01T00:00:00","address":"2345 Moss Bay Blvd.","city":"Kirkland","region":"WA","postalcode":"10007","country":"USA","phone":"206 5550103"},{"empid":4,"firstname":"Yael","lastname":"Peled","title":"Sales Representative","titleofcourtesy":"-","birthdate":"1957-09-19T00:00:00","hiredate":"2021-05-03T00:00:00","address":"5678 Old Redmond Rd.","city":"Redmond","region":"WA","postalcode":"10009","country":"USA","phone":"206 5550104"},{"empid":5,"firstname":"Sven","lastname":"Mortensen","title":"Sales Manager","titleofcourtesy":"-","birthdate":"1975-03-04T00:00:00","hiredate":"2021-10-17T00:00:00","address":"8901 Garrett Hill","city":"London","region":"NYC","postalcode":"10004","country":"UK","phone":"71 2345678"},{"empid":6,"firstname":"Paul","lastname":"Suurs","title":"Sales Representative","titleofcourtesy":"-","birthdate":"1983-07-02T00:00:00","hiredate":"2021-10-17T00:00:00","address":"3456 Coventry House, Miner Rd.","city":"London","region":"NYC","postalcode":"10005","country":"UK","phone":"71 3456789"},{"empid":7,"firstname":"Russell","lastname":"King","title":"Sales Representative","titleofcourtesy":"-","birthdate":"1980-05-29T00:00:00","hiredate":"2022-01-02T00:00:00","address":"6789 Edgeham Hollow, Winchester Way","city":"London","region":"NYC","postalcode":"10002","country":"UK","phone":"71 1234567"},{"empid":8,"firstname":"Maria","lastname":"Cameron","title":"Sales Representative","titleofcourtesy":"-","birthdate":"1978-01-09T00:00:00","hiredate":"2022-03-05T00:00:00","address":"4567 - 11th Ave. N.E.","city":"Seattle","region":"WA","postalcode":"10006","country":"USA","phone":"206 5550102"},{"empid":9,"firstname":"Patricia","lastname":"Doyle","title":"Sales Representative","titleofcourtesy":"-","birthdate":"1986-01-27T00:00:00","hiredate":"2022-11-15T00:00:00","address":"1234 Houndstooth Rd.","city":"London","region":"NYC","postalcode":"10008","country":"UK","phone":"71 4567890"},{"empid":30,"firstname":"Marlin","lastname":"Gonzalez","title":"Mr","titleofcourtesy":"-","birthdate":"2001-08-02T00:00:00","hiredate":"2010-01-20T00:00:00","address":"P Shermen Jalan Wallaby 42 Sydney","city":"Sydney","region":"Central Park","postalcode":"50192","country":"Australia","phone":"9019 19212"},{"empid":43,"firstname":"Stacy","lastname":"Knight","title":"Ms","titleofcourtesy":"-","birthdate":"2001-02-02T00:00:00","hiredate":"2023-02-03T00:00:00","address":"Restaurant street 7","city":"kobe","region":"NYC","postalcode":"4092","country":"UK","phone":"14061"},{"empid":45,"firstname":"Ellen","lastname":"Castro","title":"Ms","titleofcourtesy":"-","birthdate":"2022-02-02T00:00:00","hiredate":"2023-08-19T00:00:00","address":"Lab street 90 ","city":"manhattan","region":"NYC","postalcode":"89102","country":"UK","phone":"082812"},{"empid":50,"firstname":"Minnie","lastname":"Davidson","title":"Ms","titleofcourtesy":"-","birthdate":"1993-02-12T00:00:00","hiredate":"2013-03-12T00:00:00","address":"Central Park street 7","city":"Manchester","region":"NYC","postalcode":"140923","country":"UK","phone":"14061 92"},{"empid":52,"firstname":"Sama Binti","lastname":"Abdulhadi","title":"-","titleofcourtesy":"-","birthdate":"2001-06-07T00:00:00","hiredate":"2023-07-30T00:00:00","address":"Montenegros","city":"Cetral Sydney","region":"West Sydney","postalcode":"09121","country":"Australia","phone":"988123 192"}]`

interface User{
    empid: number,
    firstname: string ,
    lastname: string ,
    title: string ,
    titleofcourtesy: string ,
    birthdate: string,
    hiredate: string,
    address: string ,
    city: string,
    region: string,
    postalcode: string,
    country: string,
    phone: string ,

}

let tupple: [number, User][] = []

let resUser: User[] = JSON.parse(resjson)

console.log(tupple.length)
resUser.map(user => tupple.push([user.empid, user]))
console.log(tupple.length)

let mapTupple = new Map(tupple);

console.log(mapTupple.get(5))

  
```
