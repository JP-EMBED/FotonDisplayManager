import QtQuick 2.4

//Color Picker
Rectangle
{
    property alias pickedColor: colorPreveiw.color
    id: colorPicker
    width: Screen.height/3; height: Screen.height * 3/5
    color:"#403939"

    Row
    {
        anchors.fill: parent
        //veiwer / text boxes
        Column
        {
            id: colorInfo
            width: colorPicker.width *4/15
            height: colorPicker.height

            Rectangle
            {
                width: parent.width
                height: parent.height/4
                CheckerBoard {cellSide: 6}
                Rectangle
                {
                    id: colorPreveiw
                    width: parent.width; height: parent.height
                    border.width: 1; border.color: "black"
                    color: hsba(hueSlider.value, sbPicker.saturation, sbPicker.value, alphaSlider.value)
                }
            }
            PanelBorder
            {
                id: colorEditBox
                height: parent.height/12; width: parent.width
                TextInput
                {
                    height: parent.height
                    width: parent.width
                    color: "#AAAAAA"
                    selectionColor: "#FF7777AA"
                    font.pixelSize: height
                    maximumLength: 9
                    text: colorPreveiw.color
                    selectByMouse: true
                }
            }
            NumberBox
            {
                id: hueBox
                width: parent.width; height: parent.height/12
                caption: "H:"; value: Math.ceil(hueSlider.value *360)
                max: 360
                Connections
                {
                    target: hueBox.inputBox
                    onAccepted:
                    {
                        hueSlider.cursory = hueSlider.height * (1 - hueBox.value/360)
                    }
                }
            }
            NumberBox
            {
                id: satBox
                width: parent.width; height: parent.height/12
                caption: "S:"; value: Math.ceil(sbPicker.saturation*255)
                Connections
                {
                    target: satBox.inputBox
                    onAccepted:
                    {
                        sbPicker.cursorx = sbPicker.width * (satBox.value/255)
                    }
                }
            }
            NumberBox
            {
                id: brightBox
                width: parent.width; height: parent.height/12
                caption: "B:"; value: Math.ceil(sbPicker.value*255)
                Connections
                {
                    target: brightBox.inputBox
                    onAccepted:
                    {
                        sbPicker.cursory = sbPicker.height * (1 - brightBox.value/255)
                    }
                }
            }
            Rectangle
            {
                color: "transparent"
                height:parent.height/24
                width: parent.width
            }

            NumberBox
            {
                id:redBox
                width: parent.width; height: parent.height/12
                caption: "R:"; value: getChannelStr(colorPreveiw.color, 0)
                min: 0; max: 255
                Connections
                {
                    target: redBox.inputBox
                    onAccepted:
                    {
                        var red = redBox.value/255;
                        var green = greenBox.value/255;
                        var blue = blueBox.value/255
                        hueSlider.cursory = hueSlider.height * (1 - calculateHue(red, green, blue)/360)
                        sbPicker.cursorx  = sbPicker.width   * (calculateSat(red, green, blue))
                        sbPicker.cursory  = sbPicker.height  * (1 - calculateVal(red, green, blue))
                    }
                }
            }
            NumberBox
            {
                id:greenBox
                width: parent.width; height: parent.height/12
                caption: "G:"; value: getChannelStr(colorPreveiw.color, 1)
                min: 0; max: 255
                Connections
                {
                    target: greenBox.inputBox
                    onAccepted:
                    {
                        var red = redBox.value/255;
                        var green = greenBox.value/255;
                        var blue = blueBox.value/255
                        hueSlider.cursory = hueSlider.height * (1 - calculateHue(red, green, blue)/360)
                        sbPicker.cursorx  = sbPicker.width   * (calculateSat(red, green, blue))
                        sbPicker.cursory  = sbPicker.height  * (1 - calculateVal(red, green, blue))
                    }
                }
            }
            NumberBox
            {
                id:blueBox
                width: parent.width; height: parent.height/12
                caption: "B:"; value: getChannelStr(colorPreveiw.color, 2)
                min: 0; max: 255
                Connections
                {
                    target: blueBox.inputBox
                    onAccepted:
                    {
                        var red = redBox.value/255;
                        var green = greenBox.value/255;
                        var blue = blueBox.value/255
                        hueSlider.cursory = hueSlider.height * (1 - calculateHue(red, green, blue)/360)
                        sbPicker.cursorx  = sbPicker.width   * (calculateSat(red, green, blue))
                        sbPicker.cursory  = sbPicker.height  * (1 - calculateVal(red, green, blue))
                    }
                }
            }
            Rectangle
            {
                color: "transparent"
                height:parent.height/24
                width: parent.width
            }
            NumberBox
            {
                id:alphaBox
                width: parent.width; height: parent.height/12
                caption: "A:"; value: Math.ceil(alphaSlider.value*255)
                Connections
                {
                    target: alphaBox.inputBox
                    onAccepted:
                    {
                        alphaSlider.cursory = alphaSlider.height * (1 - alphaBox.value/255)
                    }
                }
            }
        }
        Rectangle
        {
            width: (parent.width - (parent.width*349/900 + parent.height))/2
            height:parent.height
            color:"transparent"
        }

        //Gradient veiwer
        SBPicker
        {
            id:sbPicker
            height: parent.height; width: parent.height
            hueColor: hsba(hueSlider.value, 1.0, 1.0, 1.0)

        }

        Rectangle
        {
            width: (parent.width - (parent.width*349/900 + parent.height))/2
            height: parent.height
            color: "transparent"
        }

        //hue Picker
        Rectangle
        {
            width: parent.width/18
            height: sbPicker.height

            gradient: Gradient
            {
                GradientStop { position: 1.0;  color: "#FF0000" }
                GradientStop { position: 0.85; color: "#FFFF00" }
                GradientStop { position: 0.76; color: "#00FF00" }
                GradientStop { position: 0.5;  color: "#00FFFF" }
                GradientStop { position: 0.33; color: "#0000FF" }
                GradientStop { position: 0.16; color: "#FF00FF" }
                GradientStop { position: 0.0;  color: "#FF0000" }
            }
            ColorSlider { id:hueSlider; width: parent.width}
        }
        Rectangle
        {
            width:parent.width/100
            height:parent.height
            color:"transparent"
        }

        //alphaPicker
        Item
        {
            id: alphaPicker
            width: parent.width/18
            height: sbPicker.height
            CheckerBoard{cellSide: 5}

            //  alpha intensity gradient background
            Rectangle
            {
                anchors.fill: parent
                gradient: Gradient
                {
                    GradientStop { position: 0.0; color: "#FF000000" }
                    GradientStop { position: 1.0; color: "#00000000" }
                }
            }
            ColorSlider { id:alphaSlider;width: parent.width}
        }
    }
    function getChannelStr(clr, channelIdx)
    {
        return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16);
    }

    function hsba(h, s, b, a)
    {
        var lightness = (2 - s)*b;
        var satHSL = s*b/((lightness <= 1) ? lightness : 2 - lightness);
        lightness /= 2;
        return Qt.hsla(h, satHSL, lightness, a);
    }

    function calculateHue(R, G, B)
    {
        var min = R < G ? (R < B ? R : B): (G < B ? G : B);
        var hue;


        if (R == G && G == B)
        {
            hue = 0;
        }
        else if ( B >= R && B >= G)
        {
            hue = ((Math.abs(R-G)/(B-min)) + 4);
        }
        else if ( G > R && G >= B)
        {
            hue = ((Math.abs(B-R)/(G-min)) + 2);
        }
        else
        {
            hue = ((Math.abs(G-B)/(R-min)) % 6);
        }



        return (hue*60)
    }

    function calculateSat(R, G, B)
    {
        var min = R < G ? (R < B ? R : B): (G < B ? G : B);
        var sat;

        if ( R >= G && R >= B && R != 0)
        {
            sat = ((R-min)/R);
        }
        else if ( G > R && G >= B && B != 0)
        {
            sat = ((G-min)/G);
        }
        else if (B != 0)
        {
            sat = ((B-min)/B);
        }
        else
        {
            sat = 0;
        }

        return sat;
    }

    function calculateVal(R, G, B)
    {
        var max

        if ( R >= G && R >= B)
        {
            max = R;
        }
        else if ( G > R && G >= B)
        {
            max = G;
        }
        else
        {
            max = B;
        }

        return max;
    }
}

