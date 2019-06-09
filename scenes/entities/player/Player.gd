extends Entity

func _ready():
	m_speed = 70
	m_type = "Player"

func _physics_process(delta):
	controls_loop()
	movement_loop()
	damage_loop()
	spritedir_loop()

	if m_movedir != Vector2(0,0):
		anim_switch("walk")
	else:
		anim_switch("idle")

func controls_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")

	m_movedir.x = -int(LEFT) + int(RIGHT)
	m_movedir.y = -int(UP) + int(DOWN)

	# The orgignal game does not allow you to move
	# LEFT and RIGHT while moving UP or DOWN.
	if m_movedir.x != 0:
		m_movedir.y = 0