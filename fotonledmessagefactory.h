#ifndef FOTONLEDMESSAGEFACTORY_H
#define FOTONLEDMESSAGEFACTORY_H

class QString;
class QByteArray;

typedef  unsigned char FOTON_COORD;
typedef  unsigned char FOTON_COLOR;
typedef  unsigned int  FOTON_DISTANCE;

typedef  struct FOTON_RGB
{
    FOTON_COLOR Red;
    FOTON_COLOR Green;
    FOTON_COLOR Blue;
}FOTON_RGB;

static const char FOTON_START ='#';
static const char FOTON_TERMINAL ='$';

typedef struct FOTON_LIVE_MESSAGE
{
    unsigned char FUNC_CTRL;
    unsigned char DATA1;
    unsigned char DATA2;
    unsigned char DATA3;
}FOTON_LIVE_MESSAGE;


enum FUNCTIONS_MAJOR
{
    NONE = 0,
    LED_CLEAR,
    LED_SET_COLOR,
    LED_SET_AT,
    LED_READ
};


enum DRAW_MINOR
{
    LINE = 0,
    SQUARE,
    CIRCLE
};

typedef struct FOTON_LED_MESSAGE
{
    unsigned char FUNC_MJR : 3;
    unsigned char ROW      : 5;
    unsigned char FUNC_MNR : 3;
    unsigned char COL      : 5;
    unsigned char RED      : 8;
    unsigned char GREEN    : 8;
    unsigned char BLUE     : 8;
}FOTON_LED_MESSAGE; // Five Bytes

typedef struct FOTON_LINE
{
    FOTON_COORD X1;
    FOTON_COORD Y1;
    FOTON_COORD X2;
    FOTON_COORD Y2;
}FOTON_LINE;

typedef struct FOTON_RECT
{
    FOTON_COORD X;
    FOTON_COORD Y;
    FOTON_DISTANCE Height;
    FOTON_DISTANCE Width;
}FOTON_RECT;



class FotonLEDMessageFactory
{
public:
    explicit FotonLEDMessageFactory();
    void  createLEDSet(int ROW, int COL, QByteArray& buffer);
    void  createLEDClear(int led_num,QByteArray& buffer);
    void  createDrawLine(FOTON_LINE line, FOTON_RGB color,QByteArray& buffer);
    void  createLEDSetColor(FOTON_COLOR RED, FOTON_COLOR GREEN, FOTON_COLOR BLUE, QByteArray& buffer);
};

#endif // FOTONLEDMESSAGEFACTORY_H
