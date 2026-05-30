#include <QtTest>
#include <QTemporaryDir>

#include "../src/StatisticsManager.h"

class TestStatisticsManager : public QObject
{
    Q_OBJECT

private slots:
    void initialValuesAreZero();
    void winUpdatesStatistics();
    void lossUpdatesStatistics();
    void winRateIsCalculatedCorrectly();
    void streakIsResetAfterLoss();
    void generalStatisticsAreUpdated();
    void resetSpecificLanguage();
    void resetGeneralStatistics();
};

void TestStatisticsManager::initialValuesAreZero()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_initial"));

    QCOMPARE(stats.getGamesPlayed("English"), 0);
    QCOMPARE(stats.getGamesWon("English"), 0);
    QCOMPARE(stats.getGamesLost("English"), 0);
    QCOMPARE(stats.getWinRate("English"), 0);
    QCOMPARE(stats.getCurrentStreak("English"), 0);
    QCOMPARE(stats.getBestStreak("English"), 0);
}

void TestStatisticsManager::winUpdatesStatistics()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_win"));

    stats.setGameWon("English");

    QCOMPARE(stats.getGamesPlayed("English"), 1);
    QCOMPARE(stats.getGamesWon("English"), 1);
    QCOMPARE(stats.getGamesLost("English"), 0);
    QCOMPARE(stats.getCurrentStreak("English"), 1);
    QCOMPARE(stats.getBestStreak("English"), 1);
}

void TestStatisticsManager::lossUpdatesStatistics()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_loss"));

    stats.setGameLost("English");

    QCOMPARE(stats.getGamesPlayed("English"), 1);
    QCOMPARE(stats.getGamesWon("English"), 0);
    QCOMPARE(stats.getGamesLost("English"), 1);
    QCOMPARE(stats.getCurrentStreak("English"), 0);
    QCOMPARE(stats.getBestStreak("English"), 0);
}

void TestStatisticsManager::winRateIsCalculatedCorrectly()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_winrate"));

    stats.setGameWon("English");
    stats.setGameLost("English");

    QCOMPARE(stats.getGamesPlayed("English"), 2);
    QCOMPARE(stats.getGamesWon("English"), 1);
    QCOMPARE(stats.getWinRate("English"), 50);
}

void TestStatisticsManager::streakIsResetAfterLoss()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_streak"));

    stats.setGameWon("English");
    stats.setGameWon("English");
    stats.setGameLost("English");

    QCOMPARE(stats.getGamesPlayed("English"), 3);
    QCOMPARE(stats.getCurrentStreak("English"), 0);
    QCOMPARE(stats.getBestStreak("English"), 2);
}

void TestStatisticsManager::generalStatisticsAreUpdated()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_general"));

    stats.setGameWon("English");
    stats.setGameLost("Deutsch");

    QCOMPARE(stats.getGamesPlayed("General"), 2);
    QCOMPARE(stats.getGamesWon("General"), 1);
    QCOMPARE(stats.getGamesLost("General"), 1);
    QCOMPARE(stats.getWinRate("General"), 50);
}

void TestStatisticsManager::resetSpecificLanguage()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_reset_language"));

    stats.setGameWon("English");
    stats.setGameWon("English");
    stats.setGameLost("English");

    stats.setGameWon("Deutsch");

    stats.resetResults("English");

    QCOMPARE(stats.getGamesPlayed("English"), 0);
    QCOMPARE(stats.getGamesWon("English"), 0);
    QCOMPARE(stats.getGamesLost("English"), 0);
    QCOMPARE(stats.getCurrentStreak("English"), 0);
    QCOMPARE(stats.getBestStreak("English"), 0);

    QCOMPARE(stats.getGamesPlayed("Deutsch"), 1);
    QCOMPARE(stats.getGamesWon("Deutsch"), 1);
    QCOMPARE(stats.getGamesLost("Deutsch"), 0);
    QCOMPARE(stats.getCurrentStreak("Deutsch"), 1);
    QCOMPARE(stats.getBestStreak("Deutsch"), 1);
}

void TestStatisticsManager::resetGeneralStatistics()
{
    StatisticsManager stats;
    QVERIFY(stats.openDatabase(":memory:", "test_stats_reset_general"));

    stats.setGameWon("English");
    stats.setGameLost("Deutsch");

    stats.resetResults("General");

    QCOMPARE(stats.getGamesPlayed("English"), 0);
    QCOMPARE(stats.getGamesWon("English"), 0);
    QCOMPARE(stats.getGamesLost("English"), 0);

    QCOMPARE(stats.getGamesPlayed("Deutsch"), 0);
    QCOMPARE(stats.getGamesWon("Deutsch"), 0);
    QCOMPARE(stats.getGamesLost("Deutsch"), 0);

    QCOMPARE(stats.getGamesPlayed("General"), 0);
    QCOMPARE(stats.getGamesWon("General"), 0);
    QCOMPARE(stats.getGamesLost("General"), 0);
}

QTEST_MAIN(TestStatisticsManager)
#include "test_statistics_manager.moc"