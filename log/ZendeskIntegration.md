
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


- Autoreply

## Give Dasboard Access to other people 
to give dasboard access for another people, we can give access from `Admin center -> People -> Team Members` then on right-top-corner we hit `Add Team Member` button, zendesk will ask for email and role for new team member.

## Dasboard Usage 

**TODO:**

