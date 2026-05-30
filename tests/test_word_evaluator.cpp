#include <QtTest>
#include "../src/WordEvaluator.h"

class TestWordEvaluator : public QObject
{
    Q_OBJECT

private slots:
    void allLettersCorrect();
    void allLettersAbsent();
    void someLettersPresent();
    void repeatedLettersInGuess();
    void repeatedLettersInSecret();
    void lowercaseInput();
};

void TestWordEvaluator::allLettersCorrect()
{
    QVector<int> result = WordEvaluator::evaluate("WORDS", "WORDS");
    QVector<int> expected = {3, 3, 3, 3, 3};

    QCOMPARE(result, expected);
}

void TestWordEvaluator::allLettersAbsent(){
    QVector<int> result = WordEvaluator::evaluate("WORDS", "PLANT");
    QVector<int> expected = {1, 1, 1, 1, 1};

    QCOMPARE(result, expected);
}

void TestWordEvaluator::someLettersPresent()
{
    QVector<int> result = WordEvaluator::evaluate("STONE", "NOTES");
    QVector<int> expected = {2, 2, 2, 2, 2};

    QCOMPARE(result, expected);
}

void TestWordEvaluator::repeatedLettersInGuess()
{
    QVector<int> result = WordEvaluator::evaluate("ALLEY", "APPLE");
    QVector<int> expected = {3, 2, 1, 2, 1};

    QCOMPARE(result, expected);
}

void TestWordEvaluator::repeatedLettersInSecret()
{
    QVector<int> result = WordEvaluator::evaluate("PAPER", "APPLE");
    QVector<int> expected = {2, 2, 3, 2, 1};

    QCOMPARE(result, expected);
}

void TestWordEvaluator::lowercaseInput()
{
    QVector<int> result = WordEvaluator::evaluate("words", "WORDS");
    QVector<int> expected = {3, 3, 3, 3, 3};

    QCOMPARE(result, expected);
}

QTEST_MAIN(TestWordEvaluator)
#include "test_word_evaluator.moc"