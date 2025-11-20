Mini Lead Management App (Flutter)

A simple CRM-style Lead Management mobile app built using Flutter, SQLite, and Provider as part of the Flutter Internship Assignment.

Features

✅ Add new leads
✅ View all leads in a list
✅ Filter leads by status (All, New, Contacted, Converted, Lost)
✅ Search leads by name
✅ Update lead details
✅ Update lead status
✅ Delete leads
✅ Local data persistence using SQLite

🏗️ Tech Stack
Technology	Usage
Flutter	Frontend UI
Dart	Programming Language
Provider	State Management
sqflite	Local Database
Material UI	UI Components
📂 Folder Structure
lib/
│
├── models/       -> Lead model
├── database/     -> SQLite database helper
├── providers/    -> Lead state management
├── screens/      -> App screens (list, add, detail)
└── main.dart     -> App entry point

🎯 App Screens

Lead List Screen

Displays all leads

Filter leads by status

Add Lead Screen

Add new lead

Input validation (only letters for name, only numbers for contact)

Lead Detail Screen

Edit lead information

Update lead status

Delete lead

🛠️ Installation & Run
Step 1: Clone the repository
git clone <your-github-repo-link>

Step 2: Go to the project directory
cd mini_lead_management

Step 3: Install dependencies
flutter pub get

Step 4: Run the app
flutter run

🗄️ Database

Uses SQLite (sqflite package)

Fully supports:

Create

Read

Update

Delete

All lead data is stored locally and persists even after app restart.

🎨 Bonus Features Implemented

✅ Search functionality
✅ Dark mode toggle
✅ UI animations
✅ Input validation
✅ Clean architecture

📦 APK Download

➡ APK is available in the GitHub release section.

👨‍💻 Developed By
Sachin Maurya
