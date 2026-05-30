#ifndef WORDEVALUATOR_H
#define WORDEVALUATOR_H

#include <QString>
#include <QVector>

class WordEvaluator
{
public:
    static QVector<int> evaluate(const QString& guess, const QString& secret);
};

#endif