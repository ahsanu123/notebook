

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

## 29 Agustus 2023
### Javascript/Typescript Learning List
![image](https://github.com/ahsanu123/learnNote/assets/81602442/51498341-fb6b-4daf-927d-9852e889ea60)

- 28 Agustus 2023
  1. Asynchronous ✔️
  2. Promise ✔️
  3. Nullish Coallesching ✔️
  4. Reduce ✔️
  5. Callback ✔️
  6. Map ✔️
 
- 29 Agustus 2023
  1. Arrow Function ✔️
  2. Destruction ✔️
  3. Array Of Object ✔️
  4. Advance Classes ✅

- 30 Agustus 2023
  1. JSON ✔️
  2. Fetch ✔️
  3. Lexical Scope ✔️
  4. Dom Selection ✔️
   
**A statement is a piece of code that can be executed and performs some kind of action**  
**An expression is a piece of code that can be evaluated to produce a value**  

### Penggunaan `Suspense` dan `Lazy`
jika menggunakan komponen asli dari `Calenda.js`, gunakan code sebagai berikut.
```typescript
const LazyCalendar = lazy(() => import("./Calendar.js"))
```

```typescript
import React, { lazy, Suspense, useState } from "react";
import "./styles.css";

const module = {
  default: () => <div>Big Calendar</div>
};

function getPromise() {
  return new Promise((resolve) => setTimeout(() => resolve(module), 3000));
}

const LazyCalendar = lazy(getPromise);

function CalendarWrapper() {
  const [isOn, setIsOn] = useState(false);
  return isOn ? (
    <LazyCalendar />
  ) : (
    <div>
      <button onClick={() => setIsOn(true)}>Show Calendar</button>
    </div>
  );
}

export default function App() {
  return (
    <div className="App">
      <main>Main App</main>
      <aside>
        <Suspense fallback={<div>Loading...</div>}>
          <CalendarWrapper />
        </Suspense>
        <Suspense fallback={<div>Loading...</div>}>
          <CalendarWrapper />
        </Suspense>
      </aside>
    </div>
  );
}


```

## 30 Agustus 2023
### Bingung Penggunaan Suspense dan lazy
suspense dapat auto memberi loading menggunakan component yang di _pass_ ke fallback, namun dalam case **ini** component memerlukan fetch, sehingga terdapat operasi async dan return promise, **masalahnya** untuk merubah promise menjadi variable biasa (const) masih bingung. berikut kode dari example logrocket.com yang telah diubah menjadi typescript.

```typescript
function wrapPromise<T>(promise: Promise<T>) {
  let status: 'pending' | 'success' | 'error' = 'pending';
  let response: T | Error;

  const suspender = promise.then(
    (res) => {
      status = 'success';
      response = res;
    },
    (err) => {
      status = 'error';
      response = err;
    }
  );

  const read = () => {
    switch (status) {
      case 'pending':
        throw suspender;
      case 'error':
        throw response;
      default:
        return response;
    }
  };

  return { read };
}

export default wrapPromise;

function fetchData(url: string) {
  const promise = fetch(url)
    .then((res) => res.json())
    .then((res) => res.data);

  return wrapPromise(promise);
}

export default fetchData;
```
### baca rekomendasi react suspense dari team
link: https://blog.logrocket.com/async-rendering-react-suspense/

example code dari link diatas, yang dikonversi ke typescript

```typescript
import { fetchShows } from "../fetchShows";
import * as Styles from "./styles";

const resource = fetchShows();

const formatScore = (number: number): number => {
  return Math.round(number * 100);
};

const Shows = (): JSX.Element => {
  const shows = resource.read();

  return (
    <Styles.Root>
      <Styles.Container>
        {shows.map((show, index) => (
          <Styles.ShowWrapper key={index}>
            <Styles.ImageWrapper>
              <img
                src={show.show.image ? show.show.image.original : ""}
                alt="Show Poster"
              />
            </Styles.ImageWrapper>
            <Styles.TextWrapper>
              <Styles.Title>{show.show.name}</Styles.Title>
              <Styles.Subtitle>
                Score: {formatScore(show.score)}
              </Styles.Subtitle>
              <Styles.Subtitle>Status: {show.show.status}</Styles.Subtitle>
              <Styles.Subtitle>
                Network: {show.show.network ? show.show.network.name : "N/A"}
              </Styles.Subtitle>
            </Styles.TextWrapper>
          </Styles.ShowWrapper>
        ))}
      </Styles.Container>
    </Styles.Root>
  );
};

export default Shows;

import axios from "axios";

export const fetchShows = () => {
  let status = "pending";
  let result: any;
  let suspender = axios(`https://api.tvmaze.com/search/shows?q=heist`).then(
    (r) => {
      status = "success";
      result = r.data;
    },
    (e) => {
      status = "error";
      result = e;
    }
  );

  return {
    read() {
      if (status === "pending") {
        throw suspender;
      } else if (status === "error") {
        throw result;
      } else if (status === "success") {
        return result;
      }
    },
  };
};


function App() {
 return (
   <div className="App">
     <header className="App-header">
       <h1 className="App-title">React Suspense Demo</h1>
     </header>
     <ErrorBoundary fallback={<p>Could not fetch TV shows.</p>}>
       <Suspense fallback={<p>loading...</p>}>
         <Shows />
       </Suspense>
     </ErrorBoundary>
   </div>
 );
}
```

### React suspense first ok
referensi: https://blog.openreplay.com/data-fetching-with-suspense-in-react/
note: kenapa react menunggu variable yang memberikan `throw` pada `return` nya????
```typescript
export interface User {
  id: number,
  name: string,
  username: string,
  email: string,
  address: Address,
  company: Company,

}
interface Address {
  street: string,
  suite: string,
  city: string,
  zipcode: string,
  geo: Geo,
  phone: string,
  website: string,
}
interface Geo {
  lat: string,
  lng: string,
}
interface Company {
  name: string,
  catchPhrase: string,
  bs: string,
}

async function stall(stallTime = 3000) {
  await new Promise(resolve => setTimeout(resolve, stallTime));
}

async function fetchUser(): Promise<User> {
  const response = await fetch("https://jsonplaceholder.typicode.com/users/3")
    .then((res) => res.json())
    .catch((err) => console.log(err));
  await stall();
  return response;
}

function dataFetch() {
  const fetchData = fetchUser();
  return wrapPromise(fetchData);
}


const wrapPromise = <T>(promise: Promise<T>) => {
  let status = "pending";
  let result: T;
  let suspend = promise.then(
    (res) => {
      status = "success";
      result = res;
    },
    (err) => {
      status = "error";
      result = err;
    }
  );

  const read = () => {
    if (status === "pending") {
      console.log("pending")
      throw suspend;
    } else if (status === "error") {
      console.log("error")
      throw result;
    } else if (status === "success") {
      return result;
    }
  }

  return { read };
};


export default dataFetch;


// profile.tsx
import React from "react";
import dataFetch, { User } from "./wrapPromise";

const resource = dataFetch();

const UserProfile = () => {
  const user: undefined | User = resource.read();
  if (user !== undefined) {
    return (
      <div className="container">
        <h1 className="title">{user.name}</h1>
        <ul>
          <li>username: {user.username}</li>
          <li>phone: {user.address.phone}</li>
          <li>email: {user.email}</li>
        </ul>
      </div>
    );
  }

  else {
    return (
      <h2> User undefined or error </h2>
    )
  }
};

export default UserProfile;


```

## 1 September 2023
### await pada fetch akan return `tipe` bukan `Promise`
jika ingin menggunakan `Suspense` dan `wrapPromise` jangan gunakan **await**, karena await akan menunggu response dan mengembalikan value.
```typescript
// tanpa await ============================
export function getCategories() {
  let response = fetch('https://dummyjson.com/products/categories')
    .then(res => res.json());
  return wrapPromise<string[]>(response);
}

// dengan await =========================
export async  function getCategories() {
  let response: string[] | string = await fetch('https://dummyjson.com/products/categories')
    .then(res => res.json());
// response disini akan berisi string[] atau string, dan bukan promise!!!
}

```
- 1 September 2023  
  1. optional chaining
  2. object
  3. flow control
  4. asynchronous logic
  5. async/await
  6. promise
  7. event
  8. module
  9. event loop

## 6 September 2023
  1. modules ✔️  
  2. Object ✔️  
  3. Set ✔️
  4. Class js ✔️
  5. FormData Web Apis ✔️

## 20 September 2023
### Action in ASPNET is Delegates
ref :https://www.tutorialsteacher.com/csharp/csharp-action-delegate
pada code dibawah ini `ConfigureAppConfiguration(Action<HostBuilderContext, IconfigurationBuilder> ConfigureDelegate)`, delegate akan menerima sebuah fungsi dengan parameter seperti yg tertulis, dalam hal ini menggunakan **lambda**.
```c#
        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((context, config) =>
                {
                    var root = config.Build();
                    var keyVaultUrl = root["KeyVault:Url"];
                    if (string.IsNullOrWhiteSpace(keyVaultUrl) == false)
                    {
                        config.AddAzureKeyVault(keyVaultUrl, new DefaultKeyVaultSecretManager());
                    }
                })
                .ConfigureWebHostDefaults(webBuilder =>
                {
                    webBuilder.UseStartup<Startup>();
                });

```

## 24 September 2023
### penggunaan Plantuml untuk generate class diagram di `typescript` dan `C#`
command generate plantuml: `java -jar %PLANTUMLDIR%\plantuml.jar include.puml -tsvg`

---
⚠️ Entah `tplant` tidak bisa generate class diagram jika ada fungsi tanpa class, sehingga fungsi tanpa class harus dihapus

- CLI untuk Typescript: https://github.com/bafolts/tplant  
- command  untuk generate `.puml`: ```tplant -p package.json --input src/**/*.ts* --output output.puml -A``` 

---
- CLI untuk C#: https://github.com/pierre3/PlantUmlClassDiagramGenerator  
- command untuk generate `.puml`: `puml-gen DMC.Api puml -dir -excludePaths bin,obj,properties  -allInOne -createAssociation`  


## 25 September 2023
- Azure Function local dev yg digunakan pada `project` menggunakan versi3
- `dotenv` digunakan untuk import environment variable dari file `.env` ke process dari `node.js`
- azure function repo github (node): https://github.com/Azure/azure-functions-nodejs-library
- azure service bus (Azure Service Bus is a highly-reliable cloud messaging service from Microsoft.) github repo: https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/servicebus/service-bus
- azure msal node (Azure  authentication library) github repo: https://github.com/AzureAD/microsoft-authentication-library-for-js
- azure msal browser: https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser
- azure msal react: https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-react
- azure identity(provide Token Authentication, Token Credential from Azure active directory / AD) : https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/identity/identity
- azure keyvault (provide cloud keys, secret and certificate): https://github.com/Azure/azure-sdk-for-js/tree/main/sdk/keyvault

## 26 September 2023
- Ienumerable adalah interface yg dapat membuat sebuah class/variable dapat di _iterate_, Ienumerable memiliki method `getEnumerator()`
- Ienumerator adalah interface yg membuat class/variable dapat di iterate (memberikan sebuah object untuk melakukan iterasi), Ienumerator memiliki method `Reset(),Current(),MoveNext()`
- `IEnumerable<T>` contains a single method that you must implement when implementing this interface; `GetEnumerator`, which returns an `IEnumerator<T>`
- **Arrays in c# by default** implement IEnumerable<T> where T is the member type of array.
- The IEnumerable<T> interface is central to LINQ. All LINQ methods are extension methods to the IEnumerable<T> interface. **That means that you can call any LINQ method on any object that implements IEnumerable<T>**. You can even create your own classes that implement IEnumerable<T>, and those classes will instantly "inherit" all LINQ functionality!
