extends TextureRect

func setProcessBar(value: float, max_value: float) -> void:
	$TextureProgressBar.value = value / max_value * 100
