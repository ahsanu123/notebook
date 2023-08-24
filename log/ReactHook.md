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


