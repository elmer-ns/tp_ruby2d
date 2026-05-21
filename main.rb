require 'ruby2d'

set title: "Game", background: "red"

GRAVITY = 9.81 # m/s
SCALE = 0.01 # game units -> meters

class Ball < Circle
    MASS = 0.045 # kg
    RADIUS = 0.05 # m

    @vx
    @vy

    def initialize(vx, vy)
        super()

        @vx = vx / SCALE
        @vy = vy / SCALE
        @radius = RADIUS / SCALE

        puts "Spawning player"
    end

    def move(dt)
        p @x
        p @y
        p @radius

        @x += @vy * dt / SCALE
        @y += @vy * dt / SCALE
    end

    def friction(friction_coefficient, dt)
        normal_force = MASS * GRAVITY
        friction_force = friction_coefficient * normal_force
        deceleration = friction_force / MASS

        v = Math.sqrt(@vx ** 2 + @vy ** 2)
        new_v = [v - deceleration * dt / SCALE, 0].max

        if v == new_v 
            return
        end

        change = new_v / v

        @x *= change
        @y *= change
    end
end

player = Ball.new(0,0)

@last_time = Time.now

update do
    current_time = Time.now
    dt = current_time - @last_time
    @last_time = current_time

    player.move(dt)
    player.friction(1, dt)
end



show