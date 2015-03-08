#include "serialconnectionmanager.h"
#ifdef NOT_ANDROID_OS
#include <QSerialPortInfo>
#endif
#include <QStringList>
#include <QDebug>
SerialConnectionManager::SerialConnectionManager(QObject *parent) :
    iConnection(parent)
{
    #ifdef NOT_ANDROID_OS
    connect(&mSerialPort, SIGNAL(error(QSerialPort::SerialPortError)),
            this, SLOT(serialDisconnected(QSerialPort::SerialPortError)));
    #endif
}


bool SerialConnectionManager::isConnected()
{
   #ifdef NOT_ANDROID_OS
   return (mSerialPort.isReadable() |  mSerialPort.isWritable());
   #else
    return false;
   #endif
}

void SerialConnectionManager::scanForDevices(QString filter_type)
{
    #ifdef NOT_ANDROID_OS
    QList<QSerialPortInfo>  ports(QSerialPortInfo::availablePorts());
    foreach(const QSerialPortInfo & port,ports )
    {
        QString name = port.portName();
        QString desc = port.description();
        QStringList last;
        last.append(port.description());

        qDebug() << "Port Name: " << port.portName() << "\nDescription : " << desc << "\n";
        //if(port.description().contains("CC3200"))
        emit foundDevice(desc, name, last);
    }
    #endif
}


void SerialConnectionManager::sendMessage(QByteArray message)
{
    #ifdef NOT_ANDROID_OS
    mSerialPort.write(message);
    #endif
}
void SerialConnectionManager::connectToDevice(QString device_name, QString addr, QString pin)
{
    #ifdef NOT_ANDROID_OS
    emit finishedScanning();
    mSerialPort.setBaudRate(1382400);
    QSerialPortInfo port_info(addr);
    mSerialPort.setPort(port_info);
    mSerialPort.open(QIODevice::ReadWrite);
    emit deviceConnected();
    #endif

}


#ifdef NOT_ANDROID_OS
void SerialConnectionManager::serialDisconnected(QSerialPort::SerialPortError error)
{

    if( error == QSerialPort::DeviceNotFoundError)
        emit deviceDisconnected();

}
#endif
void SerialConnectionManager::connectToTargetSocket(){}
void SerialConnectionManager::deviceDiscovered(){}

SerialConnectionManager::~SerialConnectionManager()
{

}
