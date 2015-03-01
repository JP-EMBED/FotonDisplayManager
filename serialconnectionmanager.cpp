#include "serialconnectionmanager.h"
#include <QSerialPortInfo>
#include <QStringList>
#include <QDebug>
SerialConnectionManager::SerialConnectionManager(QObject *parent) :
    iConnection(parent)
{
    connect(&mSerialPort, SIGNAL(error(QSerialPort::SerialPortError)),
            this, SLOT(serialDisconnected(QSerialPort::SerialPortError)));

}


bool SerialConnectionManager::isConnected()
{
   return (mSerialPort.isReadable() |  mSerialPort.isWritable());
}

void SerialConnectionManager::scanForDevices(QString filter_type)
{
    QList<QSerialPortInfo>  ports(QSerialPortInfo::availablePorts());
    foreach(const QSerialPortInfo & port,ports )
    {
        QString name = port.description();
        QString desc = port.portName();
        QStringList last;
        last.append(port.description());

        qDebug() << "Port Name: " << port.portName() << "\nDescription : " << desc << "\n";
        //if(port.description().contains("CC3200"))
        emit foundDevice(name, desc, last);
    }
}


void SerialConnectionManager::sendMessage(QByteArray message)
{
    mSerialPort.write(message);
}
void SerialConnectionManager::connectToDevice(QString device_name, QString addr, QString pin)
{
    emit finishedScanning();
    mSerialPort.setBaudRate(1382400);
    QSerialPortInfo port_info(addr);
    mSerialPort.setPort(port_info);
    mSerialPort.open(QIODevice::ReadWrite);
    emit deviceConnected();

}



void SerialConnectionManager::serialDisconnected(QSerialPort::SerialPortError error)
{
    if( error == QSerialPort::DeviceNotFoundError)
        emit deviceDisconnected();
}
void SerialConnectionManager::connectToTargetSocket(){}
void SerialConnectionManager::deviceDiscovered(){}

SerialConnectionManager::~SerialConnectionManager()
{

}
