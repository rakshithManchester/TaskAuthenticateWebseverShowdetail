# TaskAuthenticateWebseverShowdetail
Project details:
Project has three screens - Login Screen(LoginViewController), Listing Screen(CollectionViewController), Detail screen(DetailViewController). 
User is authenticated in Login Screen, on success user is directed to Listing Screen, on failure error message is popped. 
Listing Screen displays artists details from a web server, on tapping on list user is directed to Detail screen. Finally Detail screen show the artists detail.

Screen Details:
.Login Screen - two TextField for mail,password & a button to login. 
.Listing Screen - Used Collection view to list data, loads data from web server 
.Detail screen - data details is presented.

Note: 
.Credentials used : 1. UserName : Raju@gmail.com 2. Password :Login123 
.Web Server Url : http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors 
.Infolist is added with NSAppTransportSecurity to access microblogging.wingnity.com domain.
