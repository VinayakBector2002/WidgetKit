# WidgetKit
A place to experiment with WidgetKit. This readme has notes from official apple video about WidgetKit and glimpse of my applications. 

# WWDC 2020 : Widget Kit Notes
## [Meet WidgetKit](https://developer.apple.com/videos/play/wwdc2020/10028/)

### Widgets are NOT mini apps
Should project content from application than having tiny buttons!

### Goals for a Great Widget Experience
- Glanceble
- Relevant
- Personalized

Widget kit is build entirely on SwiftUI - making it cross platform.

--- 
# WidgetKit Course By [Sean Allen](https://youtu.be/jucm6e9M6LA)
![monthly-theme](Images/monthly-theme.jpeg)
<img src="https://github.com/VinayakBector2002/WidgetKit/blob/main/Images/Mountain.png" width="265" height="230"/>
<img src="https://github.com/VinayakBector2002/WidgetKit/blob/main/Images/Roller%20Coaster.png" width="265" height="230"/>
<img src="https://github.com/VinayakBector2002/WidgetKit/blob/main/Images/Date%20with%20Icecream.png" width="265" height="230"/>

## Color and Emoji Generation 

A Color was made by using Random RGB Values as follows

```Swift

// Keep in mind that it should be Double and NOT Int
let redValue = Double.random(in: 1...255)
let blueValue = Double.random(in: 1...255)
let greenValue = Double.random(in: 1...255)

// Making the Color
let baseColor =  Color(red:redValue/255,green:greenValue/255,blue:blueValue/255)

```

For the text I wanted a complementory Color, which was made using the RGB values of Base Color

```Swift

// RBG Values of the baseColor
func complementColorGen(red: Double, green: Double, blue: Double) -> Color {
  // r' = max(r,b,g) + min(r,b,g) - r
  // b' = max(r,b,g) + min(r,b,g) - b
  // g' = max(r,b,g) + min(r,b,g) - g
  let axis : Double = max(red,blue,green) + min(red,blue,green)
  let redValue = axis - red
  let blueValue = axis - blue
  let greenValue = axis - green
  return Color(red:redValue/255,green:greenValue/255,blue:blueValue/255)
}

```

And, for producing a random Emoji - used the following code

```Swift

func RandEmojGen() -> String {
  return String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!)
}

```
