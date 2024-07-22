## 24 Agustus 2023
### Solid Principle
1. Single Responsibilities Principle  
**A Class Should Have just one reason to change**
2. Open closed Principle  
**A Class Should be open for extention but closed for modification**
3. Liskov Subtitution Principle   
**when extending a class remember that you should be able to pass object of subclass in place of object of parent class without breaking client code**  
  - parameter type in subclass should **match** or be **more abstract** than parameter type in super class
  - return type in method of subclass should **match** or a **subtype** of return type in super class
  - a method in subclass should not throw types of exception which base class not expecting to throw
  - a subclass shouldnot **strengthen** pre-condition
  - a subclass shouldnot **weaken** post-condition
  - **invariant** of superclass must be preserved
  - a subclass shouldnot change values of private fields of superclass
    
4. Interface Segregation principle
**client should not be forced to depend on method they donot use**
  - class inheritance only have one of superclass, but doesnt limit number of interface them implement

5. Dependency Inversion Principle
**high-level classes should not depend on low-level classes, both should depend on abstraction. abstraction shouldnot depend on detail. detail should depend on abstraction**




# Exercise T-SQL Fundamentals Microsoft Press - Itzik Ben-Gan

## Chapter 2, Single Table Query
### [1 Agustus 2023] Exercise 1
1. Write a query against the Sales.Orders table that returns orders placed in June 2021
```sql
USE TSQLV6;
SELECT 
    orderid, 
    orderdate,
    custid, 
    empid
FROM Sales.Orders
WHERE MONTH(orderdate) = 6 AND YEAR(2021);
```

### Exercise 2
1. Write a query against the Sales.Orders table that returns orders placed on the day before the last day of the month:
```sql
USE TSQLV6;
SELECT 
    orderid, 
    orderdate, 
    custid, 
    empid
FROM Sales.Orders
WHERE DAY(orderdate) 
BETWEEN 
    CASE
        WHEN MONTH(orderdate) % 2 = 0 AND MONTH(orderdate) != 2 THEN 29
        WHEN MONTH(orderdate) % 2 = 1 AND MONTH(orderdate) != 2 THEN 30
        ELSE 27
    END 
AND 
    CASE
        WHEN MONTH(orderdate) % 2 = 0 AND MONTH(orderdate) != 2 THEN 30
        WHEN MONTH(orderdate) % 2 = 1 AND MONTH(orderdate) != 2 THEN 31
        ELSE 28
    END;
```
### Exercise 3
1. Write a query against the HR.Employees table that returns employees with a last name containing the letter e twice or more:

```sql
USE TSQLV6;
SELECT  
    empid,
    firstname,
    lastname

FROM HR.Employees
WHERE lastname LIKE '%e%e%';
```

## Chapter 3, Join
### [2 Agustus 2023] Exercise 3
Return US customers, and for each customer return the total number of orders and total quantities:
```SQL
USE TSQLV6;

SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
    INNER JOIN Sales.Orders         AS O ON C.custid = O.custid
    INNER JOIN Sales.OrderDetails   AS OD ON O.orderid = OD.orderid
WHERE C.country = N'USA'
GROUP BY C.custid;
```
### Excercicse 4
Return customers and their orders, including customers who placed no orders
```SQL
USE TSQLV6;

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid;

```

### Excercise 5 
Return customers who placed no orders
```SQL
USE TSQLV6;

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid 
WHERE O.orderid IS NULL;

```

### Excercise 6 

Return Customer With orders placed on February 12, 2022, along with their orders
```SQL
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C 
    INNER JOIN Sales.Orders AS O ON C.custid = O.custid

WHERE O.orderdate = '20220212';
```

### Excercise 9 
Return all customers, and for each return a Yes/No value depending on whether the customer placed orders on February 12, 2022:

```SQL
USE TSQLV6;

SELECT C.custid, C.companyname, 
    CASE
        WHEN O.orderid IS NOT NULL 
            THEN 'YES'
        ELSE 'NO' 
    END AS HasAnOrders
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O 
    ON  O.custid = C.custid 
    AND O.orderdate = '20220212';
```
## Chapter 4, Sub Queris
### Exercise 3

```SQL
USE TSQLV6;

SELECT H.empid, H.firstname, H.lastname
FROM HR.Employees AS H
WHERE H.empid NOT IN 
(
    SELECT O.empid
    FROM Sales.Orders AS O
    where O.orderdate > '20220501'
);
```

## Chapter 5, Table Expression
### [9 Agustus 2023] Note
select growth of `customer` from previous year compared to this year.
```SQL
USE TSQLV6;

SELECT 
    Cur.orderyear   AS currentYear,
    Prv.orderyear   AS prevYear,
    Cur.numcust     AS curentnumcust,
    Prv.numcust     AS prevnumcust,
    Cur.numcust - Prv.numcust AS growth
FROM
(
    SELECT  YEAR(orderdate) AS orderyear, 
            COUNT(DISTINCT custid) AS numcust
    FROM    Sales.Orders
    GROUP BY YEAR(orderdate)
) AS Cur 

LEFT OUTER JOIN 
(
    SELECT  YEAR(orderdate) AS orderyear, 
            COUNT(DISTINCT custid) AS numcust 
    FROM Sales.Orders 
    GROUP BY YEAR(orderdate) 
) AS Prv 

ON Cur.orderyear = Prv.orderyear + 1;
```

### [10 Agustus 2023] Note `View`
 - View digunakan untuk menampilkan queri dari table dengan filter tertentu (seperti negara asal, dll)
 - untuk membuat view dapat digunakan `CREATE OR ALTER VIEW namedatabase`
 - secara default sql dapat mengakses dan merubah atau pun menambahkan data melalui view, **namun** hal ini tidak disarankan karena, jika mengubah atau menambahkan ke tabel **yg tidak sesuai filter** maka tidak akan tertampil di view.
 - untuk membatasi penambahan maupun perubahan di view dapat digunakan `WITCH CHECK OPTION` diakhir query
 - secara default, colom dari tabel asli diview dapat dihapus oleh sql, sehingga ketika view dieksekusi kembali dapat menyebabkan error, untuk membatasi penghapusan colom pada tabel asal, dapat digunakan `WITH SCHEMABINDING`.
 - untuk menghapus view dapat digunakan `DELETE VIEW viewname`

----
 - `@@identity` pada T-SQL akan return(mengembalikan) value `IDENTITY/autoincrement` terakhir yang dimasukan ke tabel pada _session_ tersebut, namun jika session tersebut diakhiri dan `@@identity` dipanggil return valuenya akan `NULL`.
 - untuk mendapatkan **identity** terakhir tanpa memedulikan session dapat digunakan fungsi `IDENT_CURRENT(_namatable_)` contoh `IDENT_CURRENT(N'dbo.table1')`.




### Summary React Hook karangan Sendiri
- Suspense: butuh throw (dan wrap promise) untuk mengetahui apakah komponen siap render
- Lazy: akan diimport ketika perlu (promise juga)
- useTransition: return 2 value [isPending, startTransition], ispending adalah boolean yg bernilai true jika `startTransition` Masih bekerja, startTransition memiliki prioritas yg rendah dibandingkan fungsi lain yg tidak berada dalam start transition

## 24 Agustus 2023
### UseTransition
useTransition is a React Hook that lets you update the state without blocking the UI.
```typescript
const [isPending, startTransition] = useTransition()
```
----
Parameters

useTransition does not take any parameters.

----
Returns

useTransition returns an array with exactly two items:

1. The isPending flag that tells you whether there is a pending transition.
2. The startTransition function that lets you mark a state update as a transition.


### UseMemo
useMemo is a React Hook that lets you cache the result of a calculation between re-renders.
```typescript
const cachedValue = useMemo(calculateValue, dependencies)
```
----
Parameters

calculateValue: The function calculating the value that you want to cache. It should be pure, should take no arguments, and should return a value of any type. React will call your function during the initial render. On next renders, React will return the same value again if the dependencies have not changed since the last render. Otherwise, it will call calculateValue, return its result, and store it so it can be reused later.  


 dependencies: The list of all reactive values referenced inside of the calculateValue code. Reactive values include props, state, and all the variables and functions declared directly inside your component body. If your linter is configured for React, it will verify that every reactive value is correctly specified as a dependency. The list of dependencies must have a constant number of items and be written inline like [dep1, dep2, dep3]. React will compare each dependency with its previous value using the Object.is comparison.
 
----
Returns

On the initial render, useMemo returns the result of calling calculateValue with no arguments.

During next renders, it will either return an already stored value from the last render (if the dependencies haven’t changed), or call calculateValue again, and return the result that calculateValue has returned.

<details>
 <summary> Pemahaman sendiri tentang useMemo </summary>
 useMemo memiliki 2 parameter `calculateValue dan Dependencies` ketika `todos` atau `tab` berubah (lihat kode dibawah ini), use memo akan menggunakan fungsi pada argument pertama untuk menghitung ulang/re-calculate `visibleTodos` karena salah satu dependencies berubah, disini theme tidak digunakan sebagai dependencies, sehingga ketika `theme` berubah argument pertama tidak akan di re-execute, **namun** ketika `theme` dimasukan ke **array** dependencies useMemo akan tetap melakukan re-calculate walaupun data tidak terpengaruh oleh "theme".

 ### memo
 memo lets you skip re-rendering a component when its props are unchanged.
 ```typescript
const MemoizedComponent = memo(SomeComponent, arePropsEqual?)
```
 
 ```typescript
 function TodoList({ todos, theme, tab }: { todos: TodosModel[], theme: string, tab: string }) {
  const visibleTodos = useMemo(
    () => filterTodos(todos, tab),
    [todos, tab]
  );

  return (
    <div className={theme} >
      <List items={visibleTodos} />
    </div>
  );
}

const MemoList = ({ items }: { items: TodosModel[] }) => {
  console.log('[ARTIFICIALLY SLOW] Rendering <List /> with ' + items.length + ' items');
  let startTime = performance.now();
  while (performance.now() - startTime < 500) {
    // Do nothing for 500 ms to emulate extremely slow code
  }

  return (
    <ul>
      {items.map(item => (
        <li key={item.id}>
          {item.completed ?
            <s>{item.text}</s> :
            item.text
          }
        </li>
      ))}
    </ul>
  );

}

const List = memo(MemoList);


 ```
</details>


### useReducer
useReducer is a React Hook that lets you add a reducer to your component.
```typescript
const [state, dispatch] = useReducer(reducer, initialArg, init?)
```

----
Parameters

  reducer: The reducer function that specifies how the state gets updated. It must be pure, should take the state and action as arguments, and should return the next state. State and action can be of any types.  

  initialArg: The value from which the initial state is calculated. It can be a value of any type. How the initial state is calculated from it depends on the next init argument. optional init: The initializer function that should return the initial state. If it’s not specified, the initial state is set to initialArg. Otherwise, the initial state is set to the result of calling init(initialArg).

----
Returns

useReducer returns an array with exactly two values:

The current state. During the first render, it’s set to init(initialArg) or initialArg (if there’s no init). The dispatch function that lets you update the state to a different value and trigger a re-render.

<details>
<summary>Converted JS Example to Typescript</summary>

```typescript
import { useReducer, useState } from 'react';

interface Task {
  id: number;
  text: string;
  done: boolean;
}

interface AddTaskProps {
  onAddTask: (text: string) => void;
}

export default function AddTask({ onAddTask }: AddTaskProps) {
  const [text, setText] = useState('');

  return (
    <>
      <input
        placeholder="Add task"
        value={text}
        onChange={(e) => setText(e.target.value)}
      />
      <button
        onClick={() => {
          setText('');
          onAddTask(text);
        }}
      >
        Add
      </button>
    </>
  );
}

interface TaskListProps {
  tasks: Task[];
  onChangeTask: (task: Task) => void;
  onDeleteTask: (taskId: number) => void;
}

export default function TaskList({ tasks, onChangeTask, onDeleteTask }: TaskListProps) {
  return (
    <ul>
      {tasks.map((task) => (
        <li key={task.id}>
          <Task task={task} onChange={onChangeTask} onDelete={onDeleteTask} />
        </li>
      ))}
    </ul>
  );
}

interface TaskProps {
  task: Task;
  onChange: (task: Task) => void;
  onDelete: (taskId: number) => void;
}

function Task({ task, onChange, onDelete }: TaskProps) {
  const [isEditing, setIsEditing] = useState(false);

  let taskContent;

  if (isEditing) {
    taskContent = (
      <>
        <input
          value={task.text}
          onChange={(e) => {
            onChange({
              ...task,
              text: e.target.value,
            });
          }}
        />
        <button onClick={() => setIsEditing(false)}>Save</button>
      </>
    );
  } else {
    taskContent = (
      <>
        {task.text}
        <button onClick={() => setIsEditing(true)}>Edit</button>
      </>
    );
  }

  return (
    <label>
      <input
        type="checkbox"
        checked={task.done}
        onChange={(e) => {
          onChange({
            ...task,
            done: e.target.checked,
          });
        }}
      />
      {taskContent}
      <button onClick={() => onDelete(task.id)}>Delete</button>
    </label>
  );
}

export default function TaskApp() {
  const [tasks, dispatch] = useReducer(tasksReducer, initialTasks);

  function handleAddTask(text: string) {
    dispatch({
      type: 'added',
      id: nextId++,
      text: text,
    });
  }

  function handleChangeTask(task: Task) {
    dispatch({
      type: 'changed',
      task: task,
    });
  }

  function handleDeleteTask(taskId: number) {
    dispatch({
      type: 'deleted',
      id: taskId,
    });
  }

  return (
    <>
      <h1>Prague itinerary</h1>
      <AddTask onAddTask={handleAddTask} />
      <TaskList
        tasks={tasks}
        onChangeTask={handleChangeTask}
        onDeleteTask={handleDeleteTask}
      />
    </>
  );
}

type Action =
  | { type: 'added'; id: number; text: string }
  | { type: 'changed'; task: Task }
  | { type: 'deleted'; id: number };

function tasksReducer(tasks: Task[], action: Action) {
  switch (action.type) {
    case 'added': {
      return [
        ...tasks,
        {
          id: action.id,
          text: action.text,
          done: false,
        },
      ];
    }
    case 'changed': {
      return tasks.map((t) => {
        if (t.id === action.task.id) {
          return action.task;
        } else {
          return t;
        }
      });
    }
    case 'deleted': {
      return tasks.filter((t) => t.id !== action.id);
    }
    default: {
      throw Error('Unknown action: ' + action.type);
    }
  }
}

let nextId = 3;

const initialTasks: Task[] = [
  { id: 0, text: 'Visit Kafka Museum', done: true },
  { id: 1, text: 'Watch a puppet show', done: false },
  { id: 2, text: 'Lennon Wall pic', done: false },
];
```
</details>

## 25 Agustus 2023
### useContext
useContext is a React Hook that lets you read and subscribe to context from your component.
```typescript
const value = useContext(SomeContext)
```

----

Parameters

SomeContext: The context that you’ve previously created with createContext. The context itself does not hold the information, it only represents the kind of information you can provide or read from components.

----

Returns  

useContext returns the context value for the calling component. It is determined as the value passed to the closest SomeContext.Provider above the calling component in the tree. If there is no such provider, then the returned value will be the defaultValue you have passed to createContext for that context. The returned value is always up-to-date. React automatically re-renders components that read some context if it changes.




# Zendesk Integation 

## Setup API
to use zendesk we can add `<script/>` snippet before `<body/>` tag (we can find snippet on `Admin Center -> Channels -> {Channels Name} -> Instalation`), or we can use library https://github.com/B3nnyL/react-zendesk#readme to ease intergrating with react.

if we use library we can add following code: 
```typescript
const ZENDESK_KEY = "your zendesk embed key";

const App = () => {
  ......
  return <Zendesk defer zendeskKey={ZENDESK_KEY} onLoaded={() => console.log('is loaded')} />;
  .....
};
```

## API Integration 
to integrate zendesk `messenger` with our web, we can use `window.zE` function for example, to automate login we can use following code, so logged in user doesn't need to give their name and email manually.

```javascript
zE("messenger", "loginUser", function (callback) {
  callback("generated jwt from backend");
})
```

or we can custom button to open `messenger` window with `zE('messenger', 'show');`

all other web widget api can found in: https://developer.zendesk.com/api-reference/widget-messaging/introduction/
**TODO:** have tried but it hasn't worked

## How to Setup Automated Reply
we can acces automated reply and AI setting from `Admin Center -> Channels -> Bot and Automation` then we can choose `Conversation bot` or `Autoreply`.
- Bot
  we can create several conversation bot, to create new bot you can click `create bot` on conversation bot window as shown below
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/c2937427-4bd5-4114-b877-a7320df4f7db)
  to start add bot automation, we can select on of channel from list above (ex: DMC), then you can go to tab `Answer` and start adding new answer by click `create answer` button, there are several built in answer template we can use, or we can create custom answer. 
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/f071f156-8950-4df8-be43-e5ea5faca394)  
  to create custom answer, click `Build your own answer` and click `next`, then you can add your answer name  
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/9e3e8a5b-25ed-40e7-88c3-c62442f00c48)  
  next you can add several training phrase for your bot, for example like image below  
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/17165156-d0f3-4e0c-b6b0-02e395f1138a)  
  then zendesk will bring you to _flow chart like window_ to add how bot behave  
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/cef7f16f-acd0-4ad8-ba1b-04a0087e570e)  

  so when customer ask for somethink (for example new feature) the bot will look for phrase and give answer like image below  
  ![image](https://github.com/ahsanu123/learnNote/assets/81602442/0cd56ea2-669d-499f-b0e0-4896b0b00798)  


## Give Dasboard Access to other people 
to give dasboard access for another people, we can give access from `Admin center -> People -> Team Members` then on right-top-corner we hit `Add Team Member` button, zendesk will ask for email and role for new team member.

## Dasboard Usage 
dasboard can accesed from `https://{subdomain}.zendesk.com/agent/dashboard` 
![image](https://github.com/ahsanu123/learnNote/assets/81602442/94f4e446-3a41-489c-afd6-d4ce9a8f2f81)




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

- azure msal adalah library yg digunakan sebagai authentication ke beberapa service seperti azure, microsoft, facebook dll. `azure browser` adalah basis dari `azure react`
`Msal Basic` ➡️ https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-browser#msal-basics

### Note tentang Authentication dan authorization dari frontend
1. pada `index.tsx` terdapat sebuah fungsi yg digunakan untuk mendapatkan sebuah instance dari `msal` library, menurut dokumentasi azure untuk menggunakan `msal-browser` perlu melakukan instansiasi `PublicClientAplication`. instantiasi dari `PublicClientApplication` terdapat pada fungsi dari `const msalInstance` yg berada pada `index.tsx`.
2. hasil instance tadi dimasukan ke parameter `MsalProvider{instance}` menurut dokumentasi dari `azure msal` MsalProvider digunakan sebagai `MSAL context provider component. This must be rendered above any other components that use MSAL.`
3. lalu terdapat `AppStoreProvide`, disini appstore provide mennyediakan context **store** dari `AppStoreContext` yg menyediakan model (menggunakan Mobx) **dan** store yg di-provide oleh `AppStoreProvider` menggunakan fungsi `useLocalObservable`, sehingga ketika salah satu object yg berada dalam `AppStoreContext` berubah secara otomatis `observer` akan di-notify
4. dibawah `AppStoreProvider` terdapat `MsalAuthenticationTemplate` yg digunakan untuk meng-authentikasi user apabila belum ter-authentikasi, seperti yg dijelaskan pada dokumentasinya [Attempts to authenticate user if not already authenticated, then renders child components](https://azuread.github.io/microsoft-authentication-library-for-js/ref/functions/_azure_msal_react.MsalAuthenticationTemplate.html)
5. setelah `MsalAuthenticationTemplate` terdapat `BrowserRoute`,
6. terakhir terdapat `App` disini App memiliki banyak `Routes` tergantung dari page yang dijelajahi user.
7. pada `App`, di useeffect react akan meminta request accestoken ke server berdasarkan akun yg telah di **authentifikasi** dari **msal**. ketika user benar ter-authentikasi dan ter-authorisasi, app akan menggunakan switch dari router.
8. 

## 2 oktober 2023
- decorator in typescript: https://mirone.me/a-complete-guide-to-typescript-decorator/





## Styling learning log
7 November 2023
- Learning Fabric/pure css layout/scss/fluent ui component
  ![original-edb48c35a9e584be8dbc16ac714f82f7](https://github.com/ahsanu123/learnNote/assets/81602442/9e305a4c-c8b1-496c-a111-833edd192b11)
