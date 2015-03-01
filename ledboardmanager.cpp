#include "ledboardmanager.h"
#include <QDebug>
LedBoardManager::LedBoardManager(iConnection *connection, QObject *parent) :
    QObject(parent)
{
    mLedBoardConnection = connection;
    connect(mLedBoardConnection, &ConnectionManager::foundDevice,
            this, &LedBoardManager::foundDevice);
    connect(mLedBoardConnection, &ConnectionManager::finishedScanning,
            this, &LedBoardManager::finishedScanning);
    connect(mLedBoardConnection, &ConnectionManager::deviceConnected,
            this, &LedBoardManager::connectedToLedBoard);
}


void LedBoardManager::connectToBoard(QString name, QString address)
{
    mLedBoardConnection->connectToDevice(name,address);
}


void LedBoardManager::findLedBoard()
{
    mLedBoardConnection->scanForDevices("");
}

void LedBoardManager::foundDevice(QString dname, QString dmac, QStringList dservice)
{
    //qDebug() << "Found " << dname << " With services " << dservice << " at MAC " << dmac;
   // if(dname.contains("LED Board"))
   // {
        emit foundLedBoard(dname,dmac);
   // }

}



void LedBoardManager::devicePaired(QString name, QString address)
{

}


void LedBoardManager::requestDevicePair(QString name, QString address)
{

}


void LedBoardManager::sendLedColor(QColor color)
{
    QByteArray message;
    mMessageFactory.createLEDSetColor(color.red(),color.blue(),color.green(), message);
    //qDebug() << "sending LedSetColor" << message;
    mLedBoardConnection->sendMessage(message);
}

void LedBoardManager::sendLedSet(int row, int col)
{
    QByteArray message;
    mMessageFactory.createLEDSet(row,col, message);
    //qDebug() << "sending LedSet" << message;
    mLedBoardConnection->sendMessage(message);
}
