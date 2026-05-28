#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QString>
#include <QSqlDatabase>

class DatabaseManager
{
public:
    DatabaseManager();

    bool openDatabase();
    void createTables();

    void importWordsFromFile(const QString &filePath, const QString &language);

    QString getRandomWord(const QString &language);
    bool wordExists(const QString &word, const QString &language);

private:
    bool isWordTableEmpty(const QString &language);

    QSqlDatabase m_database;
};

#endif