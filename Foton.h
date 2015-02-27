#ifndef FOTON_H
#define FOTON_H
#include "FExplorer.h"


class Foton : public QObject
{
    Q_OBJECT

    public:
        Foton(Grid* grid, FExplorer* explorer);

    public slots:
        void saveFoton(QString name){ m_explorer->saveLeds(name, m_grid);}
        void openFoton(QString name){ m_explorer->openLeds(name, m_grid);}

    private:
        Grid* m_grid;
        FExplorer* m_explorer; 
};

#endif // FOTON_H
