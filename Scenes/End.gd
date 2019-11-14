extends Node2D

onready var Lose=get_node("/root/World/Lose")

func music():
  Lose.playing = true
