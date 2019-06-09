extends KinematicBody2D
class_name Entity

var m_type = "Enemy"
var m_speed = 0
var m_movedir = dir.center
var m_knockdir = dir.center
var m_spritedir = "down"

# An entity is in "hitstun" when they just took damage and are
# now temporarily invinsible.
var m_hitstun = 0
var m_health = 1

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

func movement_loop():
	var motion
	if m_hitstun == 0:
		motion = m_movedir.normalized() * m_speed
	else:
		motion = m_knockdir.normalized() * m_speed *  1.5

	move_and_slide(motion, Vector2(0,0))

func spritedir_loop():
	match m_movedir:
		dir.left:
			m_spritedir = "left"
		dir.right:
			m_spritedir = "right"
		dir.up:
			m_spritedir = "up"
		dir.down:
			m_spritedir = "down"

func damage_loop():
	if m_hitstun > 0:
		m_hitstun -= 1
	for body in $hitbox.get_overlapping_bodies():
		if m_hitstun == 0 and body.get("m_damage") != null and body.get("m_type") != m_type:
			m_health -= body.get("m_damage")
			m_hitstun = 10
			m_knockdir = transform.origin - body.transform.origin

func anim_switch(animation):
	var newanim = str(animation, m_spritedir)
	if $anim.current_animation != newanim:
		$anim.play(newanim)