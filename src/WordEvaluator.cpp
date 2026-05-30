#include "WordEvaluator.h"

#include <QHash>
#include <QChar>

QVector<int> WordEvaluator::evaluate(const QString& guess, const QString& secret)
{
    QString normalizedGuess = guess.toUpper();
    QString normalizedSecret = secret.toUpper();

    int wordLength = normalizedSecret.length();

    QHash<QChar, int> lettersLeft;

    for (int i = 0; i < wordLength; ++i) {
        lettersLeft[normalizedSecret[i]]++;
    }

    QVector<int> statuses(wordLength, 1); // 1 = ABSENT

    for (int i = 0; i < wordLength; ++i) {
        if (normalizedGuess[i] == normalizedSecret[i]) {
            statuses[i] = 3; // 3 = CORRECT
            lettersLeft[normalizedGuess[i]]--;
        }
    }

    for (int i = 0; i < wordLength; ++i) {
        if (statuses[i] == 3)
            continue;

        QChar guessChar = normalizedGuess[i];

        if (lettersLeft.contains(guessChar) && lettersLeft[guessChar] > 0) {
            statuses[i] = 2; // 2 = PRESENT
            lettersLeft[guessChar]--;
        }
    }

    return statuses;
}