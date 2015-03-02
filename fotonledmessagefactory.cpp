#include "fotonledmessagefactory.h"
#include <QString>
#include <QByteArray>
#include <QDebug>
#include <QDataStream>


FotonLEDMessageFactory::FotonLEDMessageFactory()
{
}

// Fills the buffer with a 7 byte encoded LED Set Command
void FotonLEDMessageFactory::createLEDSet(int ROW, int COL, QByteArray& buffer)
{
    //qDebug() << "CTRL Byte 1 " << ((LED_MJR << 5) | ROW );
    //qDebug() << "CTRL Byte 2 " << ((LED_SET_MNR << 5) | COL);

    buffer.append(LED_SET_AT);
    buffer.append(ROW);
    buffer.append(COL);

    buffer.append(FOTON_TERMINAL);

   // qDebug() << buffer << " With a length of " << buffer.length();


}

void FotonLEDMessageFactory::createLEDSetColor(FOTON_COLOR RED, FOTON_COLOR GREEN, FOTON_COLOR BLUE, QByteArray& buffer)
{

    //qDebug() << "CTRL Byte 1 " << ((LED_MJR << 5) | ROW );
    //qDebug() << "CTRL Byte 2 " << ((LED_SET_MNR << 5) | COL);

    buffer.append(LED_SET_COLOR);

    quint8   flagbyte(0);
    if(RED)
    {
        flagbyte |= 0x04;
    }
    if(GREEN)
    {
        flagbyte |= 0x02;
    }
    if(BLUE)
    {
        flagbyte |= 0x01;
    }

   // qDebug() << flagbyte;
    buffer.append(flagbyte);
    if(RED)
        buffer.append(RED);
    if(GREEN)
        buffer.append(GREEN);
    if(BLUE)
        buffer.append(BLUE);

    buffer.append(FOTON_TERMINAL);
}

void  FotonLEDMessageFactory::createLEDClear(int led_num,QByteArray& buffer)
{

}

void  FotonLEDMessageFactory::createDrawLine(FOTON_LINE line, FOTON_RGB color,QByteArray& buffer)
{

}
