
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

## How to Setup Automated Reply
we can acces automated reply and AI setting from `Admin Center -> Channels -> Bot and Automation` then we can choose `Conversation bot` or `Autoreply`

## Give Dasboard Access to other people 
to give dasboard access for another people, we can give access from `Admin center -> People -> Team Members` then on right-top-corner we hit `Add Team Member` button, zendesk will ask for email and role for new team member.

## Dasboard Usage 

**TODO:**

