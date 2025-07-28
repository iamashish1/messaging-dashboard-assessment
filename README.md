# Messaging App with Webview Embedded Internal Tools Dashboard


## ✨ Features Implemented

### Messaging Application (Flutter)

* Native Chat UI.
* Auto-Scroll
* Simulated Support Agent
* Message Persistence with Hive
* Dark Mode

### Internal Tools Dashboard (Angular & Tailwind CSS)

* Ticket Viewer
* Markup Editor
* Live Logs Panel
* Top Navigation

---

## 🚀 Getting Started


Follow these steps to get the project up and running on your local machine.

First, clone the entire repository to your local machine:
```
git clone <repository-url>
cd messaging-dashboard-assessment
```

### 1. Start the Internal Tools Dashboard (Angular)

This part of the project serves the web-based dashboard.

Navigate into the webpage directory:
```
cd webpage
```

Install the necessary Node.js dependencies:
```
npm install
```

Start the Angular development server:

```
ng serve --port 4200
```


The dashboard will now be running and accessible, typically at http://localhost:4200. Keep this terminal window open.

### 2. Run the Messaging Application (Flutter)

This is the mobile application that will embed the dashboard.

Open a new terminal window and navigate back to the root of the cloned repository, then into the flutter_app directory:
```
cd flutter_app
```

Clean the Flutter project (optional, but good practice):
```
flutter clean

```
Get the Flutter package dependencies:
```
flutter pub get
```

Configure the Dashboard URL:
Before running the app, you must edit the ```localhostUrl``` field in the file ``` lib/core/constants/app_urls.dart ```. This URL tells the Flutter app's WebView where to find your running Angular dashboard. Choose the appropriate URL based on your development environment:
```
iOS Simulator: http://localhost:4200

Android Emulator: http://10.0.2.2:4200

Physical Device: http://<Your-Development-Machine-IP-Address>:4200
```
(Replace <Your-Development-Machine-IP-Address> with the actual IP address of the computer running your Angular server.)

Run the Flutter application:
```
flutter run

```
This will launch the Flutter app on your connected device or emulator.
