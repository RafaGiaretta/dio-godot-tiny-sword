class_name Enemy
extends Node2D

@export var health : int = 10
@export var death_prefer: PackedScene

@onready var damage_digit_marker = $DamageDigitMarker

var damage_digit_prefab: PackedScene


func _ready():
	damage_digit_prefab = preload("res://misc/damage_digit.tscn")


func damage(amount: int) -> void:
	health -= amount
	print("Teste dano:", amount,  " vida total: ", health)
	
	# Sinalizar dano
	modulate = Color.RED
	var tween =  create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_QUINT)
	
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)

	var damage_digit = damage_digit_prefab.instantiate()
	damage_digit.value = amount
	if damage_digit_marker:
		damage_digit.global_position = damage_digit_marker.global_position
	else: 
		damage_digit.global_position = global_position
	get_parent().add_child(damage_digit)
	
	if health <= 0:
		die()
		
		
func die() -> void:
	if death_prefer:
		var death_object = death_prefer.instantiate()
		death_object.position = position
		get_parent().add_child(death_object)
		
	queue_free()