#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QHash>
#include <QtQml/QQmlEngine>
#include "BoardModel.h"
#include "KeyboardModel.h"
#include "DatabaseManager.h"
#include "StatisticsManager.h"
#include "WordEvaluator.h"

class GameController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString secretWord READ secretWord NOTIFY secretWordChanged)
    Q_PROPERTY(int currentAttempt READ currentAttempt NOTIFY currentAttemptChanged)
    Q_PROPERTY(QString currentInput READ currentInput NOTIFY currentInputChanged)

    Q_PROPERTY(BoardModel* boardModel READ boardModel CONSTANT)
    Q_PROPERTY(KeyboardRowModel* keyboardModel READ keyboardModel CONSTANT)

    Q_PROPERTY(QString wordLanguage READ wordLanguage WRITE setWordLanguage NOTIFY wordLanguageChanged)

    Q_PROPERTY(StatisticsManager* statistics READ statistics CONSTANT)

public:

    explicit GameController(QObject *parent = nullptr);

    QString secretWord() const;
    void setSecretWord(const QString &word);

    int currentAttempt() const;

    QString currentInput() const;

    BoardModel* boardModel() const;
    KeyboardRowModel* keyboardModel() const;
    StatisticsManager* statistics() const;

    QString wordLanguage() const;
    void setWordLanguage(const QString &language);

    Q_INVOKABLE void appendLetter(const QString &letter);
    Q_INVOKABLE void removeLastLetter();
    Q_INVOKABLE void submitGuess();
    Q_INVOKABLE void resetGame();

signals:
    void secretWordChanged();
    void currentAttemptChanged();
    void currentInputChanged();
    void wordLanguageChanged();
    void invalidWord(QString word);
    void gameWon(QString word);
    void gameLost(QString word);

private:
    QString m_secretWord;
    int m_currentAttempt;
    QString m_currentInput;
    const int m_maxWordLength = 5;
    const int m_maxAttempts = 5;

    BoardModel *m_boardModel;
    KeyboardRowModel *m_keyboardModel;
    DatabaseManager *m_databaseManager;
    StatisticsManager *m_statisticsManager;

    QString m_wordLanguage = "English";
};
#endif