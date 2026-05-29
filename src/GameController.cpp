#include "GameController.h"

GameController::GameController(QObject *parent)
    : QObject(parent)
    , m_secretWord("WORDS") // Default word, change to bd
    , m_currentAttempt(0)
    , m_currentInput("")
{
    m_boardModel = new BoardModel(this);
    m_keyboardModel = new KeyboardRowModel(this);
    m_databaseManager = new DatabaseManager();

    if (m_databaseManager->openDatabase()) {
        m_secretWord = m_databaseManager->getRandomWord(m_wordLanguage);
    }
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

BoardModel* GameController::boardModel() const
{
    return m_boardModel;
}

KeyboardRowModel* GameController::keyboardModel() const
{
    return m_keyboardModel;
}

void GameController::submitGuess()
{
    if (m_currentInput.length() != m_maxWordLength || m_currentAttempt >= m_maxAttempts) {
        return;
    }

    int startIdx = m_currentAttempt * m_maxWordLength;
    QString guess = m_currentInput.toUpper();

    if (!m_databaseManager->wordExists(guess, m_wordLanguage)) {
        emit invalidWord(guess);
        return;
    }

    for (int i = 0; i < m_maxWordLength; ++i) {
        QChar guessChar = guess[i];
        int status = 1; // Default: ABSENT

        if (guessChar == m_secretWord[i]) {
            status = 3; // CORRECT
        } else if (m_secretWord.contains(guessChar)) {
            status = 2; // PRESENT
        }

        int cellIdx = startIdx + i;
        m_boardModel->setCell(cellIdx, guessChar, status);
        m_keyboardModel->updateKey(guessChar, status);
    }

    bool isWin = guess == m_secretWord;

    m_currentAttempt++;
    m_currentInput = "";

    emit currentAttemptChanged();
    emit currentInputChanged();

    if (isWin) {
        emit gameWon(m_secretWord);
    } else if (m_currentAttempt >= m_maxAttempts) {
        emit gameLost(m_secretWord);
    }
}

void GameController::resetGame()
{
    m_currentInput = "";
    m_currentAttempt = 0;

    if (m_databaseManager) {
        setSecretWord(m_databaseManager->getRandomWord(m_wordLanguage));
    }

    m_boardModel->clear();
    m_keyboardModel->clear();


    emit currentInputChanged();
    emit currentAttemptChanged();
}

QString GameController::wordLanguage() const
{
    return m_wordLanguage;
}

void GameController::setWordLanguage(const QString &language)
{
    if (m_wordLanguage == language)
        return;

    m_wordLanguage = language;
    m_keyboardModel->setLanguage(language);

    emit wordLanguageChanged();

    resetGame();
}