#include "grid.h"


Grid::Grid(QObject *parent, LedBoardManager*  brdManager)
    :QObject(parent), m_currentPage(0), m_copyFlag(0), m_lastPage(1), m_color("red"), m_brdManager(brdManager)
{
    QColor off("black");
    m_LEDColor = new QColor*;
    m_LEDColor[0]= new QColor[1024];

    for (int i = 0; i < 1024; i++)
        m_LEDColor[m_currentPage][i] = off;

    m_duration = new int;
    m_duration[0] = 500;
}

Grid::~Grid()
{
    for(int i=0; i<m_lastPage; ++i)
        delete [] m_LEDColor[i];

    delete [] m_LEDColor;
    delete [] m_duration;
}

//Sets the current page to black
void Grid::clearBoard()
{
    QColor off("black");
    for(int i = 0; i < 1024; i++)
        m_LEDColor[m_currentPage][i] = off;
}
void Grid::flipPage(int direction)
{
    //Allows page turning to wrap
    if(m_currentPage == m_lastPage - 1 && direction)
        m_currentPage = 0;
    else if(m_currentPage == 0 && !direction)
        m_currentPage = m_lastPage-1;
    else
    {
        if (direction)
            m_currentPage += 1;
        else
            m_currentPage -= 1;
    }
}

//Dynamic allocation of new page
void Grid::insertPage()
{
    QColor off("black");
    ++m_lastPage;

    QColor **temp = new QColor*[m_lastPage];
    //duration
    int *temp2 = new int[m_lastPage];

    int i;
    for (i = 0; i <= m_currentPage; ++i)
    {
        temp[i] = m_LEDColor[i];
        temp2[i] = m_duration[i];
    }

    temp[m_currentPage+1] = new QColor[1024];
    temp2[m_currentPage+1] = 500;

    for (int j = m_currentPage+2; j < m_lastPage; ++j)
    {
        temp[j] = m_LEDColor[i];
        temp2[j] = m_duration[i++];
    }

    delete [] m_duration;
    delete [] m_LEDColor;
    m_LEDColor = temp;
    m_duration = temp2;

    m_currentPage += 1;

    for (int i = 0; i < 1024; i++)
        m_LEDColor[m_currentPage][i] = off;
}

//dynamic deallocation
void Grid::deletePage()
{
    if (m_lastPage == 1)
    {
        clearBoard();
        m_duration[0] = 500;
    }
    else
    {
        --m_lastPage;
        QColor **temp   = new QColor*[m_lastPage];
        int     *temp2  = new int[m_lastPage];

        int i;
        for (i = 0; i < m_currentPage; ++i)
        {
            temp[i] = m_LEDColor[i];
            temp2[i] = m_duration[i];
        }

        delete [] m_LEDColor[m_currentPage];

        for (int j = m_currentPage +1; j <= m_lastPage; ++j)
        {
            temp[i] = m_LEDColor[j];
            temp2[i++] = m_duration[j];
        }

        delete [] m_LEDColor;
        delete [] m_duration;
        m_LEDColor = temp;
        m_duration = temp2;

        if(m_currentPage >= m_lastPage)
            m_currentPage = m_lastPage -1;
    }
}

//This is the pen function
void Grid::ledPressed(int x, int y)
{
    m_LEDColor[m_currentPage][x + y*32] = m_color;
    //qDebug() << QString::number(x)<< QString::number(y);
}

void Grid::pastePage(int type, int originX, int originY, int endX, int endY)
{
    int startX = (originX < endX)? originX:endX;
    int startY = (originY < endY)? originY:endY;

    int copyEndX =   (originX > endX)? originX:endX;
    int copyEndY =   (originY > endY)? originY:endY;

    int lengthX =   (copyEndX - startX) < m_copyLengthX[type]? (copyEndX - startX) : m_copyLengthX[type];
    int lengthY =   (copyEndY - startY) < m_copyLengthY[type]? (copyEndY - startY) : m_copyLengthY[type];

    QColor* page = m_copyPage;

    if (type == 1)
    {
        page = m_undoPage;
    }
    else if (type == 2)
    {
        page = m_tempPage;
    }


    for (int i = 0; i < lengthX && startX <= 31; i++)
    {
        if (0 <= startX)
        {
            for (int j = 0; j < lengthY && startY <= 31; j++)
            {
                if (0 <= startY)
                {
                    m_LEDColor[m_currentPage][startX+(startY++)*32] = page[(m_copyStartX[type]+i)+(m_copyStartY[type]+j)*32];
                }
            }
        }
        startX++;
        startY = (originY < endY)? originY:endY;
    }
}

void Grid::copyPage(int type, int originX, int originY, int endX, int endY)
{
    QColor* page = m_copyPage;
    m_copyStartX[type] = (originX < endX)? originX:endX;
    m_copyStartY[type] = (originY < endY)? originY:endY;

    int copyEndX =   (originX > endX)? originX:endX;
    int copyEndY =   (originY > endY)? originY:endY;



    copyEndX = copyEndX < 32 ? copyEndX:32;
    copyEndY = copyEndY < 32 ? copyEndY:32;

    m_copyLengthX[type] =   copyEndX - m_copyStartX[type];
    m_copyLengthY[type] =   copyEndY - m_copyStartY[type];



    if (type == 1)
    {
        page = m_undoPage;
    }
    else if (type == 2)
    {
        page = m_tempPage;
    }

    m_copyFlag = 1;
    for (int i = m_copyStartX[type]; i < copyEndX && i <= 31; i++)
    {
        if (0 <= i)
        {
            for (int j = m_copyStartY[type]; j < copyEndY && j <= 31; j++)
            {
                if(0 <= j)
                {
                    page[i+j*32] = m_LEDColor[m_currentPage][i+j*32];
                }
            }
        }
    }
}

void Grid::undoPage()
{
    QColor temp;
    for (int i = 0; i < 1024; i++)
    {
        temp = m_LEDColor[m_currentPage][i];
        m_LEDColor[m_currentPage][i] = m_undoPage[i];
        m_undoPage[i] = temp;
    }
}

//recursive wrapper for fillBucket function
void Grid::fillBucket(int x, int y, int startX, int startY, int endX, int endY)
{

    if(m_LEDColor[m_currentPage][x+y*32] != m_color)
        fillBucket(x, y, m_LEDColor[m_currentPage][x+y*32], (startX < endX)? startX:endX,(startY < endY)? startY:endY, (startX > endX)? startX-1:endX -1, (startY > endY)? startY-1:endY-1);
}

void Grid::fillBucket(int x, int y, QColor color, const int & startX,const int & startY, const int & endX, const int & endY)
{
    m_LEDColor[m_currentPage][x+y*32] = m_color;
    m_brdManager->sendLedSet(x,y);

    //qDebug() << QString::number(x)<< QString::number(y);
    if ( y < endY && y < 31 && m_LEDColor[m_currentPage][x+(y+1)*32] == color)
        fillBucket(x, y+1, color, startX, startY, endX, endY);
    if ( x < endX && x < 31 && m_LEDColor[m_currentPage][(x+1)+y*32] == color)
        fillBucket(x+1, y, color, startX, startY, endX, endY);
    if ( y > startY && y > 0 && m_LEDColor[m_currentPage][x+(y-1)*32] == color)
        fillBucket(x, y-1, color, startX, startY, endX, endY);
    if ( x > startX && x > 0 && m_LEDColor[m_currentPage][(x-1)+y*32] == color)
        fillBucket(x-1, y, color, startX, startY, endX, endY);
}


