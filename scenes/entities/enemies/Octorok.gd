extends Entity

var m_damage = 1

# Keeps track of when the enemy needs to move next.
var m_movetimer_length = 20
var m_movetimer = 0

func _ready():
	m_speed = 28
	m_movedir = dir.rand()

func _physics_process(delta):
	movement_loop()
	spritedir_loop()
	damage_loop()

	if m_movetimer > 0:
		m_movetimer -= 1
	if m_movetimer == 0 || is_on_wall():
		m_movedir = dir.rand()
		m_movetimer = m_movetimer_length

	anim_switch("idle")