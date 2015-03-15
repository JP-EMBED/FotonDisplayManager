#ifndef LEDIMAGEGENERATOR_H
#define LEDIMAGEGENERATOR_H

#include <QObject>
#include <QPixmap>
#include <QImage>
#include <QQuickImageProvider>
#include <QQmlImageProviderBase>
#include <QDebug>
#include <QColor>

class LEDImageGenerator : public QObject
{
    Q_OBJECT
public:
    explicit LEDImageGenerator(QQmlEngine * engine);
    ~LEDImageGenerator();
    Q_INVOKABLE void setPicture(const QString &path, int x, int y);

signals:
    void failedToSetToLEDBoard();
    void updatedLed(int row_in, int col_in, QColor color_in);
    void finishedGeneratingImage();
public slots:

private:
    QRgb generateConvertedColor(QRgb rgb);
    void convertColorTable(QImage& image);
    QPixmap      mPicture;
    QQmlEngine * mEngine;

};

#endif // LEDIMAGEGENERATOR_H
