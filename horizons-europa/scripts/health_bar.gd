extends TextureProgressBar

# Full health reads light pink, draining toward a deep pink as it empties.
const FULL_COLOR := Color("ffb6c1")
const EMPTY_COLOR := Color("8b1a52")


func _ready() -> void:
	value_changed.connect(_on_value_changed)
	_update_tint()


func _on_value_changed(_new_value: float) -> void:
	_update_tint()


func _update_tint() -> void:
	var ratio := 0.0
	if max_value > min_value:
		ratio = (value - min_value) / (max_value - min_value)

	tint_progress = EMPTY_COLOR.lerp(FULL_COLOR, ratio)
