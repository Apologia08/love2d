Player =
{
    image = nil,

    x = 200,
    y = 830,

    speed = 800,

    fireTime = 0,
}

function Player:Initialize()
    self.image = love.graphics.newImage("assets/player.png")
    self.fireTime = 0
end

function Player:Draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:Update(deltaTime)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * deltaTime
    end

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * deltaTime
    end

    self.fireTime = self.fireTime - deltaTime
    if self.fireTime < 0 then
        self.fireTime = 0.1
        Game:Fire(self.x, self.y)
    end
end
