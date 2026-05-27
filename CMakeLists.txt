cmake_minimum_required(VERSION 3.14)
 
project(QmlApp LANGUAGES CXX)
 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)
 
qt_standard_project_setup()
 
qt_add_executable(WordlClone
  main.cpp
)
 
qt_add_qml_module(WordlClone
    URI Wordl     
    VERSION 1.0
    QML_FILES qml/Main.qml
              qml/pages/GamePage.qml
)
 
target_link_libraries(WordlClone
    PRIVATE Qt6::Quick
)
 
include(GNUInstallDirs)
install(TARGETS WordlClone
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)