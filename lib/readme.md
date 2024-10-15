
# EntryPoint

### main.dart
- Defines the entry point of the application. Checks if device is logged in.
    - If so go to homePage
    - If not, go to login page

# Screens
- Each screen must have it's own scaffold to enable navigation from login.

### login.dart
- Provides the login form -> on successful login navigates to homePage

### homePage.dart
- The core of the application
- Has a navigation bar to move between sections:
    - tripDetails - list of trips with the comments
    - tripRoutes - map showing all routes
- logout button to go back to login

# Models
- All reused models (classes) to be defined here

# Providers
- All data providers to be here.
    - Different network classes in different files
    - SecureStorage access to be controlled from here