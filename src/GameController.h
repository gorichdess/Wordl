#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QtQml/QQmlEngine>
#include "BoardModel.h"
#include "KeyboardModel.h"

class GameController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString secretWord READ secretWord NOTIFY secretWordChanged)
    Q_PROPERTY(int currentAttempt READ currentAttempt NOTIFY currentAttemptChanged)
    Q_PROPERTY(QString currentInput READ currentInput WRITE setCurrentInput NOTIFY currentInputChanged)

    Q_PROPERTY(BoardModel* boardModel READ boardModel CONSTANT)
    Q_PROPERTY(KeyboardModel* keyboardModel READ keyboardModel CONSTANT)

    Q_PROPERTY(QString wordLanguage READ wordLanguage WRITE setWordLanguage NOTIFY wordLanguageChanged)

public:

    explicit GameController(QObject *parent = nullptr);

    QString secretWord() const;
    void setSecretWord(const QString &word);

    int currentAttempt() const;

    QString currentInput() const;
    void setCurrentInput(const QString &input);

    BoardModel* boardModel() const;
    KeyboardModel* keyboardModel() const;

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

private:
    QString m_secretWord;
    int m_currentAttempt;
    QString m_currentInput;
    const int m_maxWordLength = 5;
    const int m_maxAttempts = 5;

    BoardModel *m_boardModel;
    KeyboardModel *m_keyboardModel;

    QString m_wordLanguage = "English";
};
#endif