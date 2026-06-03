# WordlClone

A cross-platform Wordle-inspired word guessing game built with **C++**, **Qt 6**, **QML**, and **SQLite**.

The project was created for personal use to practice modern Qt development, UI design with QML, database integration, application architecture, and testing.

## Screenshots

### Main Menu

<p align="center">
  <img src="https://github.com/user-attachments/assets/0f55cb77-a540-4116-b5d7-aaaa147ea450" height="500" alt="Main Menu" />
  <img src="https://github.com/user-attachments/assets/8c881508-af51-4662-951e-eefa858316c0" height="500" alt="Main Menu" />
</p>

### Gameplay

<p align="center">
  <img src="https://github.com/user-attachments/assets/f592af90-13ec-4988-b1c5-48b3bee0d466" height="500" alt="Gameplay" />
  <img src="https://github.com/user-attachments/assets/09765a41-e3e8-4876-8304-4839d24990f1" height="500" alt="Gameplay" />
</p>

### Statistics

<p align="center">
  <img src="https://github.com/user-attachments/assets/f6bad926-5daa-42c4-9d42-bba308f52634" height="500" alt="Statistics" />
  <img src="https://github.com/user-attachments/assets/9eb75ec5-c4a1-4f60-bd5c-ba95d6e8abfe" height="500" alt="Statistics" />
</p>

### Language Selection

<p align="center">
  <img src="https://github.com/user-attachments/assets/747d8b2f-654a-42dc-b4e4-e22928c71b5e" height="500" alt="Language Selection" />
  <img src="https://github.com/user-attachments/assets/bbacf907-1198-46f8-ad61-1efd18fe7543" height="500" alt="Language Selection" />
</p>

## Features

* Classic Wordle-style game mechanics with fluid UI transitions.
* **Multi-language support:**
  * English
  * German (Deutsch)
  * Russian (Русский)
  * Ukrainian (Українська)
* Dynamic keyboard layouts that adapt automatically to the selected language.
* Random word generation directly from an SQLite database.
* Persistent game statistics stored locally.
* Comprehensive win/loss tracking, current streak, and historical best streak analytics.
* Fully responsive UI that adapts layout and element sizing to different window dimensions.
* Automated unit tests ensuring core game logic and database stability.

## Architecture & Core Components

The application utilizes an advanced **Model-View-Controller (MVC)** architectural pattern to decouple the data logic from the visual presentation layer.

### Backend (C++)
The core state machine and underlying data storage are built purely in C++ to achieve high runtime performance and type safety.
`GameController`: Acts as the central coordinator (Mediator). It orchestrates guess validations, state management, and updates core properties `Q_PROPERTY` bindings.
`BoardModel`: A specialized subclass managing the state of the 5x5 matrix tiles.
`KeyboardModel` & `KeyboardRowModel`: Implement efficient data bindings for physical-like layout changes and coordinate tile coloring behaviors.
`DatabaseManager`: Interacts with SQLite, ensuring schema creation, file parsing, and dictionary tracking.
`StatisticsManager`: Tracks persistent metrics for each language using targeted SQL queries.

### Frontend (QML)
The interface relies on declarative views powered by Qt Quick, utilizing advanced anchors, dynamic sizing calculations, and optimized layout trees.
`GameBoard.qml`: Implements responsive, cell-by-cell matrix calculations bound directly to `BoardModel`.
`GameKeyboard.qml`: A fluid key-layout matrix reflecting `KeyboardRowModel` data signals.

## Project Structure

```text
Wordl/
│
├── src/                # C++ source files (Controllers, Models, Managers)
├── qml/                # QML UI declarative codebase
│   ├── components/     # Reusable UI widgets (GameBoard, LetterTile, Buttons)
│   └── pages/          # Full page layouts (GamePage, SettingsPage, StatsPage)
│
├── data/               # Txt words files for db
├── tests/              # Unit test suites powered by Qt Test
└── CMakeLists.txt      # Central CMake configuration script
```

## Building

### Requirements

* Qt 6.11+
* CMake 3.20+
* Ninja (recommended)
* C++17 compatible compiler

### Clone Repository

```bash
git clone https://github.com/gorichdess/Wordl.git
cd Wordl
```

### Configure

```bash
mkdir build
cd build
cmake -G "Ninja" -DCMAKE_PREFIX_PATH="C:/Qt/<your-qt-version>/mingw_64" ..
```

### Build

```bash
cmake --build .
```

### Run

```bash
./WordlClone
```

## Database

The application automatically creates a local SQLite database on first launch.

Word lists are imported automatically if the database is empty.

Stored data includes:

* Available words
* Statistics for each language
* Game history information*

## Testing

The project includes automated unit tests written with **Qt Test** to verify the correctness of the core game logic and database functionality.

### Covered Components

#### WordEvaluator Tests
Verifies Wordle evaluation rules, including:

* Correct letter matching
* Present letter detection
* Absent letter detection
* Repeated letters in guesses
* Repeated letters in secret words
* Case-insensitive input handling

#### DatabaseManager Tests
Validates database-related functionality:

* Database creation and opening
* Word import from dictionary files
* Word existence checks
* Case-insensitive word lookup
* Random word selection

#### StatisticsManager Tests
Ensures statistics are updated correctly:

* Win/loss tracking
* Games played counters
* Win rate calculation
* Current and best streak updates
* Language-specific statistics reset
* Global statistics reset

### Running Tests

```bash
ctest --output-on-failure
```
