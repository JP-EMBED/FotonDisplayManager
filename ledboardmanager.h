#ifndef LEDBOARDMANAGER_H
#define LEDBOARDMANAGER_H

#include <QObject>
#include "iConnection.h"
#include "connectionmanager.h"
#include "fotonledmessagefactory.h"
#include <QColor>
class QColor;
class LedBoardManager : public QObject
{
    Q_OBJECT
public:
    explicit LedBoardManager(iConnection * connection,QObject *parent = 0);
    ~LedBoardManager();
signals:
    void foundLedBoard(QString dname, QString dmac);
    void connectedToLedBoard();
    void finishedScanning();
public slots:

    void findLedBoard();
    void connectToBoard(QString name, QString address);
    void sendLedSet(int row, int col);
    void sendClearBoard();
    void requestDevicePair(QString name, QString address);
    void sendLedColor(QColor color);
    void changeConnectionType(QString type);

private slots:
    void foundDevice(QString dname, QString dmac, QStringList dservice);

    void devicePaired(QString name, QString address);



private:
    iConnection  *              mLedBoardConnection;
    FotonLEDMessageFactory      mMessageFactory;

};

#endif // LEDBOARDMANAGER_H
