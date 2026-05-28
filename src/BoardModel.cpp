#include "BoardModel.h"

BoardModel::BoardModel(QObject *parent)
    : QAbstractListModel(parent)
{
    m_cells.resize(25);
}

int BoardModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid()) return 0;
    return m_cells.size();
}

QVariant BoardModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_cells.size())
        return QVariant();

    const auto &cell = m_cells[index.row()];

    if (role == LetterRole) return QString(cell.letter);
    if (role == StatusRole) return cell.status;

    return QVariant();
}

void BoardModel::setCell(int index, QChar letter, int status)
{
    if (index < 0 || index >= m_cells.size()) return;

    m_cells[index] = {letter, status};
    emit dataChanged(this->index(index), this->index(index), {LetterRole, StatusRole});
}

void BoardModel::clear()
{
    beginResetModel();
    for (auto &cell : m_cells) {
        cell.letter = ' ';
        cell.status = 0; // EMPTY
    }
    endResetModel();
}

QHash<int, QByteArray> BoardModel::roleNames() const
{
    return {
        {LetterRole, "letter"},
        {StatusRole, "status"}
    };
}