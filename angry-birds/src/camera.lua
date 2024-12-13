-- camera.lua

-- ## Физика:

-- 1. Позиция камеры: Камера смещается, чтобы центрировать объект в указанной позиции.
-- 2. Режим следования: Когда активирован, камера будет следовать за объектом, иначе плавно возвращается в исходное положение.
-- 3. Масштабирование: Камера применяет масштаб для увеличения или уменьшения изображения.
-- 4. Плавное возвращение: Камера возвращается в начальную позицию с интерполяцией, регулируемой через скорость возвращения (returnSpeed).
-- 5. Обновление: Каждую итерацию камера либо следует за объектом, либо возвращается в начальное положение.

local camera = {
    x = 0,
    y = 0,
    scale = 1,
    width = 800,
    height = 600,
    initialX = 0,
    initialY = 0,
    isFollowing = false,  -- Флаг отслеживания
    returnSpeed = 5,  -- Скорость возвращения камеры (чем выше значение, тем быстрее)
    birdsDestroyed = 0,  -- Количество уничтоженных птичек
    blocksDestroyed = 0  -- Количество уничтоженных блоков
}

-- Функция для установки позиции камеры
function camera.setPosition(x, y)
    camera.x = x - camera.width / 2
    camera.y = y - camera.height / 2
end

-- Включение/выключение режима следования
function camera.setFollowMode(enabled)
    camera.isFollowing = enabled
end

-- Применение трансформации камеры
function camera.apply()
    love.graphics.push()
    love.graphics.translate(-camera.x, -camera.y)
    love.graphics.scale(camera.scale)
end

-- Сброс трансформации
function camera.reset()
    love.graphics.pop()
end

-- Плавное возвращение камеры в начальное положение
function camera.resetPosition()
    -- Интерполяция позиции камеры
    local targetX = camera.initialX
    local targetY = camera.initialY

    -- Камера плавно возвращается к начальной позиции
    camera.x = camera.x + (targetX - camera.x) / camera.returnSpeed
    camera.y = camera.y + (targetY - camera.y) / camera.returnSpeed
end

-- Метод для обновления камеры
function camera.update(dt)
    if not camera.isFollowing then
        camera.resetPosition()
    end
end

-- Функция для отображения статистики
function camera.drawStats()
    love.graphics.setColor(1, 1, 1)  -- Белый цвет для текста
    love.graphics.print("Pigs Destroyed: " .. camera.birdsDestroyed, camera.x + camera.width - 200, camera.y + 20)
    love.graphics.print("Blocks Destroyed: " .. camera.blocksDestroyed, camera.x + camera.width - 200, camera.y + 40)
end

return camera
