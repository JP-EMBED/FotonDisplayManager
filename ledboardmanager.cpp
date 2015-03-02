#include "ledboardmanager.h"
#include <QDebug>
#include "serialconnectionmanager.h"
#include "connectionmanager.h"
LedBoardManager::LedBoardManager(iConnection *connection, QObject *parent) :
    QObject(parent), mLedBoardConnection(nullptr)
{
    mLedBoardConnection = connection;

}


void LedBoardManager::connectToBoard(QString name, QString address)
{
    mLedBoardConnection->connectToDevice(name,address);
}


void LedBoardManager::changeConnectionType(QString type)
{
    if(mLedBoardConnection)
    {
        disconnect(mLedBoardConnection, &ConnectionManager::foundDevice,
                this, &LedBoardManager::foundDevice);
        disconnect(mLedBoardConnection, &ConnectionManager::finishedScanning,
                this, &LedBoardManager::finishedScanning);
        disconnect(mLedBoardConnection, &ConnectionManager::deviceConnected,
                this, &LedBoardManager::connectedToLedBoard);
        delete mLedBoardConnection;
    }
    if(type.startsWith('U'))
    {
        mLedBoardConnection = new SerialConnectionManager();
        connect(mLedBoardConnection, &ConnectionManager::foundDevice,
                this, &LedBoardManager::foundDevice);
        connect(mLedBoardConnection, &ConnectionManager::finishedScanning,
                this, &LedBoardManager::finishedScanning);
        connect(mLedBoardConnection, &ConnectionManager::deviceConnected,
                this, &LedBoardManager::connectedToLedBoard);
    }
    else
    {
       mLedBoardConnection = new ConnectionManager();
       connect(mLedBoardConnection, &ConnectionManager::foundDevice,
               this, &LedBoardManager::foundDevice);
       connect(mLedBoardConnection, &ConnectionManager::finishedScanning,
               this, &LedBoardManager::finishedScanning);
       connect(mLedBoardConnection, &ConnectionManager::deviceConnected,
               this, &LedBoardManager::connectedToLedBoard);
    }
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

void LedBoardManager::sendClearBoard()
{
    QByteArray message;
    mMessageFactory.createLEDClear(message);
    mLedBoardConnection->sendMessage(message);
}

void LedBoardManager::sendLedColor(QColor color)
{
    QByteArray message;
    mMessageFactory.createLEDSetColor(color.red(),color.green(),color.blue(), message);
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

LedBoardManager::~LedBoardManager()
{
    if(mLedBoardConnection)
        delete mLedBoardConnection;
}
