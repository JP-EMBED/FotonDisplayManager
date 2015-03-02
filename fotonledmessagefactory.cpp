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


    buffer.append(RED);

    buffer.append(GREEN);

    buffer.append(BLUE);
}

void  FotonLEDMessageFactory::createLEDClear(QByteArray& buffer)
{

    buffer.append(LED_CLEAR);


    buffer.append(75);

    buffer.append(75);

    buffer.append(75);
}

void  FotonLEDMessageFactory::createDrawLine(FOTON_LINE line, FOTON_RGB color,QByteArray& buffer)
{

}
