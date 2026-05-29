#include "StatisticsManager.h"

#include <QSqlError>
#include <QSqlQuery>

StatisticsManager::StatisticsManager(QObject *parent)
    : QObject(parent)
{}

void StatisticsManager::resetResults(const QString &language){
    QSqlQuery query(m_stat_database);

    if (language == "General") {
        query.prepare(
            "UPDATE game_statistics "
            "SET wins = 0, losses = 0, games = 0, current_streak = 0, best_streak = 0 "
            );
    } else {
        query.prepare(
            "UPDATE game_statistics "
            "SET wins = 0, losses = 0, games = 0, current_streak = 0, best_streak = 0 "
            "WHERE language = ?"
            );

        query.addBindValue(language);
    }

    if (!query.exec()) {
        qDebug() << "Reset results error:" << query.lastError().text();
    }
}

bool StatisticsManager::openDatabase(){
    m_stat_database = QSqlDatabase::addDatabase("QSQLITE", "statistics_connection");
    m_stat_database.setDatabaseName("results.db");

    if (!m_stat_database.open()) {
        qDebug() << "Database error:" << m_stat_database.lastError().text();
        return false;
    }

    createTables();
    initializeLanguages();


    return true;
}

void StatisticsManager::createTables(){
    QSqlQuery query(m_stat_database);

    if (!query.exec(
            "CREATE TABLE IF NOT EXISTS game_statistics ("
            "language TEXT PRIMARY KEY,"
            "wins INTEGER NOT NULL DEFAULT 0,"
            "losses INTEGER NOT NULL DEFAULT 0,"
            "games INTEGER NOT NULL DEFAULT 0,"
            "current_streak INTEGER NOT NULL DEFAULT 0,"
            "best_streak INTEGER NOT NULL DEFAULT 0"
            ")"
            )) {
        qDebug() << "Create table error:" << query.lastError().text();
    }
}

void StatisticsManager::initializeLanguages()
{
    QStringList languages = {
        "English",
        "Deutsch",
        "Русский",
        "Українська",
        "General"
    };

    for (const QString &language : languages) {
        QSqlQuery query(m_stat_database);
        query.prepare(
            "INSERT OR IGNORE INTO game_statistics "
            "(language, wins, losses, games, current_streak, best_streak) "
            "VALUES (?, 0, 0, 0, 0, 0)"
            );

        query.addBindValue(language);

        if (!query.exec()) {
            qDebug() << "Init stats error:" << query.lastError().text();
        }
    }
}

void StatisticsManager::setGameWon(const QString &language){
    QSqlQuery query(m_stat_database);
    query.prepare(
        "UPDATE game_statistics "
        "SET wins = wins + 1, games = games + 1, "
        "current_streak = current_streak + 1, "
        "best_streak = MAX(best_streak, current_streak + 1) "
        "WHERE language = ?"
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Add win error:" << query.lastError().text();
    }

    QSqlQuery generalQuery(m_stat_database);
    generalQuery.prepare(
        "UPDATE game_statistics "
        "SET wins = wins + 1, games = games + 1, "
        "current_streak = current_streak + 1, "
        "best_streak = MAX(best_streak, current_streak + 1) "
        "WHERE language = 'General'"
        );

    if (!generalQuery.exec()) {
        qDebug() << "Add general win error:" << generalQuery.lastError().text();
    }

    emit statisticsChanged();
}

void StatisticsManager::setGameLost(const QString &language){
    QSqlQuery query(m_stat_database);
    query.prepare(
        "UPDATE game_statistics "
        "SET losses = losses + 1, games = games + 1, "
        "current_streak = 0 "
        "WHERE language = ?"
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Add win error:" << query.lastError().text();
    }

    QSqlQuery generalQuery(m_stat_database);
    generalQuery.prepare(
        "UPDATE game_statistics "
        "SET losses = losses + 1, games = games + 1, "
        "current_streak = 0 "
        "WHERE language = 'General'"
        );

    if (!generalQuery.exec()) {
        qDebug() << "Add general win error:" << generalQuery.lastError().text();
    }

    emit statisticsChanged();
}

int StatisticsManager::getGamesPlayed(const QString &language) const{
    QSqlQuery query(m_stat_database);
    query.prepare(
        "SELECT games FROM game_statistics "
        "WHERE language = ? "
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Get games played error:" << query.lastError().text();
        return 0;
    }

    if (query.next()) {
        return query.value(0).toInt();
    }

    return 0;
}

int StatisticsManager::getGamesWon(const QString &language) const{
    QSqlQuery query(m_stat_database);
    query.prepare(
        "SELECT wins FROM game_statistics "
        "WHERE language = ? "
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Get games won error:" << query.lastError().text();
        return 0;
    }

    if (query.next()) {
        return query.value(0).toInt();
    }

    return 0;
}

int StatisticsManager::getGamesLost(const QString &language) const{
    QSqlQuery query(m_stat_database);
    query.prepare(
        "SELECT losses FROM game_statistics "
        "WHERE language = ?"
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Get games lost error:" << query.lastError().text();
        return 0;
    }

    if (query.next())
        return query.value(0).toInt();

    return 0;
}

int StatisticsManager::getWinRate(const QString &language) const
{
    int games = getGamesPlayed(language);
    int wins = getGamesWon(language);

    if (games == 0)
        return 0;

    return (wins * 100) / games;
}

int StatisticsManager::getCurrentStreak(const QString &language) const{
    QSqlQuery query(m_stat_database);
    query.prepare(
        "SELECT current_streak FROM game_statistics "
        "WHERE language = ? "
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Get current streak error:" << query.lastError().text();
        return 0;
    }

    if (query.next()) {
        return query.value(0).toInt();
    }

    return 0;
}

int StatisticsManager::getBestStreak(const QString &language) const{
    QSqlQuery query(m_stat_database);
    query.prepare(
        "SELECT best_streak FROM game_statistics "
        "WHERE language = ? "
        );

    query.addBindValue(language);

    if (!query.exec()) {
        qDebug() << "Get best streak error:" << query.lastError().text();
        return 0;
    }

    if (query.next()) {
        return query.value(0).toInt();
    }

    return 0;
}



