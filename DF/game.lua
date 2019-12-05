Game =
{
    imageBullet = love.graphics.newImage("assets/bullet.png"),
    imageEnemy = love.graphics.newImage("assets/enemy.png"),

    bulletDelay = 0,
    bulletList = {},

    enemyDelay = 0,
    enemyList = {},

    Score = 0,
}

function Game:Initialize()
    self.Score = 0

    self.bulletList = {}
    for i = 0, 30 do
        self.bulletList[i] =
        {
            x = 0,
            y = 0,
            speed = 500,

            isActive = false,
        }
    end

    for i = 0, 49 do
        self.enemyList[i] =
        {
            x = 0,
            y = 0,
            speed = 100,

            isActive = false,
        }
    end
end

function Game:DrawUI()
    love.graphics.print("Score : "..Game.Score, 0, 0)
end

function Game:DrawBullet()
    for _k, bullet in pairs(self.bulletList) do
        if bullet.isActive == true then
            love.graphics.draw(self.imageBullet, bullet.x, bullet.y)
        end
    end
end

function Game:DrawEnemy()
    for _k, enemy in pairs(self.enemyList) do
        if enemy.isActive == true then
            love.graphics.draw(self.imageEnemy, enemy.x, enemy.y)
        end
    end
end

function Game:UpdateBullet(deltaTime)
    for _k, bullet in pairs(self.bulletList) do
        if bullet.isActive == true then
            bullet.y = bullet.y - bullet.speed * deltaTime
            if bullet.y < -10 then
                bullet.isActive = false
            end
        end
    end
end

function Game:UpdateEnemy(deltaTime)
    for _k, enemy in pairs(self.enemyList) do
        if enemy.isActive == true then
            --이동속도에 따라 적들이 이동
            enemy.y = enemy.y + enemy.speed * deltaTime

            if enemy.y > 960 then
                enemy.isActive = false
            end
            --플레이어와 적이 충돌하는 지 체크
            if enemy.x < Player.x + 70 and Player.x < enemy.x + 70 and enemy.y < Player.y + 70 and Player.y < enemy.y + 70 then
                love.event.quit()
            end
            --총알과 적이 충돌하는 지 체크
            for _i, bullet in pairs(self.bulletList) do
                if bullet.isActive == true then
                    if enemy.x < bullet.x and bullet.x < enemy.x + 100 and enemy.y < bullet.y and bullet.y < enemy.y + 90 then
                        enemy.isActive = false
                        bullet.isActive = false
                        self.Score = self.Score + 10
                        break
                    end
                end
            end
        end
    end
end

function Game:Fire(x, y)
    for _k, bullet in pairs(self.bulletList) do
        if bullet.isActive == false then
            bullet.isActive = true
            bullet.x = x + 50 -- image center
            bullet.y = y
            return
        end
    end
end

--적 생성
function Game:GenerateEnemy(speed)
    local width = love.graphics.getWidth() / 5
    local count = 0
    for _k, enemy in pairs(self.enemyList) do
        if enemy.isActive == false then
            enemy.isActive = true
            enemy.x = width * count
            enemy.y = 0
            enemy.speed = speed
            count = count + 1
            if count == 5 then
                return
            end
        end
    end
end
