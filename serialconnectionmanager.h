#ifndef SERIALCONNECTIONMANAGER_H
#define SERIALCONNECTIONMANAGER_H

#include "iConnection.h"
#include <QSerialPort>
class SerialConnectionManager : public iConnection
{

    Q_OBJECT
public:
    explicit SerialConnectionManager(QObject *parent = 0);
    ~SerialConnectionManager();
    bool isConnected();


public slots:
    void scanForDevices(QString filter_type);
    void sendMessage(QByteArray message);
    void connectToDevice(QString device_name, QString addr, QString pin = "");

protected slots:
    void serialDisconnected(QSerialPort::SerialPortError error);
    void connectToTargetSocket();
    void deviceDiscovered();

protected:
    QStringList serviceEnumToStrList();

    QSerialPort      mSerialPort;

};

#endif // SERIALCONNECTIONMANAGER_H
