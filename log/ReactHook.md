## 24 Agustus 2023
### UseTransition
useTransition is a React Hook that lets you update the state without blocking the UI.
```typescript
const [isPending, startTransition] = useTransition()
```
Parameters

useTransition does not take any parameters.
Returns

useTransition returns an array with exactly two items:

1. The isPending flag that tells you whether there is a pending transition.
2. The startTransition function that lets you mark a state update as a transition.
