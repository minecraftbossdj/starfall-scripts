--@name RenderButtonClass
--@author retarded puppygirl
--@client

class = {}
class.__index = class

class.x = 0
class.y = 0
class.buttonMaxX = 0
class.buttonMaxY = 0
class.highlightColor = Color(255,255,255)
class.buttonColor = Color(100, 100, 100)
class.textLocalX = 0
class.textLocalY = 0
class.text = ""
class.textColor = Color(0, 0, 0)
class.buttonFunc = nil

function isInside(x, y, maxX, maxY, checkX, checkY)
    if checkX > x and checkY > y and checkX < maxX and checkY < maxY then
        return true
    else
        return false
    end
end

function class:new(x, y, buttonMaxX, buttonMaxY, buttonColor, highlightColor, textLocalX, textLocalY, text, textColor, buttonFunc)
    local obj = {}
    class.x = x
    class.y = y
    class.buttonMaxX = buttonMaxX
    class.buttonMaxY = buttonMaxY
    class.highlightColor = highlightColor
    class.buttonColor = buttonColor
    class.textLocalX = textLocalX
    class.textLocalY = textLocalY
    class.text = text
    class.textColor = textColor
    class.buttonFunc = buttonFunc
    setmetatable(obj, class)
    return obj
end

function class:render()
    local cursX, cursY = render.cursorPos(owner(), nil)
    local oldColor = render.getColor()

    --button
    render.setColor(self.buttonColor)
    render.drawRect(self.x, self.y, self.buttonMaxX, self.buttonMaxY)

    --text
    render.setColor(self.textColor)
    render.drawText(self.x+self.textLocalX, self.y+self.textLocalY, self.text)

    --button highlight
    if cursX ~= nil and isInside(self.x, self.y, self.buttonMaxX, self.buttonMaxY, cursX, cursY) then
        render.setColor(self.highlightColor)
        render.drawRect(self.x, self.y, self.buttonMaxX, self.buttonMaxY)
    end
    render.setColor(oldColor)
end

function class:processClick()
    local cursX, cursY = render.cursorPos(owner(), nil)

    if cursX ~= nil and isInside(self.x, self.y, self.buttonMaxX, self.buttonMaxY, cursX, cursY) then
        self.buttonFunc(self)
    end
end


return class
