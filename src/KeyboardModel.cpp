#include "KeyboardModel.h"

KeyboardModel::KeyboardModel(QObject *parent)
    : QAbstractListModel(parent)
{
    QString letters = "QWERTYUIOPASDFGHJKLZXCVBNM";

    for (QChar letter : letters) {
        m_keys.append({letter, 0});
    }
}

int KeyboardModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_keys.size();
}

QVariant KeyboardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_keys.size())
        return QVariant();

    const auto &key = m_keys[index.row()];

    if (role == LetterRole) return QString(key.letter);
    if (role == StatusRole) return key.status;

    return QVariant();
}

void KeyboardModel::updateKey(QChar letter, int status)
{
    letter = letter.toUpper();

    for (int i = 0; i < m_keys.size(); ++i) {
        if (m_keys[i].letter == letter) {
            if (status > m_keys[i].status) {
                m_keys[i].status = status;
                emit dataChanged(index(i), index(i), {StatusRole});
            }
            return;
        }
    }
}

void KeyboardModel::clear()
{
    for (int i = 0; i < m_keys.size(); ++i) {
        m_keys[i].status = 0;
        emit dataChanged(index(i), index(i), {StatusRole});
    }
}

QHash<int, QByteArray> KeyboardModel::roleNames() const
{
    return {
        {LetterRole, "letter"},
        {StatusRole, "status"}
    };
}