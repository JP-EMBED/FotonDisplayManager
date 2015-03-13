#include "FExplorer.h"


FExplorer::FExplorer(Grid* grid)
    :m_directory(QDir::home()), m_list(), m_file(),m_grid(grid)
{
    QString name;

    /*if (!m_directory.cd("Foton"))
    {
        m_directory.mkdir("Foton");
        m_directory.cd("Foton");
    }

    QFile file(m_directory.absolutePath()+"/Foton.conf");

    if(file.exists())
    {
        file.open(QIODevice::ReadOnly);

        name += file.readAll();

        //openLeds(name, m_grid);

    }
    else
        file.open(QIODevice::ReadOnly);
    file.close();
    */
    m_list = m_directory.entryList(QDir::AllEntries | QDir::NoDot);
}

FExplorer::~FExplorer()
{}

QString FExplorer::getCurrentDir()
{
    return m_directory.absolutePath();
}

bool FExplorer::cd(QString dirName)
{
    bool valid;

    valid = m_directory.cd(dirName);

    if (valid)
    {
        m_list = m_directory.entryList(QDir::AllEntries | QDir::NoDot);
    }
    return valid;
}

unsigned int FExplorer::count()
{
    return m_directory.count();
}

QString FExplorer::getFile(int index)
{
    //qDebug() << index;
    QString value;

    if (0 <= index && index < m_directory.count())
    {
        value = m_list.value(index);
    }
    //qDebug() << m_directory.count();
    return value;
}

bool FExplorer::processFile(QString name)
{
    //QFileInfo file(m_directory[index]);
    bool ret = false;

    if (name != "")
    {
        if (!cd(name))
            ret = true;
    }

    return ret;
}

void FExplorer::saveLeds(QString name, Grid* grid)
{
    QFile file(m_directory.absolutePath()+"/"+name);
    QByteArray ra;

    m_file = name;

    file.open(QIODevice::WriteOnly);

    toQByteArray(ra, grid->m_lastPage);


    for (int i = 0; i < grid->m_lastPage; i++)
    {
        for (int j = 0; j < 1024; j++)
        {
            ra.append(grid->m_LEDColor[i][j].red());
            ra.append(grid->m_LEDColor[i][j].green());
            ra.append(grid->m_LEDColor[i][j].blue());
            ra.append(grid->m_LEDColor[i][j].alpha());
        }
    }


    for (int i = 0; i < grid->m_lastPage; i++)
    {
        toQByteArray(ra,grid->m_duration[i]);
    }

    file.write(ra);

    file.close();

    m_list = m_directory.entryList(QDir::AllEntries | QDir::NoDot);
}


void FExplorer::openLeds(QString name, Grid* grid)
{
    QFile file(m_directory.absolutePath()+"/"+name);
    char buffer[4];
    QByteArray ra;
    QString stringID;
    int lastpage = 0;


    if(file.exists())
    {
        if(file.open(QIODevice::ReadOnly))
        {

            for (int i = grid->m_lastPage; i > 0; i--)
                grid->deletePage();

            for (int i = 0; i < sizeof(int); i++)
            {
                file.getChar(buffer);
                lastpage = lastpage << 8;
                lastpage += (unsigned char)buffer[0];
            }




            qDebug () << lastpage;
            for (int i = 0; i < lastpage; i++)
            {
                for (int j = 0; j < 1024; j++)
                {
                    for (int x = 0; x < 4; x++)
                        file.getChar(&(buffer[x]));
                    grid->m_LEDColor[i][j] = QColor((unsigned char)buffer[0], (unsigned char)buffer[1], (unsigned char)buffer[2], (unsigned char)buffer[3]);
                }
                grid->insertPage();
            }
            grid->deletePage();

            for (int i = 0; i < lastpage; i++)
            {
                grid->m_duration[i] = 0;
                for (int j = 0; j < sizeof(int); j++)
                {
                    file.getChar(buffer);
                    grid->m_duration[i] = grid->m_duration[i] << 8;
                    grid->m_duration[i] = grid->m_duration[i] + (unsigned char)buffer[0];
                }
            }
            qDebug() << grid->m_duration[0];

            file.close();
        }
    }
}


void FExplorer::toQByteArray(QByteArray& ra,const int& num )
{
    for(int j = sizeof(int)-1; j >= 0; j--)
    {
      ra.append((char)((num&(0xFF << (j*8))) >>(j*8)));
    }
}

