#include "KeyboardModel.h"

KeyboardModel::KeyboardModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int KeyboardModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_keys.size();
}

void KeyboardModel::setLetters(const QString &letters)
{
    beginResetModel();

    m_keys.clear();

    for (QChar letter : letters) {
        m_keys.append({letter, 0});
    }

    endResetModel();
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


KeyboardRowModel::KeyboardRowModel(QObject *parent)
    : QObject(parent)
{
    m_row0 = new KeyboardModel(this);
    m_row1 = new KeyboardModel(this);
    m_row2 = new KeyboardModel(this);

    setLanguage("English");
}

KeyboardModel* KeyboardRowModel::row0() const { return m_row0; }
KeyboardModel* KeyboardRowModel::row1() const { return m_row1; }
KeyboardModel* KeyboardRowModel::row2() const { return m_row2; }

void KeyboardRowModel::setLanguage(const QString &language)
{
    QStringList rows;

    if (language == "English") {
        rows = {
            "QWERTYUIOP",
            "ASDFGHJKL",
            "ZXCVBNM"
        };
    }
    else if (language == "Deutsch") {
        rows = {
            "QWERTZUIOPÜ",
            "ASDFGHJKLÖÄ",
            "YXCVBNM"
        };
    }
    else if (language == "Русский") {
        rows = {
            "ЙЦУКЕНГШЩЗХЪ",
            "ФЫВАПРОЛДЖЭ",
            "ЯЧСМИТЬБЮ"
        };
    }
    else if (language == "Українська") {
        rows = {
            "ЙЦУКЕНГШЩЗХЇ",
            "ФІВАПРОЛДЖЄ",
            "ЯЧСМИТЬБЮ"
        };
    }

    m_row0->setLetters(rows.value(0));
    m_row1->setLetters(rows.value(1));
    m_row2->setLetters(rows.value(2));
}

void KeyboardRowModel::updateKey(QChar letter, int status)
{
    m_row0->updateKey(letter, status);
    m_row1->updateKey(letter, status);
    m_row2->updateKey(letter, status);
}

void KeyboardRowModel::clear()
{
    m_row0->clear();
    m_row1->clear();
    m_row2->clear();
}