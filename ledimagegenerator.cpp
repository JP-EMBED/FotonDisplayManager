#include "ledimagegenerator.h"

LEDImageGenerator::LEDImageGenerator(QQmlEngine *engine)
    : QObject(nullptr), mPicture(QPixmap(640,480)), mEngine(engine)
{

}

LEDImageGenerator::~LEDImageGenerator()
{

}


void LEDImageGenerator::setPicture(const QString &path, int x, int y)
{
    // Fetch the Image from the camera
    QUrl imageUrl(path);
    QQmlImageProviderBase* imageProviderBase = mEngine->imageProvider(imageUrl.host());
    QQuickImageProvider* imageProvider = static_cast<QQuickImageProvider*>(imageProviderBase);

    QSize imageSize;
    QString imageId = imageUrl.path().remove(0,1);
    QImage image = imageProvider->requestImage(imageId, &imageSize, imageSize);


    // if the image is not null begin cropping and scaling
    if( !image.isNull()) {
        QImage cropped_data(320,320, image.format());
        cropped_data = image.copy(x,y,320,320);
        QVector<QRgb> colorTable = cropped_data.colorTable();
        QImage converted_image = cropped_data.convertToFormat(QImage::Format_RGB888,colorTable);
        QImage small_pmap = cropped_data.scaled(32,32);
        for(int row = 0; row < 32; row++)
        {
            for(int col = 0; col < 32; col++)
            {
                QRgb  rgb(small_pmap.pixel(row,col));
                QColor color(rgb);
                emit updatedLed(col,row,color);
            }
        }
    }
    else
    {
        emit failedToSetToLEDBoard();
    }
    emit finishedGeneratingImage();

}
