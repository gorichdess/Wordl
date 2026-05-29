#include "DatabaseManager.h"

#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QDebug>
#include <QFile>
#include <QTextStream>

DatabaseManager::DatabaseManager(){}

bool DatabaseManager::openDatabase()
{
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName("wordle.db");

    if (!m_database.open()) {
        qDebug() << "Database error:" << m_database.lastError().text();
        return false;
    }

    createTables();

    if (isWordTableEmpty("English")) {
        importWordsFromFile("data/english_words.txt", "English");
    }
    if (isWordTableEmpty("Deutsch")) {
        importWordsFromFile("data/german_words.txt", "Deutsch");
    }

    if (isWordTableEmpty("Русский")) {
        importWordsFromFile("data/russian_words.txt", "Русский");
    }

    if (isWordTableEmpty("Українська")) {
        importWordsFromFile("data/ukrainian_words.txt", "Українська");
    }

    return true;
}

void DatabaseManager::createTables()
{
    QSqlQuery query;

    if (!query.exec(
            "CREATE TABLE IF NOT EXISTS words ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "word TEXT NOT NULL,"
            "language TEXT NOT NULL,"
            "UNIQUE(word, language)"
            ")"
            )) {
        qDebug() << "Create table error:" << query.lastError().text();
    }
}

bool DatabaseManager::isWordTableEmpty(const QString &language)
{
    QSqlQuery query;
    query.prepare("SELECT COUNT(*) FROM words WHERE language = ?");
    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Check words error:" << query.lastError().text();
        return true;
    }

    if (query.next()) {
        return query.value(0).toInt() == 0;
    }

    return true;
}

void DatabaseManager::importWordsFromFile(const QString &filePath, const QString &language)
{
    QFile file(filePath);

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Cannot open words file:" << filePath;
        return;
    }

    QTextStream stream(&file);

    stream.setEncoding(QStringConverter::Utf8);

    int imported = 0;

    while (!stream.atEnd()) {
        QString word = stream.readLine().trimmed().toUpper();

        if (word.length() != 5) {
            continue;
        }

        QSqlQuery query;
        query.prepare("INSERT OR IGNORE INTO words (word, language) VALUES (?, ?)");

        query.addBindValue(word);
        query.addBindValue(language);

        if (!query.exec()) {
            qDebug() << "Insert word error:" << query.lastError().text();
        }
        else if (query.numRowsAffected() > 0) {
            imported++;
        }
    }

    qDebug() << "Imported" << imported << "words for language" << language;

    file.close();
}

QString DatabaseManager::getRandomWord(const QString &language)
{
    QSqlQuery query;
    query.prepare(
        "SELECT word FROM words "
        "WHERE language = ? "
        "ORDER BY RANDOM() "
        "LIMIT 1"
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Random word error:" << query.lastError().text();
        return "WORDS";
    }

    if (query.next()) {
        return query.value(0).toString().toUpper();
    }

    return "WORDS";
}

bool DatabaseManager::wordExists(const QString &word, const QString &language)
{
    QSqlQuery query;
    query.prepare(
        "SELECT COUNT(*) FROM words "
        "WHERE word = ? AND language = ?"
        );

    query.addBindValue(word.toUpper());
    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Word exists error:" << query.lastError().text();
        return false;
    }

    if (query.next()) {
        return query.value(0).toInt() > 0;
    }

    return false;
}