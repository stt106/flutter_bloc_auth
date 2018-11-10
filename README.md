# flutter_bloc_auth

A simple reactive flutter authentication using BLOC pattern.
1. It should allow either log in or sign up.
2. It should allow log out and rediect to log in page. 
3. LOG IN/SIGN UP buttons should only be enabled when relevant data is valid.

## There is currently a few problems with this code:
1. When entering valid log in data, LOG IN button is then enabled, but if switching to sign up page where password hasn't been confirmed, the SIGN UP button is enabled by default, which is incorrect.
2. Upon logging out, it rediects to log in page where LOG IN button is enabled by default even though email and password are both empty, which is clearly wrong.

*Pull Requests are greatly appreciated to fix these problem!*
