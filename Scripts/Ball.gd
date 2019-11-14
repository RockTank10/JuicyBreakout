extends RigidBody2D

export var maxspeed = 300
onready var Bouncewall=get_node("/root/World/Bouncewall")
onready var hit_tile=get_node("/root/World/hit tile")
onready var hit_paddle=get_node("/root/World/hit paddle")
signal lives
signal score

func _ready():
 contact_monitor = true
 set_max_contacts_reported(4)
 var WorldNode = get_node("/root/World")
 connect("score", WorldNode, "increase_score")
 connect("lives", WorldNode, "decrease_lives")

func _physics_process(delta):
 var bodies = get_colliding_bodies()
 for body in bodies:
  if body.is_in_group("Tiles"):
   emit_signal("score",body.score)
   hit_tile.playing = true
   body.queue_free()
  if body.get_name() == "Paddle":
   hit_paddle.playing = true
  if body.get_name()=="Wall":
   Bouncewall.playing = true
  
 if position.y > get_viewport_rect().end.y:
  emit_signal("lives")
  queue_free()