#ifndef KEYBOARDMODEL_H
#define KEYBOARDMODEL_H

#include <QAbstractListModel>
#include <QVector>
#include <QChar>

struct KeyData {
    QChar letter;
    int status = 0; // 0-EMPTY, 1-ABSENT, 2-PRESENT, 3-CORRECT
};

class KeyboardModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        LetterRole = Qt::UserRole + 1,
        StatusRole
    };

    explicit KeyboardModel(QObject *parent = nullptr);


    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    void updateKey(QChar letter, int status);
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<KeyData> m_keys;
};

#endif