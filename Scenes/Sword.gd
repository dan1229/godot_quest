extends VR_Interactable_Rigidbody

const SWORD_DAMAGE = 2

const COLLISION_FORCE = 0.15

var damage_body = null
var sword_noise = null

func _ready():
	damage_body = get_node("Damage_Body")
	damage_body.add_collision_exception_with(self)
	sword_noise = get_node("AudioStreamPlayer3D")


func _physics_process(_delta):

	var collision_results = damage_body.move_and_collide(Vector3.ZERO, true, true, true);

	if (collision_results != null):
		if collision_results.collider.has_method("damage"):
			collision_results.collider.damage(SWORD_DAMAGE)

		if collision_results.collider is RigidBody:
			if controller == null:
				collision_results.collider.apply_impulse(
					collision_results.position,
					collision_results.normal * linear_velocity * COLLISION_FORCE)
			else:
				collision_results.collider.apply_impulse(
					collision_results.position,
					collision_results.normal * controller.controller_velocity * COLLISION_FORCE)

		sword_noise.play()
