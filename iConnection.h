#ifndef ICONNECTION_H
#define ICONNECTION_H

#include <QObject>
#include <QString>
#include <QStringList>
class iConnection : public QObject
{
    Q_OBJECT
    public:
        iConnection(QObject *p)
           : QObject(p)
        {

        }

        //virtual bool isConnected(){}

    signals:
        void deviceConnected();
        void deviceDisconnected();
        void foundDevice(QString dname, QString dmac, QStringList dservice);
        void finishedScanning();

    public slots:
        virtual void scanForDevices(QString filter_type){Q_UNUSED(filter_type)}
        virtual void stopScanning(){}
        virtual void sendMessage(QByteArray message){}
        virtual void connectToDevice(QString device_name, QString addr, QString pin = ""){}
};


#endif // ICONNECTION_H
