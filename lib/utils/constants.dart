//Firebase
const userCollection = 'Users';
const callsCollection = 'Calls';
const tokensCollection = 'Tokens';

const fcmKey = 'AAAA6reYxGU:APA91bHKkWKehptfIBqfD-FwSdrOB1vH2NUMK0oWMQnEMGUqQRJFyxwMBtA9x-CqIqvunY9jwfH6HYGQvOn_PoTK_es4Y61P_94cvnwzIsJts3SCSwSJEO6h5cGeZyQ4NyqNrGKK1x7F'; //replace with your Fcm key
//Routes
const loginScreen = '/';
const homeScreen = '/homeScreen';
const callScreen = '/callScreen';
const testScreen = '/testScreen';

const agoraTestChannelName = 'video'; //replace with your agora channel name
const agoraTestToken = '007eJxTYDh49vz+AM9JzgV6S46ui/XK4Xq6+L/h9TB59xcec9OVrtQpMBgZpJolmqWmpFkYGZoYmhpZJCZbGKUkGxtZphkmJyabB7/qSm0IZGQQujSXhZEBAkF8VoayzJTUfAYGAL18IO8='; //replace with your agora token

const int callDurationInSec = 45;


// Permission Names
const permissionHideBlurredPhotos = "blurred_photos";
const permissionUnlimitedConversations = "unlimited_conversation";
const permissionSameCountryChat = "same_country_chat";
const permissionUnlimitedReplies = "unlimited_replies";
const permissionCalls = "calls";

//Call Status
enum CallStatus {
  none,
  ringing,
  accept,
  reject,
  unAnswer,
  cancel,
  end,
}