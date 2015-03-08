#ifndef SERIALCONNECTIONMANAGER_H
#define SERIALCONNECTIONMANAGER_H

#define NOT_ANDROID_OS
#include "iConnection.h"
#ifdef NOT_ANDROID_OS
#include <QSerialPort>
#endif
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
    #ifdef NOT_ANDROID_OS
    void serialDisconnected(QSerialPort::SerialPortError error);
    #endif
    void connectToTargetSocket();
    void deviceDiscovered();

protected:
    QStringList serviceEnumToStrList();
#ifdef NOT_ANDROID_OS
    QSerialPort      mSerialPort;
#endif
};

#endif // SERIALCONNECTIONMANAGER_H
