cmake_minimum_required(VERSION 3.14)
 
project(QmlApp LANGUAGES CXX)
 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
 
qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)
 
qt_add_executable(WordlClone
  main.cpp
  src/GameController.cpp
)

set_source_files_properties(qml/components/Theme.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)
 
qt_add_qml_module(WordlClone
    URI WordlClone
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    QML_FILES
        qml/Main.qml
        qml/pages/GamePage.qml
        qml/pages/SettingsPage.qml
        qml/pages/StatsPage.qml
        qml/components/LetterTile.qml
        qml/components/GameBoard.qml
        qml/components/KeyboardButton.qml
        qml/components/GameKeyboard.qml
        qml/components/Theme.qml
)

 
target_link_libraries(WordlClone
    PRIVATE Qt6::Quick
)
 
include(GNUInstallDirs)
install(TARGETS WordlClone
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)