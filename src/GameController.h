#ifndef GAMECONTROLLER_H
#define GAMECONTROLLER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <QtQml/QQmlEngine>

class GameController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString secretWord READ secretWord NOTIFY secretWordChanged)
    Q_PROPERTY(int currentAttempt READ currentAttempt NOTIFY currentAttemptChanged)
    Q_PROPERTY(QString currentInput READ currentInput WRITE setCurrentInput NOTIFY currentInputChanged)

public:

    explicit GameController(QObject *parent = nullptr);

    QString secretWord() const;
    void setSecretWord(const QString &word);

    int currentAttempt() const;

    QString currentInput() const;
    void setCurrentInput(const QString &input);

    Q_INVOKABLE void appendLetter(const QString &letter);
    Q_INVOKABLE void removeLastLetter();
    Q_INVOKABLE QVariantList submitGuess();
    Q_INVOKABLE void resetGame();

signals:
    void secretWordChanged();
    void currentAttemptChanged();
    void currentInputChanged();

private:
    QString m_secretWord;
    int m_currentAttempt;
    QString m_currentInput;
    const int m_maxWordLength = 5;
    const int m_maxAttempts = 5;
};
#endif