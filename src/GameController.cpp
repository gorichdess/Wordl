#include "GameController.h"

GameController::GameController(QObject *parent)
    : QObject(parent)
    , m_secretWord("WORDS") // Default word, change to bd
    , m_currentAttempt(0)
    , m_currentInput("")
{
}

QString GameController::secretWord() const { return m_secretWord; }

void GameController::setSecretWord(const QString &word)
{
    if (m_secretWord != word.toUpper()) {
        m_secretWord = word.toUpper();
        emit secretWordChanged();
    }
}

int GameController::currentAttempt() const { return m_currentAttempt; }

QString GameController::currentInput() const { return m_currentInput; }

void GameController::setCurrentInput(const QString &input)
{
    if (m_currentInput != input) {
        m_currentInput = input;
        emit currentInputChanged();
    }
}

void GameController::appendLetter(const QString &letter)
{
    if (m_currentInput.length() < m_maxWordLength && m_currentAttempt < m_maxAttempts) {
        m_currentInput += letter.toUpper();
        emit currentInputChanged();
    }
}

void GameController::removeLastLetter()
{
    if (!m_currentInput.isEmpty()) {
        m_currentInput.chop(1);
        emit currentInputChanged();
    }
}

QVariantList GameController::submitGuess()
{
    QVariantList results;

    if (m_currentInput.length() != m_maxWordLength || m_currentAttempt >= m_maxAttempts) {
        return results;
    }

    for (int i = 0; i < m_maxWordLength; ++i) {
        QChar guessChar = m_currentInput[i];
        int status = 1; // Default: ABSENT

        if (guessChar == m_secretWord[i]) {
            status = 3; // CORRECT
        } else if (m_secretWord.contains(guessChar)) {
            status = 2; // PRESENT
        }
        results.append(status);
    }

    m_currentAttempt++;
    m_currentInput = "";

    emit currentAttemptChanged();
    emit currentInputChanged();

    return results;
}

void GameController::resetGame()
{
    m_currentInput = "";
        m_currentAttempt = 0;
        emit currentInputChanged();
    emit currentAttemptChanged();
}