#ifndef BOARDMODEL_H
#define BOARDMODEL_H

#include <QAbstractListModel>
#include <QtQml/QQmlEngine>
#include <QVector>
#include <QChar>

struct CellData {
    QChar letter = ' ';
    int status = 0; // 0-EMPTY, 1-ABSENT, 2-PRESENT, 3-CORRECT
};

class BoardModel : public QAbstractListModel
{
    Q_OBJECT
    //QML_UNCREATABLE("Not allowed in QML")

public:
    enum Roles {
        LetterRole = Qt::UserRole + 1,
        StatusRole
    };

    explicit BoardModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void setCell(int index, QChar letter, int status);
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<CellData> m_cells;
};

#endif