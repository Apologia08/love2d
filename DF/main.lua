require "strict"

require "game"
require "player"

function love.load()
    print("Init")

    Game:Initialize()
    Player:Initialize()

end

function love.draw()
    Game:DrawBullet()
    Game:DrawEnemy()

    Player:Draw()

    Game:DrawUI()
end

enemyTimer = 1
curSpeed = 100
maxSpeed = 500

function love.update()
    local deltaTime = love.timer.getDelta()

    enemyTimer = enemyTimer + deltaTime

    --1초마다 적을 생성
    if enemyTimer>1 then
        --최대 속도보다 적으면 스피드 100씩 증가
        if curSpeed < maxSpeed then
            Game:GenerateEnemy(curSpeed)
            curSpeed = curSpeed + 100
        else
            Game:GenerateEnemy(maxSpeed)
        end
        enemyTimer = 0

    end

    Game:UpdateBullet(deltaTime)
    Game:UpdateEnemy(deltaTime)
    Player:Update(deltaTime)
end
