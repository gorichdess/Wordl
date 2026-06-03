cmake_minimum_required(VERSION 3.14)
 
project(QmlApp LANGUAGES CXX)
 
set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
find_package(Qt6 6.4 REQUIRED COMPONENTS Quick Sql Test)
 
qt_standard_project_setup()

qt_policy(SET QTP0001 NEW)
qt_policy(SET QTP0004 NEW)
 
qt_add_executable(WordlClone
  main.cpp
  src/GameController.cpp
  src/BoardModel.cpp
  src/KeyboardModel.cpp
  src/DatabaseManager.cpp
  src/StatisticsManager.cpp
  src/WordEvaluator.cpp
)

qt_add_resources(WordlClone "word_lists"
    PREFIX "/"
    FILES
        data/english_words.txt
        data/german_words.txt
        data/russian_words.txt
        data/ukrainian_words.txt
)

qt_add_resources(WordlClone "database"
    PREFIX "/"
    FILES
        data/wordle.db
)

set_source_files_properties(qml/components/Theme.qml
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

if(ANDROID)
    set(QT_QMLCACHEGEN_EXECUTABLE "")
endif()

qt_add_qml_module(WordlClone
    URI WordlClone
    VERSION 1.0
    RESOURCE_PREFIX "/qt/qml"
    NO_CACHEGEN
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
        qml/components/AppButton.qml
        qml/components/AppText.qml
)

if(ANDROID)
    set_target_properties(WordlClone PROPERTIES
        QT_QMLCACHEGEN_ENABLED OFF
    )
endif()

 
target_link_libraries(WordlClone
    PRIVATE
        Qt6::Quick
        Qt6::Sql
)

if(NOT ANDROID)
    enable_testing()

    add_executable(test_word_evaluator
        tests/test_word_evaluator.cpp
        src/WordEvaluator.cpp
    )

    target_link_libraries(test_word_evaluator
        PRIVATE
            Qt6::Test
            Qt6::Core
    )

    add_test(NAME WordEvaluatorTest COMMAND test_word_evaluator)

    add_executable(test_statistics_manager
        tests/test_statistics_manager.cpp
        src/StatisticsManager.cpp
    )

    target_link_libraries(test_statistics_manager
        PRIVATE
            Qt6::Test
            Qt6::Core
            Qt6::Sql
    )

    add_test(NAME StatisticsManagerTest COMMAND test_statistics_manager)

    add_executable(test_database_manager
        tests/test_database_manager.cpp
        src/DatabaseManager.cpp
    )

    qt_add_resources(test_database_manager "test_words"
        PREFIX "/"
        FILES
            data/english_words.txt
            data/german_words.txt
            data/russian_words.txt
            data/ukrainian_words.txt
    )

    qt_add_resources(test_database_manager "test_database"
        PREFIX "/"
        FILES
            data/wordle.db
    )

    target_link_libraries(test_database_manager
        PRIVATE
            Qt6::Test
            Qt6::Core
            Qt6::Sql
    )

    add_test(NAME DatabaseManagerTest COMMAND test_database_manager)
endif()
 
include(GNUInstallDirs)
install(TARGETS WordlClone
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)