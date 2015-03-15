#include "ledimagegenerator.h"
#include <QRgb>
LEDImageGenerator::LEDImageGenerator(QQmlEngine *engine)
    : QObject(nullptr), mPicture(QPixmap(640,480)), mEngine(engine)
{

}

LEDImageGenerator::~LEDImageGenerator()
{

}




void LEDImageGenerator::convertColorTable(QImage &image)
{
    QVector<QRgb> old_table = image.colorTable();
    QVector<QRgb> new_table;
    for(int color_count = 0; color_count < old_table.length(); color_count++)
    {
        // Calculate next color
        QRgb led_value ( generateConvertedColor(old_table[color_count]));
        new_table.append(led_value);
        image.setColor(color_count,led_value);
    }
    image.setColorTable(new_table);
}

QRgb LEDImageGenerator::generateConvertedColor(QRgb rgb)
{
    int red  (qRed(rgb));
    int green(qGreen(rgb));
    int blue (qBlue(rgb));
    if((red <25) &&  ( green < 25) &&( blue < 25) )
       return 0;
    if((red +green + blue + 10)/3 > 175)
       return 0xffffffff;
    unsigned int color = 0xffffffff;
    if(red > 0)
    {
        if(green > 0) // Found YELLOW or WHITE
        {
            if(blue > 0 ) // Found WHITE OR a Variation on Yellow
            {
                if((blue > red) && (blue > green) )
                {
                    if(green > red)
                    {
                        color = ((green << 8));
                        color += blue;
                    }
                    else
                    {
                        if((red > 85) ^ ((red-blue) <20))
                        {
                            color = ((red <<16));
                            color += blue;
                        }
                        else
                        {
                            // Found BLUE
                            if(blue > 220) // Brightest
                                return (220);
                            else if(blue > 165 )
                                return (165);
                            else if(blue > 110)
                                return (110);
                            else
                                return (57); // Dimmest
                        }
                    }
                }
                else if((red > blue) && (red > green)) //  If Red is the largest!
                {
                    if(green > blue)
                    {
                        if((green >= 135) ^ ((red-green) <20))
                        {
                            color = ((red << 16) ^  (green << 8));
                        }
                        else // settle for red
                        {
                            if(red > 220) // Brightest Red
                                return (220 << 16);
                            else if(red > 165 )
                                return (165 << 16);
                            else if(red > 110)
                                return (110 << 16);
                            else
                                return (57 << 16); // Dimmest Red
                        }
                    }
                    else
                    {
                        if((blue >= 135) ^ ((red-blue) <20))
                        {
                            color = ((red << 16));
                            color += blue;
                        }
                        else // settle for red
                        {
                            if(red > 220) // Brightest Red
                                return (220 << 16);
                            else if(red > 165 )
                                return (165 << 16);
                            else if(red > 110)
                                return (110 << 16);
                            else
                                return (57 << 16); // Dimmest Red
                        }
                    }
                }
                else // green is largest
                {
                    if(red > blue)
                    {
                        color = ((red << 16) ^  (green << 8));
                        if((red >= 135) ^ ((green-red) <20))
                        {
                            color = ((red << 16) ^  (green << 8));
                        }
                        else // settle for red
                        {
                            // Found Green
                            if(green > 220) // Brightest
                                return (220 << 8);
                            else if(green > 165 )
                                return (165 << 8);
                            else if(green > 110)
                                return (110 << 8);
                            else
                                return (57 << 8); // Dimmest
                        }
                    }
                    else
                    {
                        if((blue >= 135) ^ ((green-blue) <20))
                        {
                            color = ((green << 8));
                            color += blue;
                        }
                        else
                        {
                            // Found Green
                            if(green > 220) // Brightest
                                return (220 << 8);
                            else if(green > 165 )
                                return (165 << 8);
                            else if(green > 110)
                                return (110 << 8);
                            else
                                return (57 << 8); // Dimmest
                        }
                    }
                }
                return color;
            }
        }
        else
        {
            if(blue > 0)// Found PURPLE
            {
                if(red > blue ) // HAS RED BASE
                {
                    if(red > 220) // Brightest Red
                       return (56377 << 8);
                    else if(red > 165 )
                       return (42297 << 8);
                    else if(red > 110)
                       return (28217 << 8);
                    else
                       return (14649 << 8); // Dimmest Red
                }
                else // Else Hase Blue Base
                {
                    if(blue > 220) // Brightest Red
                       return (14812 << 8);
                    else if(blue > 165 )
                       return (14757 << 8);
                    else if(blue > 110)
                       return (14702 << 8);
                    else
                       return (14649 << 8); // Dimmest Blue
                }
            }
            else// Found RED
            {
                if(red > 220) // Brightest Red
                    return (220 << 16);
                else if(red > 165 )
                    return (165 << 16);
                else if(red > 110)
                    return (110 << 16);
                else
                    return (57 << 16); // Dimmest Red
            }
        }
    }
    else if(blue > 0)
    {
        if(green > 0) // Found TEAL
        {
            color = ((green << 8));
            color += blue;
            return color;
        }
        else
        {
            // Found BLUE
            if(blue > 220) // Brightest
                return (220);
            else if(blue > 165 )
                return (165);
            else if(blue > 110)
                return (110);
            else
                return (57); // Dimmest
        }
    }
    else if(green> 0)
    {
        // Found Green
        if(green > 220) // Brightest
            return (220 << 8);
        else if(green > 165 )
            return (165 << 8);
        else if(green > 110)
            return (110 << 8);
        else
            return (57 << 8); // Dimmest
    }
    return 0;
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
        //QVector<QRgb> colorTable = cropped_data.colorTable();
       // QImage converted_image = cropped_data.convertToFormat(QImage::Format_RGB888);
       // convertColorTable(converted_image);
        QImage small_pmap = cropped_data.scaled(32,32);
        for(int row = 0; row < 32; row++)
        {
            for(int col = 0; col < 32; col++)
            {
                QColor color(generateConvertedColor(small_pmap.pixel(row,col)));
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
