#ifndef GRID_H
#define GRID_H
#include <QObject>
#include <QDir>
#include <QColor>
#include "ledboardmanager.h"
#include <QRect>
class Grid : public QObject
{
    Q_OBJECT

    friend class FExplorer;

    public:
        Grid(QObject *parent, LedBoardManager*  brdManager);
        ~Grid();

        void fillBucket(int x, int y, QColor color, const int & startX, const int & startY, const int & endX, const int & endY);
        void fillBucketInverseSelect(int x, int y, QColor color, const int & startX, const int & startY, const int & endX, const int & endY, QRect &select_rect);
        void DeletePage();
    signals:

    public slots:
        //Change grid value functions, for display as well as actual value
        void flipPage(int direction);
        void insertPage();
        void deletePage();

        void clearBoard();
        void colorSelect(const QColor &color) {m_color = color;}

        void ledPressed(int x, int y);
        void fillBucket(int x, int y,  int startX = 0, int startY = 0, int endX = 32, int endY = 32);
        void fillBucketInverseSelect(int x, int y,QRect select_rect,  int startX = 0, int startY = 0, int endX = 32, int endY = 32);

        QColor getColor(){return m_color;}

        //Copy/Paste functions
        void copyPage(int type = 0,int originX = 0, int originY = 0, int endX = 32, int endY = 32);
        void pastePage(int type = 0,int originX = 0, int originY = 0, int endX = 32, int endY = 32);
        void undoPage();
        int getCopyFlag(){return m_copyFlag;}

        //Gets/Sets
        QColor getLedColor(int index){return m_LEDColor[m_currentPage][index];}
        QColor getLedColor(int x, int y){return m_LEDColor[m_currentPage][x+y*32];}
        void setLedColor(QColor color, int x, int y){m_LEDColor[m_currentPage][x+y*32] = color;}

        int getPages(){return m_lastPage;}

        int getDuration(){return m_duration[m_currentPage];}
        void  setDuration(int duration) {m_duration[m_currentPage] = duration;}

    private:
        QColor **m_LEDColor;         //Dynamic LED color storage

        QColor m_copyPage[1024];     //A buffer to copy LED color into
        QColor m_tempPage[1024];     //A temp buffer for misc use, i.e. box select paste
        QColor m_undoPage[1024];     //An undo buffer to copy LED colors out of

        int m_currentPage;           //The # for current Slide, used as an index with m_LEDColor
        int m_copyFlag;              //A flag that says wether the copy buffer is empty or not
        int m_lastPage;              //Total number of slides. Not 0 indexed, so 1 means only 1 slide

        int m_copyStartX[3];
        int m_copyStartY[3];
        int m_copyLengthX[3];
        int m_copyLengthY[3];

        QColor m_color;

        int* m_duration;//Holds duration, and type of transition dynamic (considering changing to struct)
        LedBoardManager*   m_brdManager;
};
#endif
