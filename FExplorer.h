#ifndef FEXPLORER_H
#define FEXPLORER_H
#include <QDir>
#include <QFile>
#include <QStringList>
#include <QObject>
#include <QDebug>
#include "grid.h"


class FExplorer : public QObject
{
    Q_OBJECT
    public:
        FExplorer(Grid* grid);
        ~FExplorer();

        void openLeds(QString name, Grid* grid);
        void saveLeds(QString name, Grid* grid);

    public slots:
        QString getCurrentDir();
        bool cd(QString dirName);
        unsigned int count();
        QString getFile(int index);
        bool processFile(QString name);


    private:
        void toQByteArray(QByteArray& ra,const int& num );

        QDir m_directory;
        QStringList m_list;
        QString m_file;
        Grid* m_grid;

};
#endif // FEXPLORER_H
