#ifndef STATISTICSMANAGER_H
#define STATISTICSMANAGER_H

#include <QString>
#include <QObject>
#include <QSqlDatabase>

class StatisticsManager : public QObject
{
    Q_OBJECT

public:
    explicit StatisticsManager(QObject *parent = nullptr);

    Q_INVOKABLE int getGamesPlayed(const QString &language) const;
    Q_INVOKABLE int getGamesWon(const QString &language) const;
    Q_INVOKABLE int getGamesLost(const QString &language) const;
    Q_INVOKABLE int getWinRate(const QString &language) const;
    Q_INVOKABLE int getCurrentStreak(const QString &language) const;
    Q_INVOKABLE int getBestStreak(const QString &language) const;


    void resetResults(const QString &language);
    bool openDatabase();

    void setGameWon(const QString &language);
    void setGameLost(const QString &language);

signals:
    void statisticsChanged();

private:
    QSqlDatabase m_stat_database;

    void createTables();
    void initializeLanguages();
};

#endif