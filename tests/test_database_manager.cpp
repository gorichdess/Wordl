#include <QtTest>

#include "../src/DatabaseManager.h"

class TestDatabaseManager : public QObject
{
    Q_OBJECT

private slots:
    void databaseOpens();
    void importedWordExists();
    void wordExistsIsCaseInsensitive();
    void unknownWordDoesNotExist();
    void randomWordReturnsImportedWord();
};

void TestDatabaseManager::databaseOpens()
{
    DatabaseManager db;

    QVERIFY(db.openDatabase(":memory:", "test_db_opens"));
}

void TestDatabaseManager::importedWordExists()
{
    DatabaseManager db;
    QVERIFY(db.openDatabase(":memory:", "test_db_imported_word"));

    db.importWordsFromFile("data/english_words.txt", "English");

    QVERIFY(db.wordExists("WORDS", "English"));
}

void TestDatabaseManager::wordExistsIsCaseInsensitive()
{
    DatabaseManager db;
    QVERIFY(db.openDatabase(":memory:", "test_db_case"));

    db.importWordsFromFile("data/english_words.txt", "English");

    QVERIFY(db.wordExists("words", "English"));
}

void TestDatabaseManager::unknownWordDoesNotExist()
{
    DatabaseManager db;
    QVERIFY(db.openDatabase(":memory:", "test_db_unknown"));

    db.importWordsFromFile("data/english_words.txt", "English");

    QVERIFY(!db.wordExists("ZZZZZ", "English"));
}

void TestDatabaseManager::randomWordReturnsImportedWord()
{
    DatabaseManager db;
    QVERIFY(db.openDatabase(":memory:", "test_db_random"));

    db.importWordsFromFile("data/english_words.txt", "English");

    QString word = db.getRandomWord("English");

    QCOMPARE(word.length(), 5);
    QVERIFY(db.wordExists(word, "English"));
}

QTEST_MAIN(TestDatabaseManager)
#include "test_database_manager.moc"