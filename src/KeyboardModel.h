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

    void setLetters(const QString &letters);

    void updateKey(QChar letter, int status);
    void clear();

protected:
    QHash<int, QByteArray> roleNames() const override;

private:
    QVector<KeyData> m_keys;
};

class KeyboardRowModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(KeyboardModel* row0 READ row0 CONSTANT)
    Q_PROPERTY(KeyboardModel* row1 READ row1 CONSTANT)
    Q_PROPERTY(KeyboardModel* row2 READ row2 CONSTANT)

public:
    explicit KeyboardRowModel(QObject *parent = nullptr);

    KeyboardModel* row0() const;
    KeyboardModel* row1() const;
    KeyboardModel* row2() const;

    void setLanguage(const QString &language);
    void updateKey(QChar letter, int status);
    void clear();

private:
    KeyboardModel *m_row0;
    KeyboardModel *m_row1;
    KeyboardModel *m_row2;
};

#endif